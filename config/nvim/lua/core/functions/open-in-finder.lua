-- function OpenInFinder()
--   local dir = vim.fn.expand('%:p:h')
--   vim.fn.system('open ' .. dir)
-- end
--
--- Funktion zum Öffnen des Finders im aktuellen Verzeichnis
-- function OpenInFinder()
--   local dir = vim.fn.expand("%:p:h")
--   os.execute('open "' .. dir .. '"')
-- end
local function system_open(path)
  if vim.fn.has("mac") == 1 then
    vim.system({ "open", path })
  elseif vim.fn.has("win32") == 1 then
    vim.system({ "explorer", path })
  else
    vim.system({ "xdg-open", path })
  end
end

function OpenInFinder()
  local path

  -- Wenn wir in oil sind: echtes Verzeichnis holen
  if vim.bo.filetype == "oil" then
    local ok, oil = pcall(require, "oil")
    if ok and oil.get_current_dir then
      path = oil.get_current_dir()
    end
  end

  -- Normaler Buffer: Verzeichnis der Datei
  if not path or path == "" then
    path = vim.fn.expand("%:p:h")
  end

  -- Fallback: aktuelles working dir
  if not path or path == "" then
    path = vim.loop.cwd()
  end

  system_open(path)
end
