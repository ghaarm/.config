-- --https://github.com/Pocco81/auto-save.nvim
-- return {
--   "pocco81/auto-save.nvim",
--   config = function()
--     require("auto-save").setup({
--       enabled = true, -- start auto-save when the plugin is loaded (i.e. when your package manager loads it)
--       execution_message = {
--         message = function() -- message to print on save
--           return ("AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"))
--         end,
--         dim = 0.18, -- dim the color of `message`
--         cleaning_interval = 1250, -- (milliseconds) automatically clean MsgArea after displaying `message`. See :h MsgArea
--       },
--       -- TextChanged = wenn Text geändert wird
--       -- trigger_events = {"InsertLeave", "TextChanged" }, -- vim events that trigger auto-save. See :h events
--
--       -- FocusLost = wenn ich das Fenster wechsele
--       trigger_events = { "InsertLeave", "FocusLost" }, -- vim events that trigger auto-save. See :h events
--       condition = function(buf)
--         local fn = vim.fn
--         local utils = require("auto-save.utils.data")
--
--         -- Harpoon-UI nicht autosaven
--         if fn.getbufvar(buf, "&filetype") == "harpoon" then
--           return false
--         end
--
--         if fn.getbufvar(buf, "&modifiable") == 1 and utils.not_in(fn.getbufvar(buf, "&filetype"), {}) then
--           return true -- met condition(s), can save
--         end
--         return false -- can't save
--       end,
--       write_all_buffers = false, -- write all buffers when the current one meets `condition`
--       debounce_delay = 500, -- saves the file at most every `debounce_delay` milliseconds, ÄNDERN WENN ZU SCHNELL gespeichert wird
--       callbacks = { -- functions to be executed at different intervals
--         enabling = nil, -- ran when enabling auto-save
--         disabling = nil, -- ran when disabling auto-save
--         before_asserting_save = nil, -- ran before checking `condition`
--         before_saving = nil, -- ran before doing the actual save
--         after_saving = nil, -- ran after doing the actual save
--       },
--     })
--
--     -- Set keymap for toggling auto-save
--     vim.api.nvim_set_keymap("n", "<leader>ns", ":ASToggle<CR>", { noremap = true, silent = true })
--   end,
-- }
--
--
-- in oil kein autosave
return {
  "pocco81/auto-save.nvim",
  config = function()
    require("auto-save").setup({
      enabled = true,
      execution_message = {
        message = function()
          return ("AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"))
        end,
        dim = 0.18,
        cleaning_interval = 1250,
      },

      trigger_events = { "InsertLeave", "FocusLost" },

      condition = function(buf)
        local fn = vim.fn
        local utils = require("auto-save.utils.data")
        local ft = fn.getbufvar(buf, "&filetype")

        -- Harpoon-UI nicht autosaven
        if ft == "harpoon" then
          return false
        end

        -- Oil nicht autosaven
        if ft == "oil" then
          return false
        end

        if fn.getbufvar(buf, "&modifiable") == 1 and utils.not_in(ft, {}) then
          return true
        end
        return false
      end,

      write_all_buffers = false,
      debounce_delay = 500,
      callbacks = {
        enabling = nil,
        disabling = nil,
        before_asserting_save = nil,
        before_saving = nil,
        after_saving = nil,
      },
    })

    vim.api.nvim_set_keymap("n", "<leader>ns", ":ASToggle<CR>", { noremap = true, silent = true })
  end,
}
