-- https://github.com/svermeulen/vim-easyclip

return {
  "svermeulen/vim-easyclip",
  dependencies = {
    "tpope/vim-repeat",
  },
  init = function()
    vim.g.EasyClipUseGlobalPasteToggle = 0 -- weil es sonst einen error mit easyclip gibt
    -- Optional: wenn du pastetoggle trotzdem nutzen willst:
    -- vim.o.pastetoggle = "<Plug>PasteToggle"
  end,

  -- Läuft NACH dem Laden des Plugins: Keymaps/Overrides
  config = function()
    -- Optional: falls schon gemappt, erst löschen
    -- EasyClip default mapping entfernen (falls es existiert)
    pcall(vim.keymap.del, "n", "<Plug>EasyClipPasteUnformattedAfter")
    pcall(vim.keymap.del, "n", "<Plug>EasyClipPasteUnformattedBefore")
    pcall(vim.keymap.del, "n", "<leader>p")
    -- pcall(vim.keymap.del, "n", "<leader>pP")
    -- Leader + p p -> unformatted paste after
    -- vim.keymap.set("n", "<leader>ppp", "<cmd>EasyClipPasteUnformattedAfter<CR>", {
    --   silent = true,
    --   desc = "EasyClip: paste unformatted after",
    -- })
    -- vim.keymap.set("n", "<leader>ppP", "<cmd>EasyClipPasteUnformattedBefore<CR>", {
    --   silent = true,
    --   desc = "EasyClip: paste unformatted before",
    -- })
    -- Erstellt eine Tastenkombination für 'gm', um einen Marker zu setzen
    -- vim.api.nvim_set_keymap("n", "gm", ":lua set_mark()<CR>", { noremap = true, silent = true })

    -- Definiert die Funktion set_mark in Lua
    -- function set_mark()
    -- Startet den Befehl 'm', erwartet dann eine weitere Taste für die Markierung
    -- vim.cmd("normal! m")
    -- vim.fn.feedkeys("m", "n")
    -- end
    -- Löscht ausschließlich das 'dm'-Mapping von EasyClip
  end,
}
