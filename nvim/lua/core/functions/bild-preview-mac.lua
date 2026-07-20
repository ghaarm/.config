-- -- Bild in der Vorschau öffnen und automatisch die Werkzeugleiste öffnen

-- vim.keymap.set("n", "ga", function()
--   local fullpath
--
--   if vim.bo.filetype == "oil" then
--     local oil = require("oil")
--     local entry = oil.get_cursor_entry()
--     local dir = oil.get_current_dir()
--
--     if not entry or not dir then
--       vim.notify("Kein Oil-Dateieintrag gefunden.", vim.log.levels.WARN)
--       return
--     end
--
--     if entry.type == "directory" then
--       vim.notify("Der ausgewählte Eintrag ist ein Ordner.", vim.log.levels.WARN)
--       return
--     end
--
--     fullpath = dir .. entry.name
--   else
--     local line = vim.fn.getline(".")
--     local path = line:match("{([^}]*)}")
--
--     if not path then
--       vim.notify("Kein Pfad in geschweiften Klammern gefunden.", vim.log.levels.WARN)
--       return
--     end
--
--     fullpath = vim.fs.normalize(vim.fs.joinpath(vim.fn.expand("%:p:h"), path))
--   end
--
--   vim.system({ "open", "-a", "Preview", fullpath }, {}, function(result)
--     if result.code ~= 0 then
--       vim.schedule(function()
--         vim.notify("Datei konnte nicht geöffnet werden: " .. fullpath, vim.log.levels.ERROR)
--       end)
--       return
--     end
--
--     vim.system({
--       "osascript",
--       "-e",
--       'tell application "System Events" to keystroke "A" using {shift down, command down}',
--     })
--   end)
-- end, {
--   desc = "Datei oder Bild in Vorschau öffnen",
-- }) --

-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "oil",
--
--   callback = function(event)
--     vim.keymap.set("n", "<leader>ga", function()
--       local oil = require("oil")
--       local entry = oil.get_cursor_entry()
--       local dir = oil.get_current_dir()
--
--       if not entry or not dir then
--         vim.notify("Kein Oil-Dateieintrag unter dem Cursor.", vim.log.levels.WARN)
--         return
--       end
--
--       if entry.type == "directory" then
--         vim.notify("Ordner können nicht in Preview geöffnet werden.", vim.log.levels.WARN)
--         return
--       end
--
--       local extension = entry.name:match("%.([^./]+)$")
--       extension = extension and extension:lower()
--
--       local allowed = {
--         png = true,
--         jpg = true,
--         jpeg = true,
--       }
--
--       if not extension or not allowed[extension] then
--         vim.notify("Preview-Mapping ist nur für PNG- und JPEG-Dateien vorgesehen.", vim.log.levels.INFO)
--         return
--       end
--       local fullpath = vim.fs.normalize(vim.fs.joinpath(dir, entry.name))
--
--       vim.system({
--         "open",
--         "-a",
--         "Preview",
--         fullpath,
--       }, {
--         text = true,
--       }, function(result)
--         if result.code ~= 0 then
--           vim.schedule(function()
--             vim.notify(
--               "PNG konnte nicht geöffnet werden:\n" .. fullpath .. "\n" .. (result.stderr or ""),
--               vim.log.levels.ERROR
--             )
--           end)
--           return
--         end
--
--         vim.defer_fn(function()
--           vim.system({
--             "osascript",
--             "-e",
--             [[
--               tell application "Preview" to activate
--               delay 0.2
--               tell application "System Events"
--                 keystroke "A" using {shift down, command down}
--               end tell
--             ]],
--           })
--         end, 300)
--       end)
--     end, {
--       buffer = event.buf,
--       silent = true,
--       nowait = true,
--       desc = "PNG aus Oil in Preview öffnen",
--     })
--   end,
-- })
--
local function open_image_in_preview()
  -- In Oil nichts ausführen.
  if vim.bo.filetype == "oil" then
    return
  end

  -- Nur in LaTeX und Markdown aktiv.
  local allowed_filetypes = {
    tex = true,
    plaintex = true,
    markdown = true,
  }

  if not allowed_filetypes[vim.bo.filetype] then
    vim.notify("Bildvorschau ist nur in TeX- und Markdown-Dateien aktiv.", vim.log.levels.INFO)
    return
  end

  local line = vim.api.nvim_get_current_line()
  local relative_path = line:match("{([^}]+)}")

  if not relative_path then
    vim.notify("Kein Pfad in geschweiften Klammern gefunden.", vim.log.levels.WARN)
    return
  end

  local extension = relative_path:match("%.([^./]+)$")
  extension = extension and extension:lower()

  local image_extensions = {
    png = true,
    jpg = true,
    jpeg = true,
  }

  if not extension or not image_extensions[extension] then
    vim.notify("Der gefundene Pfad ist keine PNG- oder JPEG-Datei.", vim.log.levels.INFO)
    return
  end

  local buffer_directory = vim.fn.expand("%:p:h")

  local fullpath = vim.fs.normalize(vim.fs.joinpath(buffer_directory, relative_path))

  if vim.fn.filereadable(fullpath) ~= 1 then
    vim.notify("Bilddatei nicht gefunden:\n" .. fullpath, vim.log.levels.ERROR)
    return
  end

  vim.system({
    "open",
    "-a",
    "Preview",
    fullpath,
  }, {
    text = true,
  }, function(result)
    if result.code ~= 0 then
      vim.schedule(function()
        vim.notify(
          "Bild konnte nicht geöffnet werden:\n" .. fullpath .. "\n" .. (result.stderr or ""),
          vim.log.levels.ERROR
        )
      end)
      return
    end

    vim.defer_fn(function()
      vim.system({
        "osascript",
        "-e",
        [[
          tell application "Preview" to activate
          delay 0.2
          tell application "System Events"
            keystroke "A" using {shift down, command down}
          end tell
        ]],
      })
    end, 300)
  end)
end

-- vim.keymap.set("n", "<leader>ga", open_image_in_preview, {
vim.keymap.set("n", "ga", open_image_in_preview, {
  silent = true,
  desc = "Bildpfad in Preview öffnen",
})

return open_image_in_preview
