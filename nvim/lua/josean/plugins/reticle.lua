return {
  "tummetott/reticle.nvim",
  event = "VeryLazy",
  config = function()
    local reticle = require("reticle")

    reticle.setup({
      -- Startverhalten
      on_startup        = {
        cursorline = false,   -- wir schalten gleich per cursorcross an
        cursorcolumn = false, -- dito
      },
      -- Crosshair soll nur im aktiven Fenster folgen
      follow            = {
        cursorline   = true,
        cursorcolumn = true,
      },
      -- z.B. in Insert-Mode ausblenden (kannst du auf false stellen, wenn du willst)
      disable_in_insert = true,
      disable_in_diff   = true,
      -- hier kannst du Filetypes ignorieren (Telescope ist schon default drin)
      -- siehe Defaults im README
    })

    -- Crosshair (line + column) global einschalten
    -- reticle.set_cursorcross(true)
  end,

  vim.keymap.set("n", "<leader>xc", function()
    require("reticle").toggle_cursorcross()
  end, { desc = "Toggle cursor crosshair" })


}
