-- Funktion zum Berechnen der relativen Breite
function get_nvim_tree_width()
  local total_width = vim.api.nvim_get_option("columns")
  local tree_width = math.floor(total_width * 0.33) -- 25% der Gesamtbreite
  return tree_width
end

-- Funktion zum Duplizieren einer Datei
function duplicate_file()
  local api = require('nvim-tree.api')
  local node = api.tree.get_node_under_cursor()

  if node == nil then
    print("Keine Datei unter dem Cursor")
    return
  end

  local filepath = node.absolute_path
  local extension = filepath:match("^.+(%..+)$")
  local new_filepath

  if extension then
    new_filepath = filepath:gsub("%" .. extension .. "$", "-kopie" .. extension)
  else
    new_filepath = filepath .. "-kopie"
  end

  -- Datei kopieren
  vim.fn.system({ 'cp', filepath, new_filepath })

  -- Nvim-tree aktualisieren, um die neue Datei anzuzeigen
  api.tree.reload()
  print("Datei dupliziert: " .. new_filepath)
end

-- Funktion zum Öffnen von PDF-Dateien mit sioyek
local function open_with_sioyek(node)
  if node.name:match("%.pdf$") then
    -- local cmd = "sioyek " .. vim.fn.fnameescape(node.absolute_path)
    local cmd = "sioyek " .. vim.fn.shellescape(node.absolute_path)
    vim.fn.jobstart(cmd, { detach = true })
    require 'nvim-tree.actions.node.open-file'.fn('edit')
  end
end

-- Funktion zum Öffnen von PDF-Dateien mit zathura
-- local function open_with_sioyek(node)
--   if node.name:match("%.pdf$") then
--     -- local cmd = "sioyek " .. vim.fn.fnameescape(node.absolute_path)
--     local cmd = "preview" .. vim.fn.shellescape(node.absolute_path)
--     vim.fn.jobstart(cmd, { detach = true })
--     require 'nvim-tree.actions.node.open-file'.fn('edit')
--   end
-- end



return {
  "nvim-tree/nvim-tree.lua",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    local nvimtree = require("nvim-tree")

    -- recommended settings from nvim-tree documentation
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    nvimtree.setup({
      view = {
        -- width = 35,
        width = get_nvim_tree_width(),
        relativenumber = true,
      },
      -- change folder arrow icons
      renderer = {
        indent_markers = {
          enable = true,
        },
        icons = {
          glyphs = {
            folder = {
              arrow_closed = "", -- arrow when folder is closed
              arrow_open = "", -- arrow when folder is open
            },
          },
        },
      },
      -- disable window_picker for
      -- explorer to work well with
      -- window splits
      actions = {
        open_file = {
          window_picker = {
            enable = false,
          },
        },
      },
      filters = {
        custom = { ".DS_Store" },
      },
      git = {
        ignore = false,
      },
    })

    -- set keymaps
    local keymap = vim
        .keymap                                                                                                         -- for conciseness

    keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })                         -- toggle file explorer
    keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current file" }) -- toggle file explorer on current file
    keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" })                     -- collapse file explorer
    keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" })                       -- refresh file explorer

    keymap.set("n", "<leader>d", ":lua duplicate_file()<CR>", { noremap = true, silent = true, desc = "Duplicate file" })

    keymap.set(
      'n',
      '<leader>p',
      function() open_with_sioyek(require 'nvim-tree.lib'.get_node_at_cursor()) end,
      { noremap = true, silent = true, desc = "Open PDF with sioyek" }
    )
  end
}
