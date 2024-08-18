return {
  "ThePrimeagen/harpoon",
  lazy = false,
  branch = "harpoon2",
  init = function()
    local harpoon = require("harpoon")

    -- REQUIRED
    harpoon:setup({
      global_settings = {
        save_on_toggle = true,
        save_on_change = true,
      },
    })
    -- REQUIRED

    -- vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end,  { noremap = true, desc = "add file to harpoon" })
    -- vim.keymap.set("n", "<D-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { noremap = true, desc = "toggle harpoon" })

    vim.keymap.set("n", "<leader>ha", function()
      harpoon:list():add()
    end, { noremap = true, desc = "add file to harpoon" })
    vim.keymap.set("n", "<leader>ht", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { noremap = true, desc = "toggle harpoon" })

    vim.keymap.set("n", "<C-h>", function()
      harpoon:list():select(1)
    end)
    vim.keymap.set("n", "<C-t>", function()
      harpoon:list():select(2)
    end)
    vim.keymap.set("n", "<C-n>", function()
      harpoon:list():select(3)
    end)
    vim.keymap.set("n", "<C-s>", function()
      harpoon:list():select(4)
    end)

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set("n", "<C-S-P>", function()
      harpoon:list():prev()
    end, { noremap = true, desc = "prev buffer" })
    vim.keymap.set("n", "<C-S-N>", function()
      harpoon:list():next()
    end)
  end,
  dependencies = { "nvim-lua/plenary.nvim" },
}
