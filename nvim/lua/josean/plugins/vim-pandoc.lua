-- https://github.com/vim-pandoc/vim-pandoc/blob/master/README.mkd
return {
  "vim-pandoc/vim-pandoc",
  config = function()
    -- Setze den lokalen Leader-Key auf Komma
    -- vim.g.maplocalleader = ","
    -- Automatische Erkennung von pandoc Dateien aktivieren
    vim.g["pandoc#filetypes#pandoc_markdown"] = 1

    -- Verwende pandoc als Compiler
    vim.g["pandoc#modules#enabled"] = { "formatting", "folding", "completion" }

    -- Konfiguration des PDF-Exports über LaTeX
    vim.g["pandoc#command#latex_engine"] = 'xelatex' -- oder 'pdflatex', 'lualatex', etc.
  end
}
