require("josean.core")


-- Set the Python 3 host program to the virtual environment Pythoni
-- für vimtex live preview, brauche eine virtuelle Umgebung damit pynvim läuft
vim.g.python3_host_prog = "/Users/g/neovim-venv/bin/python3"

vim.g.EasyClipUseGlobalPasteToggle = 0 -- weil es sonst einen error mit easyclip gibt
require("josean.lazy")
