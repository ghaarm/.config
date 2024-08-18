-- -- function um Pfad im Finder zu öffnen
-- function OpenInFinder()
--   local dir = vim.fn.expand('%:p:h')
--   vim.fn.system('open ' .. dir)
-- end
--
--- Funktion zum Öffnen des Finders im aktuellen Verzeichnis
function OpenInFinder()
  local dir = vim.fn.expand('%:p:h')
  os.execute('open "' .. dir .. '"')
end
