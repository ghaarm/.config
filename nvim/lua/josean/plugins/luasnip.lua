return {
  "L3MON4D3/LuaSnip",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("luasnip.loaders.from_snipmate").load({ paths = "~/.config/nvim/snippets/" })
  end,
}

-- return {
--   "L3MON4D3/LuaSnip",
--   event = { "BufReadPre", "BufNewFile" },
--   config = function()
--     local ls = require("luasnip")
--     local s = ls.snippet
--     local t = ls.text_node
--     local i = ls.insert_node
--     local f = ls.function_node
--
--     ls.snippets = {
--       all = {
--         s("citef", {
--           -- Funktion, die prüft, ob das letzte Zeichen ein Leerzeichen ist und es entfernt
--           f(function(_, parent)
--             local line = vim.api.nvim_get_current_line()
--             local col = vim.api.nvim_win_get_cursor(0)[2]
--             if col > 0 and line:sub(col, col):match("%s") then
--               -- Führt ein Backspace aus, um das Leerzeichen zu entfernen
--               vim.api.nvim_input("<BS>")
--             end
--             return ""
--           end, {}),
--           t("\\footnote{\\cite{"),
--           -- Erwartet den Namen
--           i(1, "name"),
--           t("}, S. "),
--           -- Erwartet die Seitennummer
--           i(2, "Seite"),
--           t("}"),
--         }),
--       },
--     }
--
--     -- Stellt sicher, dass der Cursor ordnungsgemäß weitergeht
--     vim.api.nvim_set_keymap("i", "<Tab>", "luasnip#jump(1)", { expr = true, noremap = true })
--     vim.api.nvim_set_keymap("s", "<Tab>", "luasnip#jump(1)", { expr = true, noremap = true })
--     vim.api.nvim_set_keymap("i", "<S-Tab>", "luasnip#jump(-1)", { expr = true, noremap = true })
--     vim.api.nvim_set_keymap("s", "<S-Tab>", "luasnip#jump(-1)", { expr = true, noremap = true })
--   end,
-- }
