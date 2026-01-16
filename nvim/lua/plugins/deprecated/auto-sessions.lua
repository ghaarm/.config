-- return {
--   "rmagatti/auto-session",
--   config = function()
--     local auto_session = require("auto-session")

--     auto_session.setup({
--       auto_restore_enabled = false,
--       auto_session_suppress_dirs = { "~/", "~/Dev/", "~/Downloads", "~/Documents", "~/Desktop/" },
--     })

--     local keymap = vim.keymap

--     keymap.set("n", "<leader>wr", "<cmd>SessionRestore<CR>", { desc = "Restore session for cwd" }) -- restore last workspace session for current directory
--     keymap.set("n", "<leader>ws", "<cmd>SessionSave<CR>", { desc = "Save session for auto session root dir" }) -- save workspace session for current working directory
--   end,
-- }

-- return {
--   "rmagatti/auto-session",
--   config = function()
--     local auto_session = require("auto-session")

--     auto_session.setup({
--       auto_restore_enabled = false,
--       auto_session_suppress_dirs = { "~/", "~/Dev/", "~/Downloads", "~/Documents", "~/Desktop/" },
--     })

--     local keymap = vim.keymap

--     -- Funktion zum Generieren eines sicheren Dateinamens
--     local function safe_session_name(name)
--       return name:gsub("[^%w]", "_")
--     end

--     -- Funktion zum Speichern der Sitzung
--     local function save_session()
--       local cwd = vim.fn.getcwd()
--       local session_name = safe_session_name(cwd)
--       local session_path = vim.fn.stdpath('data') .. "/sessions/" .. session_name .. ".vim"
--       vim.cmd("mksession! " .. session_path)
--       print("Session saved: " .. session_name)
--       print("Session path: " .. session_path)
--     end

--     -- Funktion zum Wiederherstellen der Sitzung
--     local function restore_session()
--       local cwd = vim.fn.getcwd()
--       local session_name = safe_session_name(cwd)
--       local session_path = vim.fn.stdpath('data') .. "/sessions/" .. session_name .. ".vim"
--       print("Trying to restore session from: " .. session_path)
--       if vim.fn.filereadable(session_path) == 1 then
--         vim.cmd("source " .. session_path)
--         print("Session restored: " .. session_name)
--       else
--         print("No session found for: " .. session_name)
--       end
--     end

--     keymap.set("n", "<leader>ws", save_session, { desc = "Save session for auto session root dir" }) -- save workspace session for current working directory
--     keymap.set("n", "<leader>wr", restore_session, { desc = "Restore session for cwd" }) -- restore last workspace session for current directory

--     -- Automatische Wiederherstellung der Sitzung beim Starten von Neovim
--     vim.api.nvim_create_autocmd("VimEnter", {
--       callback = function()
--         restore_session()
--       end
--     })
--   end,
-- }


-- langsam aber geht

return {
  "rmagatti/auto-session",
  config = function()
    local auto_session = require("auto-session")

    auto_session.setup({
      auto_restore_enabled = false,
      auto_session_suppress_dirs = { "~/", "~/Dev/", "~/Downloads", "~/Documents", "~/Desktop/" },
    })

    local keymap = vim.keymap

    -- Funktion zum Generieren eines sicheren Dateinamens
    local function safe_session_name(name)
      return name:gsub("[^%w]", "_")
    end

    -- Funktion zum Speichern der Sitzung
    local function save_session()
      local cwd = vim.fn.getcwd()
      local session_name = safe_session_name(cwd)
      local session_path = vim.fn.stdpath('data') .. "/sessions/" .. session_name .. ".vim"
      vim.cmd("mksession! " .. session_path)
      print("Session saved: " .. session_name)
      print("Session path: " .. session_path)
    end

    -- Funktion zum Wiederherstellen der Sitzung
    local function restore_session()
      local cwd = vim.fn.getcwd()
      local session_name = safe_session_name(cwd)
      local session_path = vim.fn.stdpath('data') .. "/sessions/" .. session_name .. ".vim"
      print("Trying to restore session from: " .. session_path)
      if vim.fn.filereadable(session_path) == 1 then
        vim.cmd("source " .. session_path)
        print("Session restored: " .. session_name)
      else
        print("No session found for: " .. session_name)
      end
    end

    keymap.set("n", "<leader>ws", save_session, { desc = "Save session for auto session root dir" })
    keymap.set("n", "<leader>wr", restore_session, { desc = "Restore session for cwd" })

    -- Entferne die automatische Wiederherstellung der Sitzung beim Starten von Neovim
    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function()
        print("Welcome to Neovim! Use <leader>wr to restore the session.")
      end
    })
  end,
}



