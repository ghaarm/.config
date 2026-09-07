local M = {}

local function get_target_path()
  if vim.bo.filetype == "oil" then
    local oil = require("oil")
    local entry = oil.get_cursor_entry()
    local dir = oil.get_current_dir()

    if not dir then
      return nil
    end

    if entry then
      return vim.fs.normalize(vim.fs.joinpath(dir, entry.name))
    end

    return vim.fs.normalize(dir)
  end

  local path = vim.api.nvim_buf_get_name(0)

  if path == "" then
    return nil
  end

  return vim.fs.normalize(path)
end

function M.open_in_yazi()
  local target = get_target_path()

  if not target then
    vim.notify("Kein gültiger Pfad gefunden.", vim.log.levels.WARN)
    return
  end

  if vim.fn.executable("yazi") ~= 1 then
    vim.notify("yazi wurde im PATH nicht gefunden.", vim.log.levels.ERROR)
    return
  end

  local cwd

  if vim.fn.isdirectory(target) == 1 then
    cwd = target
  else
    cwd = vim.fs.dirname(target)
  end

  vim.notify("Öffne in Yazi:\n" .. target)

  vim.system({
    "open",
    "-na",
    "kitty",
    "--args",
    "--directory",
    cwd,
    "yazi",
    target,
  }, {
    text = true,
  }, function(result)
    if result.code ~= 0 then
      vim.schedule(function()
        vim.notify("Kitty/Yazi Fehler:\n" .. (result.stderr or "unbekannter Fehler"), vim.log.levels.ERROR)
      end)
    end
  end)
end

vim.keymap.set("n", "<leader>y", M.open_in_yazi, {
  noremap = true,
  silent = true,
  desc = "Aktuelle Datei in neuem Kitty/Yazi öffnen",
})

return M
