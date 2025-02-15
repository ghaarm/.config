vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

-- Maus aktivieren
vim.opt.mouse = "a"
-- vim.opt.mouse = "" -- Maus deaktivieren


opt.relativenumber = true

opt.number = true

-- Setze 'scrolloff' auf 10 Zeilen, es soll max 10 Zeilen unter das Ende gescrollt werden, funktioniert nicht
-- vim.opt.scrolloff = 10

-- tabs & indentation & linebreak
opt.tabstop = 3       -- 2 spaces for tabs (prettier default)
opt.shiftwidth = 2    -- 2 spaces for indent width
opt.expandtab = true  -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one


-- Zeilenumbruch aktivieren
opt.wrap = true

-- Zeilen an Wortgrenzen umbrechen
vim.opt.linebreak = true

-- Indentation für umgebrochene Zeilen beibehalten
vim.opt.breakindent = true

-- Symbol für umgebrochene Zeilen
vim.opt.showbreak = "↪"


-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true  -- if you include mixed case in your search, assumes you want case-sensitive

opt.cursorline = true

-- turn on termguicolors for tokyonight colorscheme to work
-- (have to use iterm2 or any other true color terminal)
opt.termguicolors = true
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes"  -- show sign column so that text doesn't shift

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- turn off swapfile
opt.swapfile = false

-- Verzeichnis für Spellchecking erstellen
-- vim.opt.spellfile = "~/.config/nvim/spell"

-- Spellchecking, Wörterbücher einstellen
vim.opt.spelllang = { "de_de", "en_gb" }

-- Rechtschreibung aktivieren
vim.opt.spell = true

-- vim.cmd [[highlight SpellBad ctermfg=white ctermbg=red guifg=#E0E0E0 guibg=#990000]] -- muss in der Colorscheme.lua stehen weil das Colorscheme sonst diese Einstellung überschreibt
--
-- vim.opt.foldlevel = 99 -- Öffnet alle Folds, außer die sehr tiefen
