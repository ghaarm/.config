return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local lualine = require("lualine")
    local lazy_status = require("lazy.status") -- to configure lazy pending updates count

    local colors = {
      blue = "#65D1FF", -- von josean
      -- blue = "#00008B", -- von mir dunkles blau
      -- green = "#3EFFDC", -- von josean
      -- green = "#006400", -- von mir dunkelgrün
      green = "#b8bb26",  -- von mir dunkelgrün nach gruvbox https://github.com/morhetz/gruvbox
      -- violet = "#FF61EF", -- von josean
      violet = "#d3869b", -- von mir purple nach Gruvbox
      yellow = "#FFDA7B",
      -- red = "#FF4A4A", -- von josean
      -- red = "#8B0000", -- von mir dukles rot
      red = "#d65d0e", -- von mir orange nach gruvbox https://github.com/morhetz/gruvbox
      fg = "#c3ccdc",
      bg = "#112638",
      inactive_bg = "#2c3043",
    }

    local my_lualine_theme = {
      normal = {
        a = { bg = colors.green, fg = colors.bg, gui = "bold" },
        b = { bg = colors.bg, fg = colors.fg },
        c = { bg = colors.bg, fg = colors.fg },
      },
      insert = {
        a = { bg = colors.red, fg = colors.bg, gui = "bold" },
        b = { bg = colors.bg, fg = colors.fg },
        c = { bg = colors.bg, fg = colors.fg },
      },
      visual = {
        a = { bg = colors.violet, fg = colors.bg, gui = "bold" },
        b = { bg = colors.bg, fg = colors.fg },
        c = { bg = colors.bg, fg = colors.fg },
      },
      command = {
        a = { bg = colors.yellow, fg = colors.bg, gui = "bold" },
        b = { bg = colors.bg, fg = colors.fg },
        c = { bg = colors.bg, fg = colors.fg },
      },
      replace = {
        a = { bg = colors.blue, fg = colors.bg, gui = "bold" },
        b = { bg = colors.bg, fg = colors.fg },
        c = { bg = colors.bg, fg = colors.fg },
      },
      inactive = {
        a = { bg = colors.inactive_bg, fg = colors.semilightgray, gui = "bold" },
        b = { bg = colors.inactive_bg, fg = colors.semilightgray },
        c = { bg = colors.inactive_bg, fg = colors.semilightgray },
      },
    }

    -- configure lualine with modified theme
    lualine.setup({
      options = {
        -- theme = my_lualine_theme,
        -- theme = 'gruvbox-flat',

        -- theme = "kanagawa",
        theme = "nightfox",
        -- theme = "catppuccin",
        component_separators = "", -- Entfernt die kleinen Pfeile zwischen Komponenten
        -- section_separators = "", -- Entfernt die großen Pfeile zwischen den Sektionen
      },

      sections = {
        lualine_a = { 'mode' },   -- Zeigt den Modus wie NORMAL, INSERT etc.
        lualine_b = { 'branch' }, -- Zeigt den Git-Branch wie main

        lualine_c = {
          '%=', -- Aligner für die Mitte
          {
            function()
              -- Absoluter Pfad der Datei
              local filepath = vim.fn.expand('%:p')
              local path_sep = package.config:sub(1, 1) -- OS-spezifischer Separator

              -- Zerlege den Pfad in Teile
              local parts = {}
              for part in string.gmatch(filepath, '[^' .. path_sep .. ']+') do
                table.insert(parts, part)
              end

              -- Letzte 3 Ordner + Dateiname
              local start_idx = math.max(#parts - 3, 1)
              local display_path = table.concat(vim.list_slice(parts, start_idx), path_sep)

              -- Füge den Dateinamen hinzu
              local filename = vim.fn.expand('%:t')

              -- Gesamter Pfad inkl. Dateiname
              return display_path .. path_sep .. filename
            end,
            shorting_target = 30, -- Kürzt den Pfad bei Bedarf
          },
          -- {
          --   'filename',
          --   path = 2,             -- 2 Absoluter Pfad, q relativer Pfad
          --   shorting_target = 30, -- Kürzt den Pfad bei Bedarf
          -- },
          -- '%=',                   -- Aligner für die Mitte
        },

        lualine_x = { -- Rechtsbündige Infos
          {
            lazy_status.updates,
            cond = lazy_status.has_updates,
            color = { fg = "#ff9e64" },
          },
          { 'encoding' },
          { 'fileformat' },
          { 'filetype' },
        },

        lualine_y = {},
        lualine_z = {},
      }
    })
  end,
}
