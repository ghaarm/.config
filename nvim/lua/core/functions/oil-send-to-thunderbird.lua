local M = {}

function M.send_current_file()
  local oil = require("oil")

  if vim.bo.filetype ~= "oil" then
    vim.notify("Nur in Oil verfügbar", vim.log.levels.WARN)
    return
  end

  local entry = oil.get_cursor_entry()
  local dir = oil.get_current_dir()

  if not entry or not dir then
    vim.notify("Keine Datei ausgewählt", vim.log.levels.WARN)
    return
  end

  if entry.type == "directory" then
    vim.notify("Bitte eine Datei auswählen", vim.log.levels.WARN)
    return
  end

  local path = vim.fs.joinpath(dir, entry.name)

  if vim.fn.filereadable(path) ~= 1 then
    vim.notify("Datei nicht gefunden: " .. path, vim.log.levels.ERROR)
    return
  end

  local attachment = vim.uri_from_fname(path)

  local compose = string.format("attachment='%s'", attachment)

  vim.system({
    "/Applications/Thunderbird.app/Contents/MacOS/thunderbird",
    "-compose",
    compose,
  }, {
    detach = true,
  })
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = "oil",

  callback = function(args)
    vim.keymap.set("n", "<leader>mt", M.send_current_file, {
      buffer = args.buf,
      desc = "Datei mit Thunderbird senden",
    })
  end,
})

return M
