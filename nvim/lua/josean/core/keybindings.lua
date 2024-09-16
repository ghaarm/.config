vim.g.mapleader = " "
-- Deaktivieren der Pfeiltasten im normalen Modus
-- vim.api.nvim_set_keymap("n", "<Up>", "<NOP>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "<Down>", "<NOP>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "<Left>", "<NOP>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "<Right>", "<NOP>", { noremap = true, silent = true })
--
-- -- Deaktivieren der Pfeiltasten im Einfügemodus
-- vim.api.nvim_set_keymap("i", "<Up>", "<NOP>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("i", "<Down>", "<NOP>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("i", "<Left>", "<NOP>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("i", "<Right>", "<NOP>", { noremap = true, silent = true })
--
-- -- Deaktivieren der Pfeiltasten im visuellen Modus
-- vim.api.nvim_set_keymap("v", "<Up>", "<NOP>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("v", "<Down>", "<NOP>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("v", "<Left>", "<NOP>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("v", "<Right>", "<NOP>", { noremap = true, silent = true })
--
--
-- alles markieren
vim.api.nvim_set_keymap("n", "<D-a>", "ggVG$", { noremap = true, silent = true })

-- control r für redo umlegen auf cmd r
-- vim.api.nvim_set_keymap("n", "<D-r>", "<C-r>", { noremap = true, silent = true })

-- Datei speichern mit cmd + s im normal modus
vim.api.nvim_set_keymap("n", "<D-s>", ":w<CR>", { noremap = true, silent = true })

-- Datei speichern mit cmd + s im insert modus
vim.api.nvim_set_keymap("i", "<D-s>", "<C-\\><C-n>:w<CR>", { noremap = true, silent = true })

-- markierten Bereich kopieren im visuellen Modus
vim.api.nvim_set_keymap("v", "<D-c>", "y", { noremap = true, silent = true })
--
--
--
-- nicht in den insertmodus wechseln ibei o oder O
vim.api.nvim_set_keymap("n", "o", "o<Esc>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "O", "O<Esc>", { noremap = true, silent = true })

-- auch mit cmd + c kopieren können und nicht nur yank
vim.api.nvim_set_keymap("v", "<D-c>", '"+y', { noremap = true, silent = true })

local keymap = vim.keymap -- for conciseness

keymap.set("i", "jj", "<ESC>", { desc = "Exit insert mode with jj" })

keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })                   -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })                 -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })                    -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })               -- close current split window

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })                     -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })              -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })                     --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })                 --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-- Vimtex-specific keybindings
vim.api.nvim_create_autocmd("FileType", {
  pattern = "tex",
  callback = function()
    -- Set local leader key for tex files
    vim.b.mapleader = "\\"
    -- Set Vimtex TOC toggle keybinding
    keymap.set("n", "<localleader>i", "<cmd>VimtexTocToggle<CR>", { buffer = true, desc = "Toggle Vimtex TOC" })
  end,
})

-- Setze eine Tastenkombination zum Umschalten der Zeilennummerierung
vim.api.nvim_set_keymap("n", "<Leader>lr", ":set relativenumber!<CR>", { noremap = true, silent = true })

-- Telescope-specific keybindings
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
keymap.set("i", "<D-i>", "<cmd>Telescope bibtex<cr>", { desc = "Open Telescope BibTeX search" }) -- D steht für die Command taste


-- Scrollen vom Primagen damit Cursor immer in der Mitte, dann neoscroll entfernen

vim.api.nvim_set_keymap('n', '<C-d>', '<C-d>zz', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-u>', '<C-u>zz', { noremap = true, silent = true })

-- alt + backspace soll word löschen und dann insert modus machen

vim.api.nvim_set_keymap('i', '<M-BS>', '<C-w>', { noremap = true, silent = true })
-- cmd + backspace löscht ganze Zeile
vim.api.nvim_set_keymap('i', '<D-BS>', '<C-u>', { noremap = true, silent = true })
--
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
-- datei im Finder öffnen
--
-- datei im Finder öffnen

-- Initialize tables to avoid nil errors
-- _G.cmp_mappings = _G.cmp_mappings or {}
-- _G.bibtex_mappings = _G.bibtex_mappings or {}
-- _G.telescope_mappings = _G.telescope_mappings or {}

-- nvim-cmp specific keybindings
-- _G.cmp_mappings = {
--   ["<C-k>"] = { "select_prev_item", { desc = "Previous suggestion" } },
--   ["<C-j>"] = { "select_next_item", { desc = "Next suggestion" } },
--   ["<C-b>"] = { "scroll_docs", { -4, desc = "Scroll docs up" } },
--   ["<C-f>"] = { "scroll_docs", { 4, desc = "Scroll docs down" } },
--   ["<C-Space>"] = { "complete", { desc = "Show completion suggestions" } },
--   ["<C-e>"] = { "abort", { desc = "Close completion window" } },
--   ["<CR>"] = { "confirm", { { select = false }, desc = "Confirm selection" } },
-- }
-- BibTeX specific keybindings
-- _G.bibtex_mappings = {
--   ["<CR>"] = { "key_append", '%s', { desc = "Append key" } },
--   ["<C-e>"] = { "entry_append", { desc = "Append entry" } },
--   ["<C-c>"] = { "citation_append", '{{author}} ({{year}}), {{title}}.', { desc = "Append citation" } },
-- }

-- -- Telescope actions keybindings
-- _G.telescope_mappings = {
--   ["<C-k>"] = { "move_selection_previous", { desc = "Move to prev result" } },
--   ["<C-j>"] = { "move_selection_next", { desc = "Move to next result" } },
--   ["<C-q>"] = { "send_selected_to_qflist", { desc = "Send selected to qflist" } },
--   ["<C-t>"] = { "smart_open_with_trouble", { desc = "Open with trouble" } },
-- }

-- neoscroll
-- neoscroll = require('neoscroll')
-- local keymap = {
--   ["<D-k>"] = function() neoscroll.ctrl_u({ duration = 250 }) end;
--   ["<D-j>"] = function() neoscroll.ctrl_d({ duration = 250 }) end;
--   -- -- ["<C-b>"] = function() neoscroll.ctrl_b({ duration = 450 }) end;
--   -- ["<C-f>"] = function() neoscroll.ctrl_f({ duration = 450 }) end;
--   -- ["<C-y>"] = function() neoscroll.scroll(-0.1, { move_cursor=false; duration = 100 }) end;
--   -- ["<C-e>"] = function() neoscroll.scroll(0.1, { move_cursor=false; duration = 100 }) end;
--   -- ["zt"]    = function() neoscroll.zt({ half_screen_duration = 250 }) end;
--   -- ["zz"]    = function() neoscroll.zz({ half_screen_duration = 250 }) end;
--   -- ["zb"]    = function() neoscroll.zb({ half_screen_duration = 250 }) end;
--   -- ["G"]     = function() neoscroll.G({ half_screen_duration = 250 }) end;
--   -- ["gg"]    = function() neoscroll.gg({ half_screen_duration = 250 }) end;
-- }
-- local modes = { 'n', 'v', 'x' }
-- for key, func in pairs(keymap) do
--   vim.keymap.set(modes, key, func)
-- end
-----------------------------------------------------------------------------
-----------------------------------------------------------------
-- aus functions.lua um dabtei im Finder zu öffnen
vim.api.nvim_set_keymap('n', '<leader>o', ':lua OpenInFinder()<CR>', { noremap = true, silent = true })
---
