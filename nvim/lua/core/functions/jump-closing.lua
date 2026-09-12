-- über die schließenden Klammern einzeln springen
local function jump_over_closing()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local line = vim.api.nvim_get_current_line()

  local closers = {
    [")"] = true,
    ["]"] = true,
    ["}"] = true,
    ['"'] = true,
    ["'"] = true,
    ["`"] = true,
  }

  local new_col = col

  while true do
    local next_char = line:sub(new_col + 1, new_col + 1)

    if not closers[next_char] then
      break
    end

    new_col = new_col + 1
  end

  if new_col ~= col then
    vim.api.nvim_win_set_cursor(0, { row, new_col })
  end
end

vim.keymap.set("i", "<C-y>", jump_over_closing, {
  desc = "Jump over closing characters",
})

-- über alle schließenden Klammern springen
-- local function jump_over_closing()
--   local row, col = unpack(vim.api.nvim_win_get_cursor(0))
--   local line = vim.api.nvim_get_current_line()
--
--   local closers = {
--     [")"] = true,
--     ["]"] = true,
--     ["}"] = true,
--     ['"'] = true,
--     ["'"] = true,
--     ["`"] = true,
--   }
--
--   local new_col = col
--
--   while true do
--     local next_char = line:sub(new_col + 1, new_col + 1)
--
--     if not closers[next_char] then
--       break
--     end
--
--     new_col = new_col + 1
--   end
--
--   if new_col ~= col then
--     vim.api.nvim_win_set_cursor(0, { row, new_col })
--   end
-- end
--
-- vim.keymap.set("i", "<C-l>", jump_over_closing, {
--   desc = "Jump over closing characters",
-- })
