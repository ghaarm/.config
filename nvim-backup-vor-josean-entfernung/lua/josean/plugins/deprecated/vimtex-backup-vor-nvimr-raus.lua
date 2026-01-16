-- vim.g.maplocalleader = ","
--
-- return {
--   "lervag/vimtex",
--   -- dependencies = {
--   --   "xuhdev/vim-latex-live-preview",
--   -- },
--   config = function()
--     -- Lokale Funktion zum Schreiben des Servernamens
--     -- https://jdhao.github.io/2021/02/20/inverse_search_setup_neovim_vimtex/
--     -- der eigentliche code der Homepage hatte nicht funktioniert, aber dieser hier
--     local function write_server_name()
--       local nvim_server_file = (vim.fn.has("win32") == 1 and os.getenv("TEMP") or "/tmp") .. "/vimtexserver.txt"
--       local servername = vim.v.servername
--       local file = io.open(nvim_server_file, "w")
--       file:write(servername)
--       file:close()
--     end
--
--     -- Auto-Befehle für VimTeX
--     vim.api.nvim_create_augroup("vimtex_common", { clear = true })
--     vim.api.nvim_create_autocmd("FileType", {
--       pattern = "tex",
--       callback = write_server_name,
--       group = "vimtex_common",
--     })
--
--     -- Vimtex Konfiguration
--
--     -- vim.g.tex_flavor = "latex"
--     vim.g.vimtex_compiler_method = "latexmk"
--     vim.g.vimtex_view_method = "skim"
--
--     vim.g.vimtex_view_skim_sync = 1     -- Value 1 allows forward search after every successful compilation
--     vim.g.vimtex_view_skim_activate = 1 --# Value 1 allows change focus to skim after command `:VimtexView` is given
--
--     -- Skim Konfiguration für Vimtex
--     -- vim.g.vimtex_view_skim = {
--     --   executable = 'open',
--     --   args = {'-a', 'Skim'}
--     -- }
--
--     -- Kürzel für Vimtex-Funktionen über den lokalen Leader
--     vim.api.nvim_set_keymap("n", "<Localleader>v", ":VimtexView<CR>", { noremap = true, silent = true })
--
--     -- latexmk configuration to remove auxiliary files except for .log
--     vim.g.vimtex_compiler_latexmk = {
--       build_dir = "",
--       callback = 1,
--       continuous = 1,
--       executable = "latexmk",
--       options = {
--         "-pdf",
--         "-shell-escape",
--         "-verbose",
--         "-file-line-error",
--         "-interaction=nonstopmode",
--         "-synctex=1",
--       },
--     }
--
--     -- Zusätzliche Konfigurationen damit vimtex immer das Verzeichnis der tex datei als arbeitsverzeichnis benutzt
--     vim.g.vimtex_syntax_enabled = 1
--     vim.g.vimtex_quickfix_open_on_warning = 0
--
--     -- Mapping für die Bereinigung der Hilfsdateien im richtigen Verzeichnis
--     -- vim.api.nvim_set_keymap('n', '<Localleader>c', ':lua CleanLatexFiles()<CR>', { noremap = true, silent = true })
--   end,
-- }
--

vim.g.maplocalleader = ","

return {
  "lervag/vimtex",
  -- dependencies = {
  --   "xuhdev/vim-latex-live-preview",
  -- },
  lazy = true,    -- Lädt das Plugin nur, wenn es benötigt wird
  ft = { "tex" }, -- Lädt das Plugin nur für LaTeX-Dateien
  config = function()
    -- Lokale Funktion zum Schreiben des Servernamens
    -- https://jdhao.github.io/2021/02/20/inverse_search_setup_neovim_vimtex/
    -- der eigentliche code der Homepage hatte nicht funktioniert, aber dieser hier
    local function write_server_name()
      local nvim_server_file = (vim.fn.has("win32") == 1 and os.getenv("TEMP") or "/tmp") .. "/vimtexserver.txt"
      local servername = vim.v.servername
      local file = io.open(nvim_server_file, "w")
      file:write(servername)
      file:close()
    end

    -- Auto-Befehle für VimTeX
    vim.api.nvim_create_augroup("vimtex_common", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "tex",
      callback = write_server_name,
      group = "vimtex_common",
    })

    -- Vimtex Konfiguration

    -- vim.g.tex_flavor = "latex"
    vim.g.vimtex_compiler_method = "latexmk"
    -- vim.g.vimtex_view_method = "sioyek"
    vim.g.vimtex_view_method = "skim"

    vim.g.vimtex_view_skim_sync = 1     -- Value 1 allows forward search after every successful compilation
    vim.g.vimtex_view_skim_activate = 1 --# Value 1 allows change focus to skim after command `:VimtexView` is given

    -- Skim Konfiguration für Vimtex
    vim.g.vimtex_view_skim = {
      executable = 'open',
      args = { '-a', 'Skim' }
    }

    -- Kürzel für Vimtex-Funktionen über den lokalen Leader
    vim.api.nvim_set_keymap("n", "<Localleader>v", ":VimtexView<CR>", { noremap = true, silent = true })

    -- Mapping für :VimtexClean auf <leader>cc
    vim.api.nvim_set_keymap("n", "<leader>lc", ":VimtexClean<CR>", { noremap = true, silent = true })
    --
    --
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
      -- Hier den `aux_dir` einfügen, um die Hilfsdateien in einem speziellen Verzeichnis abzulegen
      aux_dir = "auxiliary_files",
    }

    -- Zusätzliche Konfigurationen damit vimtex immer das Verzeichnis der tex datei als arbeitsverzeichnis benutzt
    vim.g.vimtex_syntax_enabled = 1
    vim.g.vimtex_quickfix_open_on_warning = 0

    -- Mapping für die Bereinigung der Hilfsdateien im richtigen Verzeichnis
    -- vim.api.nvim_set_keymap('n', '<Localleader>c', ':lua CleanLatexFiles()<CR>', { noremap = true, silent = true })
  end,
}

-- https://gist.github.com/kha-dinh/c8540052854f3c6954b047abd506b799
-- Versuch Sioyek mit nvim remote für inverse search
-- funktioniert nicht



-- anderer Versuch aus git https://github.com/lervag/vimtex/issues/2323#issuecomment-1047021336
-- funktioniert nicht
