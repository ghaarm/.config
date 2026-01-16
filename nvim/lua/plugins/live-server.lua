-- https://github.com/barrett-ruth/live-server.nvim

return {
  "barrett-ruth/live-server.nvim",
  build = 'pnpm add -g live-server',
  cmd = { 'LiveServerStart', 'LiveServerStop' },
  config = true
}
