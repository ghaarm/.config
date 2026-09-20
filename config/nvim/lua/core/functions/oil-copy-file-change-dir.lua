-- ~/.config/nvim/lua/core/functions/oil_copy_fuzzy.lua
-- braucht: oil.nvim, fd, telescope.nvim

local M = {}

local search_root = "/Users/g/Library/Mobile Documents/com~apple~CloudDocs"

local function to_absolute_dir(path)
  if not path or path == "" then
    return nil
  end

  if path:sub(1, 1) ~= "/" then
    path = vim.fs.joinpath(search_root, path)
  end

  return vim.fs.normalize(path):gsub("/+$", "")
end

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

local function copy_to_fuzzy_dir(change_dir)
  local source_info = get_oil_source()

  if not source_info then
    return
  end

  local builtin = require("telescope.builtin")
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")

  -- local search_root = "/Users/g/Library/Mobile Documents/com~apple~CloudDocs/!Docs iCloud"

  builtin.find_files({
    prompt_title = "Zielverzeichnis",
    cwd = search_root,
    previewer = false,
    find_command = {
      "fd",
      "--type",
      "d",
      "--exclude",
      ".git",
      "--hidden",
      "--no-ignore",
      "--strip-cwd-prefix",
    },
    attach_mappings = function(prompt_bufnr)
      actions.select_default:replace(function()
        local selection = action_state.get_selected_entry()

        if not selection then
          return
        end

        actions.close(prompt_bufnr)

        local target_dir = to_absolute_dir(selection.path or selection.filename or selection.value or selection[1])

        if not target_dir then
          vim.notify("Zielverzeichnis konnte nicht ermittelt werden", vim.log.levels.ERROR)
          return
        end

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

      return true
    end,
  })
end

function M.copy_oil_file_fuzzy()
  copy_to_fuzzy_dir(false)
end

function M.copy_oil_file_fuzzy_and_cd()
  copy_to_fuzzy_dir(true)
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = "oil",

  callback = function(args)
    vim.keymap.set("n", "<leader>cc", function()
      M.copy_oil_file_fuzzy()
    end, {
      buffer = args.buf,
      desc = "Oil: Copy fuzzy",
    })

    vim.keymap.set("n", "<leader>cm", function()
      M.copy_oil_file_fuzzy_and_cd()
    end, {
      buffer = args.buf,
      desc = "Oil: Copy + open target",
    })
  end,
})

return M
