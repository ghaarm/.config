local M = {}

function M.check_for_cite()
    local line = vim.api.nvim_get_current_line()
    local col = vim.api.nvim_win_get_cursor(0)[2] + 1
    local before_cursor = line:sub(1, col)
    if before_cursor:match("\\cite%{$") then
        vim.cmd("Telescope bibtex")
    end
end

-- Setze das Keymapping direkt hier
vim.api.nvim_set_keymap('i', '{', '{<cmd>lua require("cite").check_for_cite()<CR>', {noremap = true, silent = true})

return M
