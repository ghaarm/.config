-- keymap um file direkt zu sourcen
vim.keymap.set("n", "<leader><leader>x", function()
  local file = vim.fn.expand("%:p")
  if file:match("%.lua$") then
    vim.cmd("luafile " .. vim.fn.fnameescape(file))
  else
    vim.cmd("source " .. vim.fn.fnameescape(file))
  end
  vim.notify("Sourced: " .. file)
end, { desc = "Source current file" })

vim.notify("functions.lua loaded (end)")
