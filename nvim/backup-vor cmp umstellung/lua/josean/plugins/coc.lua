-- return {
--   {
--     "neoclide/coc.nvim",
--     branch = "release",
--     -- lazy = true, -- Lädt das Plugin nur, wenn es benötigt wird
--     -- ft = { "tex" }, -- Lade nur für .tex Dateien
--   },
--   {
--     "iamcco/coc-spell-checker",
--     -- lazy = true, -- Lädt das Plugin nur, wenn es benötigt wird
--     -- ft = { "tex" }, -- Lade nur für .tex Dateien
--     run = "yarn install --frozen-lockfile", -- abhängig von deiner umgebung könnte 'npm install' auch funktionieren
--   },
-- }

-- return {
--   {
--     "neoclide/coc.nvim",
--     branch = "release",
--     config = function()
--       -- Always show the signcolumn, otherwise it would shift the text each time
--       -- diagnostics appeared/became resolved
--       vim.opt.signcolumn = "yes"
--
--       local keyset = vim.keymap.set
--       -- Autocomplete
--       function _G.check_back_space()
--           local col = vim.fn.col('.') - 1
--           return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
--       end
--
--       -- Use Tab for trigger completion with characters ahead and navigate
--       -- NOTE: There's always a completion item selected by default, you may want to enable
--       -- no select by setting `"suggest.noselect": true` in your configuration file
--       -- NOTE: Use command ':verbose imap <tab>' to make sure Tab is not mapped by
--       -- other plugins before putting this into your config
--       local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
--       keyset("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
--       keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)
--
--       -- Make <CR> to accept selected completion item or notify coc.nvim to format
--       -- <C-g>u breaks current undo, please make your own choice
--       keyset("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)
--     end
--   },
--   {
--     "iamcco/coc-spell-checker",
--     run = "yarn install --frozen-lockfile", -- abhängig von deiner umgebung könnte 'npm install' auch funktionieren
--   },
--
--}

-- return {
--   {
--     "neoclide/coc.nvim",
--     branch = "release",
--     config = function()
--       -- Always show the signcolumn, otherwise it would shift the text each time
--       -- diagnostics appeared/became resolved
--       vim.opt.signcolumn = "yes"
--
--       local keyset = vim.keymap.set
--       -- Autocomplete
--       function _G.check_back_space()
--         local col = vim.fn.col(".") - 1
--         return col == 0 or vim.fn.getline("."):sub(col, col):match("%s") ~= nil
--       end
--
--       -- Use Tab for trigger completion with characters ahead and navigate
--       -- NOTE: There's always a completion item selected by default, you may want to enable
--       -- no select by setting `"suggest.noselect": true` in your configuration file
--       -- NOTE: Use command ':verbose imap <tab>' to make sure Tab is not mapped by
--       -- other plugins before putting this into your config
--       local opts = { silent = true, noremap = true, expr = true, replace_keycodes = false }
--       keyset(
--         "i",
--         "<TAB>",
--         'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()',
--         opts
--       )
--       keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)
--
--       -- Make <CR> to accept selected completion item or notify coc.nvim to format
--       -- <C-g>u breaks current undo, please make your own choice
--       -- keyset("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)
--       -- soll keinen Absatz mehr reinmachen nach dem Auswählen mit enter
--       keyset("i", "<cr>", [[coc#pum#visible() ? "\<C-y>" : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)
--     end,
--   },
--   {
--     "iamcco/coc-spell-checker",
--     run = "yarn install --frozen-lockfile", -- abhängig von deiner umgebung könnte 'npm install' auch funktionieren
--   },
-- }

return {
  {
    "neoclide/coc.nvim",
    branch = "release",
    config = function()
      -- Always show the signcolumn
      vim.opt.signcolumn = "yes"

      -- Hier lädst du deine Tastaturkürzel aus dem core Ordner
      require("josean.core.keybindings").setup_coc_keybindings()
    end,
  },
  {
    "iamcco/coc-spell-checker",
    run = "yarn install --frozen-lockfile", -- abhängig von deiner umgebung könnte 'npm install' auch funktionieren
  },
}
