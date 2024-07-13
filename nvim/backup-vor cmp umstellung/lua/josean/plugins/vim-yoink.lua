return {
  "svermeulen/vim-yoink",
  config = function()
    -- Tastenkombinationen für vim-yoink
    vim.api.nvim_set_keymap("n", "<c-n>", "<plug>(YoinkPostPasteSwapBack)", { noremap = false, silent = true })
    vim.api.nvim_set_keymap("n", "<c-p>", "<plug>(YoinkPostPasteSwapForward)", { noremap = false, silent = true })
    vim.api.nvim_set_keymap("n", "p", "<plug>(YoinkPaste_p)", { noremap = false, silent = true })
    vim.api.nvim_set_keymap("n", "P", "<plug>(YoinkPaste_P)", { noremap = false, silent = true })
    vim.api.nvim_set_keymap("n", "gp", "<plug>(YoinkPaste_gp)", { noremap = false, silent = true })
    vim.api.nvim_set_keymap("n", "gP", "<plug>(YoinkPaste_gP)", { noremap = false, silent = true })
  end,
}
