local function set_macro(register, keys)
  local macro = vim.api.nvim_replace_termcodes(keys, true, false, true)

  vim.fn.setreg(register, macro)
end

-- @e für Surround curly braces und \enquote vorher [j bedeutet escape
set_macro("e", "S}i\\enquote<ESC>")
