-- https://pi.dev/packages/pi-nvim
return {
  "carderne/pi-nvim",
  config = function()
    require("pi-nvim").setup({
      socket_path = nil, -- nil = automatisch finden
      set_default_keymaps = true,
    })
  end,
}
