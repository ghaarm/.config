-- return {
--   "jedrzejboczar/possession.nvim",
--   dependencies = {
--     "nvim-lua/plenary.nvim",
--     "nvim-telescope/telescope.nvim",
--   },
--   config = function()
--     require("possession").setup({
--       -- Für deine Situation (teils mehrere Projekte im gleichen Ordner):
--       -- eher NICHT blind nach CWD autoloaden, sondern gezielt per Picker laden.
--       autoload = false,
--
--       autosave = {
--         current = true, -- speichert die aktuell geladene Session beim Beenden/Wechsel
--         on_load = true,
--         on_quit = true,
--       },
--
--       -- Optional: lualine nach save/load refreshen (falls genutzt)
--       hooks = {
--         after_load = function()
--           pcall(function()
--             vim.schedule(function() require("lualine").refresh() end)
--           end)
--         end,
--         after_save = function()
--           pcall(function()
--             vim.schedule(function() require("lualine").refresh() end)
--           end)
--         end,
--       },
--     })
--
--     -- Telescope Extension aktivieren :contentReference[oaicite:0]{index=0}
--     require("telescope").load_extension("possession")
--
--     -- Keymaps (Leader = Space)
--     local telescope_possession = function(opts)
--       require("telescope").extensions.possession.list(opts or {})
--     end
--
--     vim.keymap.set("n", "<leader>sl", function()
--       telescope_possession()
--     end, { desc = "Sessions: Liste (Telescope)" })
--
--     vim.keymap.set("n", "<leader>sL", function()
--       telescope_possession({ only_cwd = true })
--     end, { desc = "Sessions: nur aktuelles CWD (Telescope)" })
--
--     vim.keymap.set("n", "<leader>sS", "<cmd>PossessionSave<cr>", { desc = "Session speichern" })
--     vim.keymap.set("n", "<leader>sr", "<cmd>PossessionRename<cr>", { desc = "Session umbenennen" })
--     vim.keymap.set("n", "<leader>sd", "<cmd>PossessionDelete<cr>", { desc = "Session löschen" })
--   end,
-- }
--
return {
  "jedrzejboczar/possession.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    require("possession").setup({
      -- Für deine Situation (teils mehrere Projekte im gleichen Ordner):
      -- eher NICHT blind nach CWD autoloaden, sondern gezielt per Picker laden.
      autoload = false,

      autosave = {
        current = true, -- speichert die aktuell geladene Session beim Beenden/Wechsel
        on_load = true,
        on_quit = true,
      },
      plugins = {
        delete_hidden_buffers = {
          -- WICHTIG: nicht vor dem Speichern löschen, sonst verschwinden "hidden" Dateien aus der Session
          hooks = { "before_load" },

          -- Terminal-Buffers beim Aufräumen force-deleten, damit E89 nicht blockiert
          force = function(bufnr)
            return vim.bo[bufnr].buftype == "terminal"
          end,
        },
      },

      hooks = {
        before_load = function(_, user_data)
          return user_data
        end,
        after_load = function()
          vim.schedule(function() pcall(vim.cmd, "redrawstatus") end)
        end,
        after_save = function()
          vim.schedule(function() pcall(vim.cmd, "redrawstatus") end)
        end,
      },
    })

    -- Telescope Extension aktivieren :contentReference[oaicite:0]{index=0}
    require("telescope").load_extension("possession")

    -- Keymaps (Leader = Space)
    local telescope_possession = function(opts)
      require("telescope").extensions.possession.list(opts or {})
    end

    vim.keymap.set("n", "<leader>sl", function()
      telescope_possession()
    end, { desc = "Sessions: Liste (Telescope)" })

    vim.keymap.set("n", "<leader>sL", function()
      telescope_possession({ only_cwd = true })
    end, { desc = "Sessions: nur aktuelles CWD (Telescope)" })

    vim.keymap.set("n", "<leader>sS", "<cmd>PossessionSave<cr>", { desc = "Session speichern" })
    vim.keymap.set("n", "<leader>sr", "<cmd>PossessionRename<cr>", { desc = "Session umbenennen" })
    vim.keymap.set("n", "<leader>sd", "<cmd>PossessionDelete<cr>", { desc = "Session löschen" })
  end,
}
