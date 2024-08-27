-- Ben Brast McKie
-- GRUVBOX
-- return {
--   "ellisonleao/gruvbox.nvim",
--   priority = 1000, -- make sure to load this before all the other start plugins
--   config = function()
--     require("gruvbox").setup({
--       overrides = {
--         -- THIS BLOCK
--         SignColumn = { bg = "#282828" },
--         NvimTreeCutHL = { fg = "#fb4934", bg = "#282828" },
--         NvimTreeCopiedHL = { fg = "#b8bb26", bg = "#282828" },
--         DiagnosticSignError = { fg = "#fb4934", bg = "#282828" },
--         DiagnosticSignWarn = { fg = "#fabd2f", bg = "#282828" },
--         DiagnosticSignHint = { fg = "#8ec07c", bg = "#282828" },
--         DiagnosticSignInfo = { fg = "#d3869b", bg = "#282828" },
--         -- OR THIS BLOCK
--         -- NvimTreeCutHL = { fg="#fb4934", bg="#3c3836" },
--         -- NvimTreeCopiedHL = { fg="#b8bb26", bg="#3c3836" }
--         -- END
--       }
--     })

--     vim.cmd("colorscheme gruvbox")
--   end,
-- }

-- GRUVBOX Flat
-- return {
--   "eddyekofo94/gruvbox-flat.nvim",
--
--   priority = 1000,
--   enabled = true,
--   config = function()
--     vim.cmd([[colorscheme gruvbox-flat]])
--   end,
-- }

-- https://github.com/rebelot/kanagawa.nvim
-- return {
--   "rebelot/kanagawa.nvim",
--
--   priority = 1000,
--   enabled = true,
--   config = function()
--     vim.cmd("colorscheme kanagawa")
--     -- vim.cmd [[highlight SpellBad ctermfg=white ctermbg=red guifg=#E0E0E0 guibg=#990000]]  -- crimson red und grau im foreground,kann nicht in der Options stehen, weil sonst das colorscheme die Einstellung überschreibt.
--     vim.cmd [[highlight SpellBad ctermfg=red guifg=#991F00]] -- weinrot, kann nicht in der Options stehen, weil sonst das colorscheme die Einstellung überschreibt.
--   end,
-- }
--
-- auch colorscheme in Lualine.lua anpassen
--
--
-- https://github.com/oxalica/nightfox.vim

return {
  "EdenEast/nightfox.nvim",
  config = function()
    -- Zuerst das Plugin mit den Standardoptionen initialisieren
    require('nightfox').setup({
      options = {
        -- Optionen hier, wenn nötig
      }
    })

    -- Nordfox als dein Colorscheme setzen
    vim.cmd("colorscheme nordfox")
    -- vim.cmd [[highlight SpellBad ctermfg=white ctermbg=red guifg=#E0E0E0 guibg=#990000]] -- crimson red und grau im foreground,kann nicht in der Options stehen, weil sonst das colorscheme die Einstellung überschreibt.
    vim.cmd [[highlight SpellBad ctermfg=red guifg=#991F00]] -- weinrot, kann nicht in der Options stehen, weil sonst das colorscheme die Einstellung überschreibt.
  end,

}


-- catpPuccin

-- return {
--   "catppuccin/nvim", -- Stelle sicher, dass das catppuccin Plugin geladen wird
--   config = function()
--     -- Zuerst das Plugin mit den gewünschten Einstellungen initialisieren
--     require('catppuccin').setup({
--       flavour = "frappe", -- Stelle das gewünschte Flavour ein
--       -- Weitere Konfigurationsoptionen hier
--     })
--
--     -- Catppuccin Frappe als dein Colorscheme setzen
--     vim.cmd("colorscheme catppuccin")
--
--     -- Anpassen der SpellBad-Highlighting nach dem Laden des Colorschemes
--     -- Verwende hier die Farbe Weinrot für den Text und keine Änderung am Hintergrund
--     vim.cmd [[highlight SpellBad ctermfg=red guifg=#991F00]]
--   end,
-- }
-- auch colorscheme in Lualine.lua anpassen
--
