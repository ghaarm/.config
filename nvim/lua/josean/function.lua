-- ~/.config/nvim/lua/function.lua
local M = {}

-- Funktion, um den aktuellen Chunk auszuführen
function M.RunCurrentChunk()
  local knitr = require("knitr")
  local current_pos = vim.api.nvim_win_get_cursor(0)
  local line = current_pos[1]

  -- Finde den Chunk an der aktuellen Cursor-Position
  local chunk = knitr.get_chunk_at_line(line)
  if chunk then
    -- Führe den Chunk aus
    knitr.run_chunk(chunk)
  else
    print("Kein Chunk an der aktuellen Position gefunden.")
  end
end

return M
