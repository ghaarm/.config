vim.g.maplocalleader = ","

return {
  "lervag/vimtex",
  dependencies = {
    "xuhdev/vim-latex-live-preview",
  },
  config = function()
    -- Setze den lokalen Leader auf ','

    -- Vimtex Konfiguration

    -- vim.g.tex_flavor = "latex"
    vim.g.vimtex_compiler_method = "latexmk"
    vim.g.vimtex_view_method = "skim"

    vim.g.vimtex_view_skim_sync = 1 -- Value 1 allows forward search after every successful compilation
    vim.g.vimtex_view_skim_activate = 1 --# Value 1 allows change focus to skim after command `:VimtexView` is given

    -- Skim Konfiguration für Vimtex
    -- vim.g.vimtex_view_skim = {
    --   executable = 'open',
    --   args = {'-a', 'Skim'}
    -- }

    -- Kürzel für Vimtex-Funktionen über den lokalen Leader
    vim.api.nvim_set_keymap("n", "<Localleader>v", ":VimtexView<CR>", { noremap = true, silent = true })

    -- latexmk configuration to remove auxiliary files except for .log
    vim.g.vimtex_compiler_latexmk = {
      build_dir = "",
      callback = 1,
      continuous = 1,
      executable = "latexmk",
      options = {
        "-pdf",
        "-shell-escape",
        "-verbose",
        "-file-line-error",
        "-interaction=nonstopmode",
        "-synctex=1",
      },
    }

    -- Zusätzliche Konfigurationen damit vimtex immer das Verzeichnis der tex datei als arbeitsverzeichnis benutzt
    vim.g.vimtex_syntax_enabled = 1
    vim.g.vimtex_quickfix_open_on_warning = 0

    -- Mapping für die Bereinigung der Hilfsdateien im richtigen Verzeichnis
    -- vim.api.nvim_set_keymap('n', '<Localleader>c', ':lua CleanLatexFiles()<CR>', { noremap = true, silent = true })
  end,
}
-- https://github.com/ericlovesmath/dotfiles/blob/master/.config/nvim/lua/plugins/vimtex.lua
-- return {
--   "lervag/vimtex",
--   dependencies = {
--     "xuhdev/vim-latex-live-preview",
--   },
--   ft = { "tex" },
--   config = function()
--     vim.cmd([[
--         let g:vimtex_compiler_progname = "nvr"
--         let g:vimtex_view_method = "skim"
--         let g:vimtex_imaps_enabled = 1
--         let g:vimtex_complete_enabled = 0
--         " let g:vimtex_quickfix_enabled = 0
--
--         call vimtex#init()
--
--         set conceallevel=2
--         let g:vimtex_syntax_conceal["math_super_sub"]=0
--         highlight Conceal guifg=#d19a66 guibg=NONE
--
--         augroup vimtex_config
--             au!
--             au User VimtexEventQuit call vimtex#compiler#clean(0)
--         augroup END
--
--         " autocmd FileType tex nmap <buffer> <C-T> :!latexmk -pvc -pdf %<CR>
--         ]])
--   end,
-- }
