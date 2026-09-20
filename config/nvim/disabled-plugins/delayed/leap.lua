-- https://github.com/ggandor/leap.nvim

-- Load and configure the leap.nvim plugin
return {
  "ggandor/leap.nvim",
  config = function()
    -- You might need to call setup if you want to configure Leap further or change its defaults
    require("leap").setup({
      -- Add any specific setup options here if needed
    })

    -- Remove the default keymaps by setting them to false
    require("leap").set_default_keymaps(false)

    -- Set custom keymaps
    vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap-forward)", { desc = "Leap forward" })
    vim.keymap.set({ "n", "x", "o" }, "S", "<Plug>(leap-backward)", { desc = "Leap backward" })
    vim.keymap.set({ "n", "x", "o" }, "gs", "<Plug>(leap-from-window)", { desc = "Leap from window" })
  end,
}
