return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 500
  end,
  opts = {
    -- defaults = {
    --   preset = "classic",
    --   notify = true,
    --   plugins = {
    --     marks = true,     -- shows a list of your marks on ' and `
    --     registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    --     -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    --     -- No actual key bindings are created
    --     spelling = {
    --       enabled = true,   -- enabling this will show WhichKey when pressing z= to select spelling suggestions
    --       suggestions = 20, -- how many suggestions should be shown in the list?
    --     },
    --     presets = {
    --       operators = false,    -- adds help for operators like d, y, ...
    --       motions = false,      -- adds help for motions
    --       text_objects = false, -- help for text objects triggered after entering an operator
    --       windows = false,      -- default bindings on <c-w>
    --       nav = false,          -- misc bindings to work with windows
    --       z = false,            -- bindings for folds, spelling and others prefixed with z
    --       g = false,            -- bindings for prefixed with g
    --     },
    --   },
    -- },
  },
  -- keys = {
  --   {
  --     "<leader>?",
  --     function()
  --       require("which-key").show({ global = false })
  --     end,
  --     desc = "Buffer Local Keymaps (which-key)",
  --   },
  -- },
  config = function(_, opts)
    local wk = require("which-key")
    wk.add({
      { "<leader>t",   group = "TEMPLATES",                                                        nowait = true,                              remap = false },
      { "<leader>ta",  "<cmd>read ~/.config/nvim/templates/article-template.tex<CR>",              desc = "article-template.tex",              nowait = true, remap = false },
      { "<leader>tt",  "<cmd>read ~/.config/nvim/templates/article-template-toc.tex<CR>",              desc = "article-template-toc.tex",              nowait = true, remap = false },
      { "<leader>tb",  "<cmd>read ~/.config/nvim/templates/footer-footnotes-bibliography.tex<CR>", desc = "footer-footnotes-bibliography.tex", nowait = true, remap = false },
      { "<leader>tc",  "<cmd>read ~/.config/nvim/templates/chapter.tex<CR>",                       desc = "chapter template tex",              nowait = true, remap = false },
      { "<leader>tl",  "<cmd>read ~/.config/nvim/templates/footer-footnotes.tex<CR>",              desc = "footer-footnotes.tex",              nowait = true, remap = false },
      { "<leader>tm",  "<cmd>read ~/.config/nvim/templates/mail.txt<CR>",                          desc = "mail.txt",                          nowait = true, remap = false },
      { "<leader>tmm", "<cmd>read ~/.config/nvim/templates/markdown.md<CR>",                       desc = "markdown.md",                       nowait = true, remap = false },
      { "<leader>tr",  "<cmd>read ~/.config/nvim/templates/book.tex<CR>",                          desc = "report template tex",               nowait = true, remap = false },
      { "<leader>ts",  "<cmd>read ~/.config/nvim/templates/cheat-sheet.md<CR>",                    desc = "cheat-sheet.md",                    nowait = true, remap = false },
      { "<leader>tu",  "<cmd>read ~/.config/nvim/templates/übergabeprotokoll.tex<CR>",             desc = "übergabeprotokoll.tex",             nowait = true, remap = false },
    })
    -- wk.setup(opts.setup)
    -- wk.register(opts.defaults)
  end,
}
