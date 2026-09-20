-- return {
--   "lukas-reineke/indent-blankline.nvim",
--   event = { "BufReadPre", "BufNewFile" },
--   main = "ibl",
--   -- Hier definieren wir die Farben einmalig
--   -- init = function()-- Scope (aktuelle Einrückung) extra hervorheben
--   --   vim.api.nvim_set_hl(0, "IblScope", { fg = "#aaaaaa", nocombine = true })
--   -- end,
--   config = functio()
--     require("ibl").sepup({
-- indent = {
--         char = "┊",  -- hier ist 'char' korrekt verschachtelt
--       },
--       -- opts = {
--       --   indent = {
--       --     char = "│"
--       --   },
--
--         -- char = "┊"
--         -- "┃"
--
--
--         scope = {
--           enabled = true,
--           -- highlight = "IblScope",
--         },
--       })
--   end,
-- }
--

return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  event = { "BufReadPre", "BufNewFile" },

  config = function()
    local ibl = require("ibl")
    local hooks = require("ibl.hooks")

    -- Farben für normale Indents und den aktuellen Scope
    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      -- normale Indent-Linien
      vim.api.nvim_set_hl(0, "IblIndent", { fg = "#444444", nocombine = true })
      -- aktueller Scope/Block (heller)
      vim.api.nvim_set_hl(0, "IblScope", { fg = "#aaaaaa", nocombine = true })
    end)

    -- sagt ibl, dass es die Scope-Guides mit IblScope einfärben soll
    hooks.register(
      hooks.type.SCOPE_HIGHLIGHT,
      hooks.builtin.scope_highlight_from_extmark
    )

    ibl.setup({
      indent = {
        char = "│", -- oder "┊", wie du magst
        highlight = "IblIndent",
      },
      scope = {
        enabled = true,
        highlight = "IblScope",
        show_start = false, -- keine zusätzliche Unterstreichung
        show_end = false,
      },
    })
  end,
}
