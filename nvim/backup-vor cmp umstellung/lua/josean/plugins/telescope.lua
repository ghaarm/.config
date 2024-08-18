return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
    "folke/todo-comments.nvim",
    "nvim-telescope/telescope-bibtex.nvim"
  },
  config = function()
    local telescope = require("telescope")
    local bibtex_actions = require('telescope-bibtex.actions')
    local actions = require("telescope.actions")
    local transform_mod = require("telescope.actions.mt").transform_mod

    local trouble = require("trouble")
    local trouble_telescope = require("trouble.sources.telescope")

    -- or create your custom action
    local custom_actions = transform_mod({
      open_trouble_qflist = function(prompt_bufnr)
        trouble.toggle("quickfix")
      end,
    })

    -- verweis für die mappings von action und bibtex an die keybindings.lua
    -- local mappings = {}
    -- for k, v in pairs(_G.telescope_mappings) do
    --   mappings[k] = actions[v[1]](unpack(v[2]))
    -- end

    -- local bibtex_mappings = {}
    -- for k, v in pairs(_G.bibtex_mappings) do
    --   bibtex_mappings[k] = bibtex_actions[v[1]](unpack(v[2]))
    -- end

    telescope.setup({
      defaults = {
        path_display = { "smart" },
        mappings = {
          -- i = mappings,
          i = {
            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            ["<C-j>"] = actions.move_selection_next, -- move to next result
            ["<C-q>"] = actions.send_selected_to_qflist + custom_actions.open_trouble_qflist,
            ["<C-t>"] = trouble_telescope.smart_open_with_trouble,
          },
        },
      },
      extensions = {
        bibtex = {
          depth = 1,
          -- custom_formats = {},
          -- format = '',
          custom_formats = {
          {id = 'no_cite', cite_marker = '#label#'}
        },
          format = 'no_cite',
          global_files = {'/Users/g/Library/texmf/bibtex/bib/Zotero.bib'},
          search_keys = { 'author', 'year', 'title' },
          citation_format = '{{author}} ({{year}}), {{title}}.',
          citation_trim_firstname = true,
          citation_max_auth = 2,
          context = false,
          context_fallback = true,
          wrap = false,
          mappings = {
            -- i = bibtex_mappings -- bibtexmappings ist neu
            i = { 
              ["<CR>"] = bibtex_actions.key_append('%s'), -- Aktion anpassen
              ["<C-e>"] = bibtex_actions.entry_append, -- Aktion anpassen
              ["<C-c>"] = bibtex_actions.citation_append('{{author}} ({{year}}), {{title}}.'), -- Aktion anpassen
            }
          },
        },
      },
    })

    telescope.load_extension('bibtex')
    telescope.load_extension("fzf")
    telescope.load_extension("todo-comments")

    -- set keymaps
    -- local keymap = vim.keymap -- for conciseness

    -- keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
    -- keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
    -- keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
    -- keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
    -- keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
    -- -- keymap.set("n", "<leader>fb", "<cmd>Telescope bibtex<cr>", { desc = "Suche Bibtex-Einträge" })
    -- keymap.set("i", "<D-i>", "<cmd>Telescope bibtex<cr>", { desc = "Open Telescope BibTeX search" }) -- D steht für die Command taste


  end,
}