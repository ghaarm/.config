return {
  "svermeulen/vim-easyclip",
  dependencies = {
    "tpope/vim-repeat",
  },
  config = function()
    -- Erstellt eine Tastenkombination für 'gm', um einen Marker zu setzen
    -- vim.api.nvim_set_keymap("n", "gm", ":lua set_mark()<CR>", { noremap = true, silent = true })

    -- Definiert die Funktion set_mark in Lua
    -- function set_mark()
    -- Startet den Befehl 'm', erwartet dann eine weitere Taste für die Markierung
    -- vim.cmd("normal! m")
    -- vim.fn.feedkeys("m", "n")
    -- end
  end,
}
