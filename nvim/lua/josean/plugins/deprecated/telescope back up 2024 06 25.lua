return {
  "nvim-/.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-/-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
    "folke/todo-comments.nvim",
    "nvim-/-bibtex.nvim",
  },
  config = function()
    local  = require("")
    local actions = require(".actions")
    
    .setup({
      defaults = {
        path_display = { "smart" },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          },
        },
      },
    })

    -- Configure extensions
    .load_extension("fzf")
    .load_extension("todo-comments")
    
    -- Define bibtex extension settings
    .setup{
      extensions = {
        bibtex = {
          depth = 1,
          global_files = { '~/Library/texmf/bibtex/bib/Zotero.bib' },
          search_keys = { 'author', 'year', 'title' },
          citation_format = '{{author}} ({{year}}), {{title}}.',
          citation_trim_firstname = true,
          citation_max_auth = 2,
          custom_formats = {
            { id = 'citet', cite_maker = '\\citet{%s}' }
          },
        },
      },
    }

    -- Define keymaps
    local keymap = vim.keymap
    keymap.set("n", "<leader>ff", "<cmd> find_files<cr>", { desc = "Fuzzy find files in cwd" })
    keymap.set("n", "<leader>fr", "<cmd> oldfiles<cr>", { desc = "Fuzzy find recent files" })
    keymap.set("n", "<leader>fs", "<cmd> live_grep<cr>", { desc = "Find string in cwd" })
    keymap.set("n", "<leader>fc", "<cmd> grep_string<cr>", { desc = "Find string under cursor in cwd" })
    keymap.set("n", "<leader>ft", "<cmd> todo_comments<cr>", { desc = "Find todos" })
  end,
}
