-- -- https://github.com/numToStr/Comment.nvim
--
-- return {
--   "numToStr/Comment.nvim",
--   event = { "BufReadPre", "BufNewFile" },
--   dependencies = {
--     "JoosepAlviste/nvim-ts-context-commentstring",
--   },
--   config = function()
--     local comment = require("Comment")
--     local ts_context_commentstring = require("ts_context_commentstring.integrations.comment_nvim")
--
--     comment.setup({
--       padding = true,
--       sticky = true,
--       ignore = nil,
--
--       toggler = {
--         line = "gcc",
--         block = "gbc",
--       },
--
--       opleader = {
--         line = "gc",
--         block = "gb",
--       },
--
--       extra = {
--         above = "gcO",
--         below = "gco",
--         eol = "gcA",
--       },
--
--       mappings = {
--         basic = true,
--         extra = true,
--       },
--
--       pre_hook = function(ctx)
--         local ft = vim.bo.filetype
--
--         if ft == "tex" or ft == "plaintex" or ft == "latex" then
--           return "%% %s"
--         end
--
--         return ts_context_commentstring.create_pre_hook()(ctx)
--       end,
--
--       post_hook = nil,
--     })
--
--     local ft = require("Comment.ft")
--     ft.set("tex", "%% %s")
--     ft.set("plaintex", "%% %s")
--     ft.set("latex", "%% %s")
--   end,
-- }
--
return {
  "numToStr/Comment.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
  config = function()
    local comment = require("Comment")
    local ft = require("Comment.ft")
    local ok_ts, ts_integration = pcall(require, "ts_context_commentstring.integrations.comment_nvim")

    -- Feste commentstrings für Filetypes, die oft nil / leer sind
    ft.set("tex", "% %s")
    ft.set("plaintex", "% %s")
    ft.set("latex", "% %s")

    ft.set({ "conf", "cfg", "ini", "toml", "yaml", "yml", "gitconfig", "desktop" }, "# %s")
    ft.set("dosini", "# %s")
    ft.set("sshconfig", "# %s")
    ft.set("tmux", "# %s")
    ft.set("hyprlang", "# %s")
    ft.set("fstab", "# %s")
    ft.set("properties", "# %s")

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
        local filetype = vim.bo.filetype

        -- 1) zuerst feste Regeln von Comment.ft benutzen
        local cs = ft.get(filetype)

        if type(cs) == "table" then
          cs = cs[1]
        end

        if type(cs) == "string" and cs ~= "" then
          return cs
        end

        -- 2) dann ts-context-commentstring versuchen
        if ok_ts then
          local ok, ts_cs = pcall(ts_integration.create_pre_hook(), ctx)
          if ok and type(ts_cs) == "string" and ts_cs ~= "" then
            return ts_cs
          end
        end

        -- 3) zuletzt buffer-local commentstring als Fallback
        local buf_cs = vim.bo.commentstring
        if type(buf_cs) == "string" and buf_cs ~= "" then
          return buf_cs
        end

        -- 4) harter universeller Fallback für ein paar problematische Filetypes
        local fallback = {
          conf = "# %s",
          cfg = "# %s",
          ini = "# %s",
          toml = "# %s",
          yaml = "# %s",
          yml = "# %s",
          sshconfig = "# %s",
          hyprlang = "# %s",
          tex = "%% %s",
          plaintex = "%% %s",
          latex = "%% %s",
        }

        return fallback[filetype]
      end,
    })
  end,
}
