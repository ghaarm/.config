-- -- Bild in der Vorschau öffnen und automatisch die Werkzeugleiste öffnen

vim.keymap.set("n", "ga", function()
  local fullpath

  if vim.bo.filetype == "oil" then
    local oil = require("oil")
    local entry = oil.get_cursor_entry()
    local dir = oil.get_current_dir()

    if not entry or not dir then
      vim.notify("Kein Oil-Dateieintrag gefunden.", vim.log.levels.WARN)
      return
    end

    if entry.type == "directory" then
      vim.notify("Der ausgewählte Eintrag ist ein Ordner.", vim.log.levels.WARN)
      return
    end

    fullpath = dir .. entry.name
  else
    local line = vim.fn.getline(".")
    local path = line:match("{([^}]*)}")

    if not path then
      vim.notify("Kein Pfad in geschweiften Klammern gefunden.", vim.log.levels.WARN)
      return
    end

    fullpath = vim.fs.normalize(vim.fs.joinpath(vim.fn.expand("%:p:h"), path))
  end

  vim.system({ "open", "-a", "Preview", fullpath }, {}, function(result)
    if result.code ~= 0 then
      vim.schedule(function()
        vim.notify("Datei konnte nicht geöffnet werden: " .. fullpath, vim.log.levels.ERROR)
      end)
      return
    end

    vim.system({
      "osascript",
      "-e",
      'tell application "System Events" to keystroke "A" using {shift down, command down}',
    })
  end)
end, {
  desc = "Datei oder Bild in Vorschau öffnen",
}) --
