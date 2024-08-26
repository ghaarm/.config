local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    -- "--branch=stable", -- latest stable release
    "--branch=main", -- Nutze den Hauptentwicklungszweig
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  { import = "josean.plugins" },
  { import = "josean.plugins.nvim-cmp" }, -- Lädt nvim-cmp explizit
  { import = "josean.plugins.lsp" }
}, {
  checker = {
    enabled = true,
    notify = false,
  },
  change_detection = {
    notify = false,
  },
})
