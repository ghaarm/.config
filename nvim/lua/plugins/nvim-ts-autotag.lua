-- return {
--   "windwp/nvim-ts-autotag",
--   event = "VeryLazy",
--   dependencies = { "nvim-treesitter/nvim-treesitter" },
--   config = function()
--     require("nvim-treesitter.configs").setup({
--       autotag = {
--         enable = true,
--         filetypes = {
--           "html",
--           "xml",
--           "javascript",
--           "typescript",
--           "javascriptreact",
--           "typescriptreact",
--           "svelte",
--           "vue",
--           -- und hier deine:
--           "r",
--           "rmd",
--           "rmarkdown",
--         },
--       },
--     })
--   end,
-- }
--
-- neu wg. nvim 0.12
--
return {
  "windwp/nvim-ts-autotag",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    require("nvim-ts-autotag").setup({
      opts = {
        enable_close = true,
        enable_rename = true,
        enable_close_on_slash = false,
      },
      aliases = {
        r = "html",
        rmd = "html",
        rmarkdown = "html",
      },
    })
  end,
}
