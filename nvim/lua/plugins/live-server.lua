-- https://github.com/barrett-ruth/live-server.nvim
return {
  "barrett-ruth/live-server.nvim",
  build = "pnpm add -g live-server",
  cmd = { "LiveServerStart", "LiveServerStop" },
  keys = {
    { "<leader>ls", "<cmd>LiveServerStart<CR>", desc = "Live Server Start" },
    { "<leader>lc", "<cmd>LiveServerStop<CR>", desc = "Live Server Stop" },
  },
  config = true,
}-
