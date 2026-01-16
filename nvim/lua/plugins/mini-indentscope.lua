return {
  "echasnovski/mini.indentscope",
  version = false,
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local indentscope = require("mini.indentscope")

    --   #ff8800  = kräftiges Orange
    -- vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { fg = "#ff8800", nocombine = true })
    --   #ff9e64  = etwas softer (passt gut zu vielen Dark-Themes)
    vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { fg = "#ff9e64", nocombine = true })

    indentscope.setup({
      -- Zeichen für den aktuellen Block
      symbol = "│",
      options = {
        try_as_border = true,
      },
      draw = {
        delay = 0, -- keine Wartezeit, sofort zeichnen
        -- keine Animation: Linie erscheint direkt komplett
        animation = indentscope.gen_animation.none(),
      },
    })
  end,
}
