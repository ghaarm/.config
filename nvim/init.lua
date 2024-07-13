require("josean.core")
require("josean.lazy")
--
--
--
-- Laden der Funktion aus function.lua
-- require("josean.function")
-- Mapping für die Funktion erstellen
--
-- vim.api.nvim_set_keymap(
--   "n",
--   "<leader>rc",
--   ':lua require("function").RunCurrentChunk()<CR>',
--   { noremap = true, silent = true }
-- )
-- -- Zeilenumbruch aktivieren
-- vim.opt.wrap = true

-- -- Zeilen an Wortgrenzen umbrechen
-- vim.opt.linebreak = true

-- -- Symbol für umgebrochene Zeilen
-- vim.opt.showbreak = "↪"

-- -- Indentation für umgebrochene Zeilen beibehalten
-- vim.opt.breakindent = true

-- -- https://jdhao.github.io/2021/02/20/inverse_search_setup_neovim_vimtex/
-- -- function! s:write_server_name() abort
-- --   let nvim_server_file = (has('win32') ? $TEMP : '/tmp') . '/vimtexserver.txt'
-- --   call writefile([v:servername], nvim_server_file)
-- -- endfunction
-- --
-- -- augroup vimtex_common
-- --   autocmd!
-- --   autocmd FileType tex call s:write_server_name()
-- -- augroup END
-- --

-- -- Funktion zum Schreiben des Servernamens
-- local function write_server_name()
--   local nvim_server_file = (vim.fn.has("win32") == 1 and os.getenv("TEMP") or "/tmp") .. "/vimtexserver.txt"
--   local servername = vim.v.servername
--   local file = io.open(nvim_server_file, "w")
--   file:write(servername)
--   file:close()
-- end

-- -- Autocommand zum Schreiben des Servernamens bei LaTeX-Dateien
-- vim.api.nvim_create_augroup("vimtex_common", { clear = true })
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "tex",
--   callback = write_server_name,
--   group = "vimtex_common",
-- })

-- -- Set the Python 3 host program to the virtual environment Pythoni
-- -- für vimtex live preview
-- vim.g.python3_host_prog = "/Users/g/.venvs/neovim/bin/python"

-- -- Funktion um nach dem Knitten in R automatisch die geknittete HTML im Browser zu öffnen
-- --

-- local function knit_and_open()
--   -- Run the KnitRhtml command
--   vim.cmd("KnitRhtml")
--   -- Get the name of the resulting HTML file
--   local filename = vim.fn.expand("%:p:r") .. ".html"
--   -- Escape special characters in the filename for shell command
--   local escaped_filename = vim.fn.shellescape(filename)
--   -- Open the HTML file in the default web browser
--   os.execute("open " .. escaped_filename)
-- end

-- -- Create a custom command KnitRhtmlAndOpen that knits the file and opens it
-- vim.api.nvim_create_user_command("KnitRhtmlAndOpen", knit_and_open, {})

-- -- https://github.com/R-nvim/R.nvim/blob/main/doc/R.nvim.txt
-- -- macht die Farben so wie in meinem eingestellten colorscheme, andere varianten auf der Homepage
-- vim.g.rout_follow_colorscheme = true
