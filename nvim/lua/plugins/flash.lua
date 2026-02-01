-- Andrew Courter https://www.youtube.com/watch?v=eJ3XV-3uoug

return {
  "folke/flash.nvim",
  event = "VeryLazy",
  opts = {
    -- use labels with f, t, F, T
    jump = {
      pos = "end", -- <- landet am Ende des Matches (statt Wortanfang)
    },
    modes = {
      char = {
        jump_labels = false,
      },
    },
  },
  -- stylua: ignore
  keys = {
    -- { "ss",    mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash",              silent = true, noremap = true, },
    { "st",    mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash",              silent = true, noremap = true, },
    { "SS",    mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
    { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
    { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
  },
}
