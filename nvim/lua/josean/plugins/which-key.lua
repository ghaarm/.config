return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 500
  end,
  opts = {
    setup = {
      show_help = true,
      plugins = {
        presets = {
          operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
          motions = false, -- adds help for motions
          text_objects = false, -- help for text objects triggered after entering an operator
          windows = false, -- default bindings on <c-w>
          nav = false, -- misc bindings to work with windows
          z = false, -- bindings for folds, spelling and others prefixed with z
          g = false, -- bindings for prefixed with g
          marks = false, -- shows a list of your marks on ' and `
          registers = false, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
          spelling = {
            enabled = false, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
            suggestions = 10, -- how many suggestions should be shown in the list?
          },
          -- the presets plugin, adds help for a bunch of default keybindings in Neovim
          -- No actual key bindings are created
        },
      },
      triggers = { "<leader>" }, -- or specify a list manually
    },
    defaults = {
      buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
      silent = true, -- use `silent` when creating keymaps
      noremap = true, -- use `noremap` when creating keymaps
      nowait = true, -- use `nowait` when creating keymaps
      prefix = "<leader>",
      t = {
        name = "TEMPLATES",
        b = {
          "<cmd>read ~/.config/nvim/templates/footer-footnotes-bibliography.tex<CR>",
          "footer-footnotes-bibliography.tex",
        },
        c = {
          "<cmd>read ~/.config/nvim/templates/chapter.tex<CR>",
          "chapter template tex",
        },

        r = {
          "<cmd>read ~/.config/nvim/templates/book.tex<CR>",
          "report template tex",
        },
        l = {
          "<cmd>read ~/.config/nvim/templates/footer-footnotes.tex<CR>",
          "footer-footnotes.tex",
        },
      },
    },
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts.setup)
    wk.register(opts.defaults)
  end,
}
