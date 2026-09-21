-- ~/.config/nvim/lua/core/functions/oil_copy_fuzzy.lua
-- braucht: oil.nvim, fd, telescope.nvim
--
-- <leader>cr = DRACOON-Verzeichnis-Cache aktualisieren
-- <leader>cz = Datei kopieren, Ziel aus Cache auswählen
-- <leader>cx = Datei kopieren + Ziel in Oil öffnen

local M = {}

local search_root = vim.fs.joinpath(
  vim.fn.expand("~"),
  "Library",
  "Application Support",
  "DRACOON",
  "Volumes.noindex",
  "DRACOON.localized"
)

-- Persistenter Cache
local cache_dir = vim.fn.stdpath("cache")
local cache_file = vim.fs.joinpath(cache_dir, "dracoon-directories.txt")

-- Verhindert mehrere gleichzeitige Refreshs
local cache_refresh_running = false

-- ---------------------------------------------------------
-- Oil: Datei unter Cursor ermitteln
-- ---------------------------------------------------------

local function get_oil_source()
  local oil = require("oil")

  local entry = oil.get_cursor_entry()
  local dir = oil.get_current_dir()

  if not entry or not dir then
    vim.notify("Keine Datei unter Cursor", vim.log.levels.WARN)
    return nil
  end

  return {
    name = entry.name,
    source = vim.fs.joinpath(dir, entry.name),
  }
end

-- ---------------------------------------------------------
-- Cache lesen
-- ---------------------------------------------------------

local function read_cache()
  local file = io.open(cache_file, "r")

  if not file then
    return nil
  end

  local dirs = {}

  for line in file:lines() do
    if line ~= "" then
      table.insert(dirs, line)
    end
  end

  file:close()

  return dirs
end

-- ---------------------------------------------------------
-- DRACOON-Cache manuell aktualisieren
-- ---------------------------------------------------------

function M.refresh_cache()
  if cache_refresh_running then
    vim.notify("DRACOON-Cache wird bereits aktualisiert", vim.log.levels.INFO)
    return
  end

  if vim.fn.isdirectory(search_root) ~= 1 then
    vim.notify("DRACOON-Verzeichnis nicht gefunden:\n" .. search_root, vim.log.levels.ERROR)
    return
  end

  cache_refresh_running = true

  vim.notify("DRACOON-Cache wird aktualisiert …", vim.log.levels.INFO)

  vim.system({
    "fd",
    "--type",
    "d",
    "--exclude",
    ".git",
    "--hidden",
    "--no-ignore",
    "--strip-cwd-prefix",
  }, {
    cwd = search_root,
    text = true,
  }, function(result)
    vim.schedule(function()
      cache_refresh_running = false

      if result.code ~= 0 then
        vim.notify("DRACOON-Cache konnte nicht aktualisiert werden:\n" .. (result.stderr or ""), vim.log.levels.ERROR)
        return
      end

      local output = result.stdout or ""

      local dirs = {}

      for line in output:gmatch("[^\r\n]+") do
        if line ~= "" then
          table.insert(dirs, line)
        end
      end

      table.sort(dirs)

      -- Cache-Verzeichnis sicherstellen
      vim.fn.mkdir(cache_dir, "p")

      -- Erst temporär schreiben.
      -- Dadurch bleibt der alte Cache erhalten,
      -- falls beim Schreiben etwas schiefgeht.
      local temp_file = cache_file .. ".tmp"

      local file, err = io.open(temp_file, "w")

      if not file then
        vim.notify("Cache konnte nicht geschrieben werden:\n" .. tostring(err), vim.log.levels.ERROR)
        return
      end

      for _, dir in ipairs(dirs) do
        file:write(dir .. "\n")
      end

      file:close()

      local ok, rename_err = os.rename(temp_file, cache_file)

      if not ok then
        vim.notify("Cache konnte nicht ersetzt werden:\n" .. tostring(rename_err), vim.log.levels.ERROR)
        return
      end

      vim.notify(string.format("DRACOON-Cache aktualisiert: %d Verzeichnisse", #dirs), vim.log.levels.INFO)
    end)
  end)
end

-- ---------------------------------------------------------
-- Telescope-Picker aus Cache
-- ---------------------------------------------------------

local function select_target_dir(callback)
  local dirs = read_cache()

  if not dirs or #dirs == 0 then
    vim.notify("Kein DRACOON-Cache vorhanden.\n" .. "Zuerst <leader>cr ausführen.", vim.log.levels.WARN)
    return
  end

  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")

  pickers
    .new({}, {
      prompt_title = "DRACOON Zielverzeichnis",

      finder = finders.new_table({
        results = dirs,
      }),

      sorter = conf.generic_sorter({}),

      previewer = false,

      attach_mappings = function(prompt_bufnr)
        actions.select_default:replace(function()
          local selection = action_state.get_selected_entry()

          if not selection then
            return
          end

          actions.close(prompt_bufnr)

          local relative_dir = selection.value or selection[1]

          if not relative_dir then
            vim.notify("Zielverzeichnis konnte nicht ermittelt werden", vim.log.levels.ERROR)
            return
          end

          local target_dir = vim.fs.normalize(vim.fs.joinpath(search_root, relative_dir))

          callback(target_dir)
        end)

        return true
      end,
    })
    :find()
end

-- ---------------------------------------------------------
-- Kopieren
-- ---------------------------------------------------------

local function copy_to_fuzzy_dir(change_dir)
  local source_info = get_oil_source()

  if not source_info then
    return
  end

  select_target_dir(function(target_dir)
    local target = vim.fs.joinpath(target_dir, source_info.name)

    vim.system({
      "cp",
      "-R",
      source_info.source,
      target,
    }, {
      text = true,
    }, function(result)
      vim.schedule(function()
        if result.code ~= 0 then
          vim.notify("Kopieren fehlgeschlagen:\n" .. (result.stderr or ""), vim.log.levels.ERROR)
          return
        end

        vim.notify("Kopiert nach:\n" .. target_dir)

        if change_dir then
          vim.cmd.enew()
          require("oil").open(target_dir)
        end
      end)
    end)
  end)
end

-- ---------------------------------------------------------
-- Öffentliche Funktionen
-- ---------------------------------------------------------

function M.copy_oil_file_fuzzy()
  copy_to_fuzzy_dir(false)
end

function M.copy_oil_file_fuzzy_and_cd()
  copy_to_fuzzy_dir(true)
end

-- ---------------------------------------------------------
-- Oil Keymaps
-- ---------------------------------------------------------

vim.api.nvim_create_autocmd("FileType", {
  pattern = "oil",

  callback = function(args)
    -- Cache manuell aktualisieren
    vim.keymap.set("n", "<leader>cr", function()
      M.refresh_cache()
    end, {
      buffer = args.buf,
      desc = "Oil: Refresh DRACOON cache",
    })

    -- Kopieren
    vim.keymap.set("n", "<leader>cz", function()
      M.copy_oil_file_fuzzy()
    end, {
      buffer = args.buf,
      desc = "Oil: Copy fuzzy DRACOON",
    })

    -- Kopieren + Ziel öffnen
    vim.keymap.set("n", "<leader>cx", function()
      M.copy_oil_file_fuzzy_and_cd()
    end, {
      buffer = args.buf,
      desc = "Oil: Copy + open target DRACOON",
    })
  end,
})

return M

-- ~/.config/nvim/lua/core/functions/oil_copy_fuzzy.lua
-- -- braucht: oil.nvim, fd, telescope.nvim
--
-- local M = {}
--
-- local search_root = vim.fs.joinpath(
--   vim.fn.expand("~"),
--   "Library",
--   "Application Support",
--   "DRACOON",
--   "Volumes.noindex",
--   "DRACOON.localized"
-- )
-- local function to_absolute_dir(path)
--   if not path or path == "" then
--     return nil
--   end
--
--   if path:sub(1, 1) ~= "/" then
--     path = vim.fs.joinpath(search_root, path)
--   end
--
--   return vim.fs.normalize(path):gsub("/+$", "")
-- end
--
-- local function get_oil_source()
--   local oil = require("oil")
--
--   local entry = oil.get_cursor_entry()
--   local dir = oil.get_current_dir()
--
--   if not entry or not dir then
--     vim.notify("Keine Datei unter Cursor", vim.log.levels.WARN)
--     return nil
--   end
--
--   return {
--     name = entry.name,
--     source = vim.fs.joinpath(dir, entry.name),
--   }
-- end
--
-- local function copy_to_fuzzy_dir(change_dir)
--   local source_info = get_oil_source()
--
--   if not source_info then
--     return
--   end
--
--   local builtin = require("telescope.builtin")
--   local actions = require("telescope.actions")
--   local action_state = require("telescope.actions.state")
--
--   -- local search_root = "/Users/g/Library/Mobile Documents/com~apple~CloudDocs/!Docs iCloud"
--
--   builtin.find_files({
--     prompt_title = "Zielverzeichnis",
--     cwd = search_root,
--     previewer = false,
--     find_command = {
--       "fd",
--       "--type",
--       "d",
--       "--exclude",
--       ".git",
--       "--hidden",
--       "--no-ignore",
--       "--strip-cwd-prefix",
--     },
--     attach_mappings = function(prompt_bufnr)
--       actions.select_default:replace(function()
--         local selection = action_state.get_selected_entry()
--
--         if not selection then
--           return
--         end
--
--         actions.close(prompt_bufnr)
--
--         local target_dir = to_absolute_dir(selection.path or selection.filename or selection.value or selection[1])
--
--         if not target_dir then
--           vim.notify("Zielverzeichnis konnte nicht ermittelt werden", vim.log.levels.ERROR)
--           return
--         end
--
--         local target = vim.fs.joinpath(target_dir, source_info.name)
--
--         vim.system({
--           "cp",
--           "-R",
--           source_info.source,
--           target,
--         }, {
--           text = true,
--         }, function(result)
--           vim.schedule(function()
--             if result.code ~= 0 then
--               vim.notify("Kopieren fehlgeschlagen:\n" .. (result.stderr or ""), vim.log.levels.ERROR)
--               return
--             end
--
--             vim.notify("Kopiert nach:\n" .. target_dir)
--
--             if change_dir then
--               vim.cmd.enew()
--               require("oil").open(target_dir)
--             end
--           end)
--         end)
--       end)
--
--       return true
--     end,
--   })
-- end
--
-- function M.copy_oil_file_fuzzy()
--   copy_to_fuzzy_dir(false)
-- end
--
-- function M.copy_oil_file_fuzzy_and_cd()
--   copy_to_fuzzy_dir(true)
-- end
--
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "oil",
--
--   callback = function(args)
--     vim.keymap.set("n", "<leader>cz", function()
--       M.copy_oil_file_fuzzy()
--     end, {
--       buffer = args.buf,
--       desc = "Oil: Copy fuzzy DRACOON",
--     })
--
--     vim.keymap.set("n", "<leader>cx", function()
--       M.copy_oil_file_fuzzy_and_cd()
--     end, {
--       buffer = args.buf,
--       desc = "Oil: Copy + open target DRACOON",
--     })
--   end,
-- })
--
--
-- return M
