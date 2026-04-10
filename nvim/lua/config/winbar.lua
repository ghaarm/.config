-- -- tj devries https://www.youtube.com/watch?v=LKW_SUucO-k&list=PLMLyZFWQbxIzctnJSWserv5InbRwHm-oW&index=24
-- --
local M = {}
local dir_levels = 1 -- anzahl der directories

local function tail_path(path, n_dirs)
  if path == "" then
    return "[No Name]"
  end

  local parts = vim.split(path, "/", { plain = true })

  if #parts <= n_dirs + 1 then
    return table.concat(parts, "/")
  end

  local start_idx = #parts - n_dirs
  local out = {}

  for i = start_idx, #parts do
    table.insert(out, parts[i])
  end

  return table.concat(out, "/")
end

function M.render()
  local bt = vim.bo.buftype
  local ft = vim.bo.filetype
  local name = vim.api.nvim_buf_get_name(0)

  -- Alpha-Startseite ausblenden
  -- if ft == "alpha" then
  --   return ""
  -- end
  if ft == "alpha" or ft == "oil" or name == "" then
    return ""
  end
  -- unbenannten/leeren Buffer ausblenden
  if name == "" then
    return ""
  end
  local path = vim.fn.expand("%:p")
  local shown = tail_path(path, dir_levels)
  return "%=%m " .. shown
end

function M.setup()
  vim.o.winbar = "%!v:lua.require'config.winbar'.render()"
end

return M
