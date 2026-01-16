-- return {
--   "nvim-telescope/telescope.nvim",
--   branch = "0.1.x",
--   dependencies = {
--     "nvim-lua/plenary.nvim",
--     { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
--     "nvim-tree/nvim-web-devicons",
--     "folke/todo-comments.nvim",
--     "nvim-telescope/telescope-bibtex.nvim"
--   },
--   config = function()
--     local telescope = require("telescope")
--     local bibtex_actions = require('telescope-bibtex.actions')
--     local actions = require("telescope.actions")
--     local transform_mod = require("telescope.actions.mt").transform_mod
--
--     local trouble = require("trouble")
--     local trouble_telescope = require("trouble.sources.telescope")
--
--     -- or create your custom action
--     local custom_actions = transform_mod({
--       open_trouble_qflist = function(prompt_bufnr)
--         trouble.toggle("quickfix")
--       end,
--     })
--
--     -- verweis für die mappings von action und bibtex an die keybindings.lua
--     -- local mappings = {}
--     -- for k, v in pairs(_G.telescope_mappings) do
--     --   mappings[k] = actions[v[1]](unpack(v[2]))
--     -- end
--
--     -- local bibtex_mappings = {}
--     -- for k, v in pairs(_G.bibtex_mappings) do
--     --   bibtex_mappings[k] = bibtex_actions[v[1]](unpack(v[2]))
--     -- end
--
--     telescope.setup({
--       defaults = {
--         path_display = { "smart" },
--         mappings = {
--           -- i = mappings,
--           i = {
--             ["<C-k>"] = actions.move_selection_previous, -- move to prev result
--             ["<C-j>"] = actions.move_selection_next, -- move to next result
--             ["<C-q>"] = actions.send_selected_to_qflist + custom_actions.open_trouble_qflist,
--             ["<C-t>"] = trouble_telescope.smart_open_with_trouble,
--           },
--         },
--       },
--       extensions = {
--         bibtex = {
--           depth = 1,
--           -- custom_formats = {},
--           -- format = '',
--           custom_formats = {
--           {id = 'no_cite', cite_marker = '#label#'}
--         },
--           format = 'no_cite',
--           global_files = {'/Users/g/Library/texmf/bibtex/bib/Zotero.bib'},
--           search_keys = { 'author', 'year', 'title' },
--           citation_format = '{{author}} ({{year}}), {{title}}.',
--           citation_trim_firstname = true,
--           citation_max_auth = 2,
--           context = false,
--           context_fallback = true,
--           wrap = false,
--           mappings = {
--             -- i = bibtex_mappings -- bibtexmappings ist neu
--             i = {
--               ["<CR>"] = bibtex_actions.key_append('%s'), -- Aktion anpassen
--               ["<C-e>"] = bibtex_actions.entry_append, -- Aktion anpassen
--               ["<C-c>"] = bibtex_actions.citation_append('{{author}} ({{year}}), {{title}}.'), -- Aktion anpassen
--             }
--           },
--         },
--       },
--     })
--
--     telescope.load_extension('bibtex')
--     telescope.load_extension("fzf")
--     telescope.load_extension("todo-comments")
--
--     -- set keymaps
--     -- local keymap = vim.keymap -- for conciseness
--
--     -- keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
--     -- keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
--     -- keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
--     -- keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
--     -- keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
--     -- -- keymap.set("n", "<leader>fb", "<cmd>Telescope bibtex<cr>", { desc = "Suche Bibtex-Einträge" })
--     -- keymap.set("i", "<D-i>", "<cmd>Telescope bibtex<cr>", { desc = "Open Telescope BibTeX search" }) -- D steht für die Command taste
--
--
--   end,
-- }
--

return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
    "folke/todo-comments.nvim",
    "nvim-telescope/telescope-bibtex.nvim",
    "ThePrimeagen/harpoon", -- Harpoon als Abhängigkeit hinzufügen
    "nvim-telescope/telescope-media-files.nvim"
  },
  config = function()
    local telescope = require("telescope")
    local bibtex_actions = require('telescope-bibtex.actions')
    local actions = require("telescope.actions")
    local transform_mod = require("telescope.actions.mt").transform_mod

    local trouble = require("trouble")
    local trouble_telescope = require("trouble.sources.telescope")
    -- -- HIER NEU: für Telescope Buffer
    -- local builtin = require("telescope.builtin")
    -- local themes = require("telescope.themes")
    -- or create your custom action
    local custom_actions = transform_mod({
      open_trouble_qflist = function(prompt_bufnr)
        trouble.toggle("quickfix")
      end,
    })

    telescope.setup({
      defaults = {
        path_display = { "smart" },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-q>"] = actions.send_selected_to_qflist + custom_actions.open_trouble_qflist,
            ["<C-t>"] = trouble_telescope.smart_open_with_trouble,
          },
        },
      },
      extensions = {
        bibtex = {
          depth = 1,
          custom_formats = {
            { id = 'no_cite', cite_marker = '#label#' }
          },
          format = 'no_cite',
          global_files = { '/Users/g/Library/texmf/bibtex/bib/Zotero.bib' },
          search_keys = { 'author', 'year', 'title' },
          citation_format = '{{author}} ({{year}}), {{title}}.',
          citation_trim_firstname = true,
          citation_max_auth = 2,
          context = false,
          context_fallback = true,
          wrap = false,
          mappings = {
            i = {
              ["<CR>"] = bibtex_actions.key_append('%s'),
              ["<C-e>"] = bibtex_actions.entry_append,
              ["<C-c>"] = bibtex_actions.citation_append('{{author}} ({{year}}), {{title}}.'),
            }
          },
        },
        media_files = {
          -- filetypes whitelist
          -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
          filetypes = { "png", "webp", "jpg", "jpeg", "pdf" },
          -- find command (defaults to `fd`)
          find_cmd = "rg"
        },
      },
    })

    telescope.load_extension('bibtex')
    telescope.load_extension("fzf")
    telescope.load_extension("todo-comments")
    telescope.load_extension("media_files")

    -- Harpoon integration
    local harpoon = require('harpoon')
    harpoon:setup({})

    local conf = require("telescope.config").values
    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
          results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
      }):find()
    end

    vim.keymap.set("n", "<C-e>", function() toggle_telescope(harpoon:list()) end, { desc = "Open harpoon window" })

    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
    keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
    keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
    keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
    keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
    -- keymap.set("n", "<leader>fb", "<cmd>Telescope bibtex<cr>", { desc = "Suche Bibtex-Einträge" })
    keymap.set("i", "<D-i>", "<cmd>Telescope bibtex<cr>", { desc = "Open Telescope BibTeX search" }) -- D steht für die Command taste

    -- keymap.set("n", "<S-h>", function()
    --   builtin.buffers(themes.get_ivy({
    --     sort_mru = true,
    --     sort_lastused = true,
    --     ignore_current_buffer = true,
    --     initial_mode = "normal", -- optional
    --   }))
    -- end, { desc = "[P]Open telescope buffers" })
    --
    -- multigrep von tj devries https://www.youtube.com/watch?v=xdXE1tOT-qg
    require "josean.plugins.telescope.multigrep".setup()
    local function set_telescope_prompt_orange()
      local orange = "#d78700" -- dunkles Orange; alternativ: "#c25f00"

      -- Text im Eingabefeld
      vim.api.nvim_set_hl(0, "TelescopePromptNormal", { fg = orange })

      -- Das Prefix links vom Prompt (Lupe / >)
      vim.api.nvim_set_hl(0, "TelescopePromptPrefix", { fg = orange })

      -- Rahmen um das Prompt-Fenster
      vim.api.nvim_set_hl(0, "TelescopePromptBorder", { fg = orange })

      -- Optional: Titel des Prompt-Fensters
      vim.api.nvim_set_hl(0, "TelescopePromptTitle", { fg = orange, bold = true })

      -- Optional: Cursor im Prompt gut sichtbar (je nach Theme)
      -- vim.api.nvim_set_hl(0, "TelescopePromptCursor", { fg = orange })
    end

    -- Bei jedem Colorscheme erneut anwenden
    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = set_telescope_prompt_orange,
    })

    -- Sofort anwenden (falls Colorscheme schon aktiv ist)
    set_telescope_prompt_orange()
  end,
}
