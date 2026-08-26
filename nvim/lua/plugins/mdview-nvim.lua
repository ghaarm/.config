-- https://github.com/StefanBartl/mdview.nvim?utm_source=chatgpt.com
--
vim.g.maplocalleader = ","
return {
  "StefanBartl/mdview.nvim",
  dependencies = { "StefanBartl/lib.nvim" },
  ft = { "markdown" },
  cmd = { "MDView" },
  opts = {},
}
