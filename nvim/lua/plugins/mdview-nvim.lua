-- https://github.com/StefanBartl/mdview.nvim?utm_source=chatgpt.com
-- mdvienw konnte keine pandoc filetypes benutzen, deswesen die experimental opts aktiviertl
--
vim.g.maplocalleader = ","

return {
  "StefanBartl/mdview.nvim",
  dependencies = {
    "StefanBartl/lib.nvim",
  },
  ft = { "markdown", "pandoc" },
  cmd = { "MDView" },

  opts = {

    scroll_sync = true,
    experimental = {

      any_file = true,
      click_navigate = true,
      reverse_scroll = true,
    },
  },
  -- config = function()
  --   require("mdview").setup()
  -- end,
}
