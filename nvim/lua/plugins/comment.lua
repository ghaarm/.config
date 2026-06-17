-- https://github.com/numToStr/Comment.nvim

return {
  "numToStr/Comment.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
  config = function()
    local comment = require("Comment")
    local ts_context_commentstring = require("ts_context_commentstring.integrations.comment_nvim")

    comment.setup({
      padding = true,
      sticky = true,
      ignore = nil,

      toggler = {
        line = "gcc",
        block = "gbc",
      },

      opleader = {
        line = "gc",
        block = "gb",
      },

      extra = {
        above = "gcO",
        below = "gco",
        eol = "gcA",
      },

      mappings = {
        basic = true,
        extra = true,
      },

      pre_hook = function(ctx)
        local ft = vim.bo.filetype

        if ft == "tex" or ft == "plaintex" or ft == "latex" then
          return "%% %s"
        end

        return ts_context_commentstring.create_pre_hook()(ctx)
      end,

      post_hook = nil,
    })

    local ft = require("Comment.ft")
    ft.set("tex", "%% %s")
    ft.set("plaintex", "%% %s")
    ft.set("latex", "%% %s")
  end,
}
