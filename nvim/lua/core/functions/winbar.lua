-- tj devries https://www.youtube.com/watch?v=LKW_SUucO-k&list=PLMLyZFWQbxIzctnJSWserv5InbRwHm-oW&index=24
--
local M = {}
local dir_levels = 1

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
  local winid = vim.g.statusline_winid or vim.api.nvim_get_current_win()
  local bufnr = vim.api.nvim_win_get_buf(winid)

  local ft = vim.bo[bufnr].filetype
  local name = vim.api.nvim_buf_get_name(bufnr)
  local modified = vim.bo[bufnr].modified and "[+]" or ""

  -- Alpha-Startseite ausblenden
  if ft == "alpha" or ft == "oil" then
    return ""
  end

  -- unbenannten/leeren Buffer ausblenden
  -- if name == "" then
  --   return ""
  -- end

  local shown = tail_path(name, dir_levels)
  return "%=" .. modified .. " " .. shown
end

function M.setup()
  vim.o.winbar = "%!v:lua.require'core.functions.winbar'.render()"
end

return M
