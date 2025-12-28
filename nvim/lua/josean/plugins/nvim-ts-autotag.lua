return {
  "windwp/nvim-ts-autotag",
  event = "VeryLazy",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    require("nvim-treesitter.configs").setup({
      autotag = {
        enable = true,
        filetypes = {
          "html",
          "xml",
          "javascript",
          "typescript",
          "javascriptreact",
          "typescriptreact",
          "svelte",
          "vue",
          -- und hier deine:
          "r",
          "rmd",
          "rmarkdown",
        },
      },
    })
  end,
}
