-- Andrew Courter https://www.youtube.com/watch?v=q1QhV-24DNA

return {
  'stevearc/oil.nvim',
  opts = {},
  -- Optional dependencies
  -- dependencies = { { "echasnovski/mini.icons", opts = {} } },
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
  config = function()
    require("oil").setup({
      default_file_explorer = true,
      delete_to_trash = true,
      skip_confirm_for_simple_edits = true,
      view_options = {
        show_hidden = true,      -- Use `show_hidden` instead of `how_hidden`
        natural_order = true,
        case_insensitive = true, -- Diese Zeile ändert die Sortierung auf case-insensitive
        sort = {
          -- Behalte die Sortierung nach Typ (Ordner zuerst) bei
          { "type", "asc" },
          -- Füge case_insensitive für die alphabetische Sortierung hinzu
          { "name", "asc" },
        },
        -- is_always_hidden = function(name, _)
        --   return name == '..' or name == '.git'
        -- end,
      },
      win_options = {
        wrap = true,
      },
      keymaps = {
        ["<CR>"] = function()
          local oil = require("oil")
          local entry = oil.get_cursor_entry()
          if not entry then return end

          local dir = oil.get_current_dir() or ""
          local path = dir .. entry.name

          -- Nur Dateien (keine Ordner) und nur PDFs mit sioyek öffnen
          if entry.type ~= "directory" and path:lower():match("%.pdf$") then
            if vim.fn.executable("sioyek") ~= 1 then
              vim.notify("sioyek nicht im PATH gefunden", vim.log.levels.WARN)
              return
            end
            -- Listenform von jobstart: sicher bei Leerzeichen
            vim.fn.jobstart({ "sioyek", path }, { detach = true })
            return
          end

          -- Standard-Enter-Verhalten für alles andere (Ordner/Dateien)
          require("oil.actions").select.callback()
        end,
      },

      -- --  Hier kommen die Oil-Keymaps rein
      -- keymaps = {
      --   -- Öffne PDFs mit sioyek, sonst normal öffnen
      --   ["<leader>p"] = function()
      --     local oil = require("oil")
      --     local entry = oil.get_cursor_entry()
      --     if not entry then return end
      --
      --     local dir = oil.get_current_dir() or ""
      --     local path = dir .. entry.name
      --
      --     if path:match("%.pdf$") then
      --       -- Robust: jobstart in Listenform (kein Escaping nötig)
      --       local ok = vim.fn.executable("sioyek") == 1
      --       if not ok then
      --         vim.notify("sioyek nicht im PATH gefunden", vim.log.levels.WARN)
      --         return
      --       end
      --       vim.fn.jobstart({ "sioyek", path }, { detach = true })
      --       return
      --     end
      --
      --     -- Nicht-PDFs wie gewohnt in Oil öffnen
      --     require("oil.actions").select.callback()
      --   end,
      --
      --   -- Optional: „gx“ öffnet mit System-Default (Oil bringt das schon mit)
      --   -- ["gx"] = "actions.open_external",
      -- }
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "oil",
        callback = function(args)
          local bufnr = args.buf
          vim.keymap.set("n", "<leader>p", function()
            local oil = require("oil")
            local entry = oil.get_cursor_entry()
            if not entry then return end
            local dir = oil.get_current_dir() or ""
            local path = dir .. entry.name
            if path:match("%.pdf$") then
              if vim.fn.executable("sioyek") ~= 1 then
                vim.notify("sioyek nicht im PATH gefunden", vim.log.levels.WARN)
                return
              end
              vim.fn.jobstart({ "sioyek", "--new-window", path }, { detach = true })
              -- vim.fn.jobstart({ "sioyek", path }, { detach = true })
            else
              require("oil.actions").select.callback()
            end
          end, { buffer = bufnr, noremap = true, silent = true, desc = "Open PDF with sioyek" })
        end,
      })
    })
  end,
  vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
}
