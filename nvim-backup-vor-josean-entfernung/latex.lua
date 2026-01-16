-- local function insert_item()
--   local line = vim.api.nvim_get_current_line()
--   local col = vim.api.nvim_win_get_cursor(0)[2]
  
--   if string.match(line, "^%s*\\item[%s-]*.*") then
--       -- Wenn der Cursor am Ende der Zeile steht, neues \item einfügen
--       if col == #line then
--           return "\n\\item "
--       else
--           return "\n"
--       end
--   else
--       return "\n"
--   end
-- end

-- -- Mapping für die Enter-Taste, um die Funktion aufzurufen
-- vim.api.nvim_set_keymap('i', '<CR>', 'v:lua.insert_item()', { expr = true, noremap = true })

-- -- Die Funktion global verfügbar machen
-- _G.insert_item = insert_item


-- local function insert_item()
--   -- Hole die aktuelle Zeile und Cursor-Position
--   local line = vim.api.nvim_get_current_line()
--   local col = vim.api.nvim_win_get_cursor(0)[2]
  
--   -- Prüfe, ob die aktuelle Zeile mit \item beginnt
--   if string.match(line, "^%s*\\item[%s-]*.*") then
--       -- Wenn der Cursor am Ende der Zeile steht, neues \item einfügen
--       if col == #line then
--           return "\r\\item "
--       else
--           return "\r"
--       end
--   else
--       return "\r"
--   end
-- end

-- -- Mapping für die Enter-Taste, um die Funktion aufzurufen
-- vim.api.nvim_set_keymap('i', '<CR>', 'v:lua.insert_item()', { expr = true, noremap = true })

-- -- Die Funktion global verfügbar machen
-- _G.insert_item = insert_item
local M = {}

-- Funktion, die \item einfügt, wenn du dich in einer itemize-Umgebung befindest
M.insert_item = function()
    local line = vim.api.nvim_get_current_line()
    local col = vim.api.nvim_win_get_cursor(0)[2]

    -- Debugging-Ausgaben
    vim.api.nvim_out_write("Line: " .. line .. "\n")
    vim.api.nvim_out_write("Col: " .. tostring(col) .. "\n")

    -- Prüfe, ob die aktuelle Zeile mit \item beginnt
    if string.match(line, "^%s*\\item[%s-]*.*") then
        vim.api.nvim_out_write("Item detected, inserting new item\n")
        -- Sende Tastensequenz für neue Zeile und \item
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("\r\\item ", true, false, true), 'n', false)
        return ""
    else
        vim.api.nvim_out_write("No item detected, normal newline\n")
        return "\r"
    end
end

-- Mapping für die Enter-Taste, um die Funktion aufzurufen
vim.api.nvim_set_keymap('i', '<CR>', 'v:lua.require("latex").insert_item()', { expr = true, noremap = true })

return M



