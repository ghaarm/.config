-- return {
--   "R-nvim/R.nvim",
--   lazy = false,
-- }
--
-- Set local leader key
-- vim.g.maplocalleader = ","
-- return {
--   {
--     "R-nvim/R.nvim",
--     lazy = false,
--   },
--   {
--     "nvim-treesitter/nvim-treesitter",
--     run = ":TSUpdate",
--     config = function()
--       require("nvim-treesitter.configs").setup({
--         ensure_installed = { "markdown", "markdown_inline", "r", "rnoweb" },
--       })
--     end,
--   },
--   "R-nvim/cmp-r",
--   {
--     "hrsh7th/nvim-cmp",
--     config = function()
--       require("cmp").setup({ sources = { { name = "cmp_r" } } })
--       require("cmp_r").setup({})
--     end,
--   },
-- {
--   "jpalardy/vim-slime",
--   config = function()
--     vim.g.slime_target = "neovim"
--     vim.g.slime_bracketed_paste = 1
--     vim.g.slime_default_config = {
--       socket_name = "default",
--       target_pane = "{last}",
--     }
--     vim.api.nvim_set_keymap("x", "<localleader><CR>", "<Plug>SlimeRegionSend", {})
--     vim.api.nvim_set_keymap("n", "<localleader><CR>", "<Plug>SlimeLineSend", {})
--   end,
-- },
-- }
--
-- function SendRCode()
--   local line = vim.api.nvim_get_current_line()
--   vim.fn['RSend'](line)
-- end
--
-- -- Keybinding to send R code to terminal
-- vim.api.nvim_set_keymap('n', '<localleader><CR>', '<Cmd>lua SendRCode()<CR>', { noremap = true, silent = true })
-- Function to open R in a vertical split
vim.g.maplocalleader = ","

return {
  {
    "R-nvim/R.nvim",
    config = function()
      -- Create a table with the options to be passed to setup()
      local opts = {
        R_args = {
          -- "--quiet",
          "--no-save",
        },
        hook = {
          on_filetype = function()
            -- This function will be called at the FileType event
            -- of files supported by R.nvim. This is an
            -- opportunity to create mappings local to buffers.
            vim.api.nvim_buf_set_keymap(0, "n", "<Enter>", "<Plug>RDSendLine", {})
            vim.api.nvim_buf_set_keymap(0, "v", "<Enter>", "<Plug>RSendSelection", {})
          end,
        },
        min_editor_width = 72,
        rconsole_width = 78,
        disable_cmds = {
          "RClearConsole",
          "RCustomStart",
          "RSPlot",
          "RSaveClose",
        },
      }

      -- Check if the environment variable "R_AUTO_START" exists.
      -- If using fish shell, you could put in your config.fish:
      -- alias r "R_AUTO_START=true nvim"
      if vim.env.R_AUTO_START == "true" then
        opts.auto_start = 1
        opts.objbr_auto_start = true
      end

      require("r").setup(opts)
    end,
    lazy = false,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "markdown", "markdown_inline", "r", "rnoweb" },
      })
    end,
  },
  "R-nvim/cmp-r",
  {
    "hrsh7th/nvim-cmp",
    config = function()
      require("cmp").setup({ sources = { { name = "cmp_r" } } })
      require("cmp_r").setup({})
    end,
  },
}
