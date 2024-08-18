-- return {
--   "kylechui/nvim-surround",
--   event = { "BufReadPre", "BufNewFile" },
--   version = "*", -- Use for stability; omit to use `main` branch for the latest features
--   config = true,
-- }

-- Deine surround.lua Datei mit tpope's vim-surround Plugin
return {
  "tpope/vim-surround",
  event = { "BufReadPre", "BufNewFile" },
}
