-- https://github.com/atiladefreitas/LazyClip
return {
  "atiladefreitas/lazyclip",
  -- event = { "TextYankPost" },

  config = function()
    require("lazyclip").setup({
      -- Core settings
      max_history = 100,
      items_per_page = 9,
      min_chars = 5,

      -- Window appearance
      window = {
        relative = "editor",
        width = 70,
        height = 12,
        border = "rounded",
      },

      -- Internal keymaps for the lazyclip window
      keymaps = {
        close_window = "q",
        prev_page = "h",
        next_page = "l",
        paste_selected = "<CR>",
        move_up = "k",
        move_down = "j",
        delete_item = "d",
      },
    })
  end,

  keys = {
    { "<C-w>", "<cmd>LazyClip<CR>", desc = "Open Clipboard Manager" },
  },
}
