-- https://github.com/xuhdev/vim-latex-live-preview

return {
  "xuhdev/vim-latex-live-preview",
  lazy = true, -- Lädt das Plugin nur, wenn es benötigt wird
  ft = { "tex" }, -- Lädt das Plugin nur für LaTeX-Dateien
  setup = function()
    -- Basis-Konfiguration für LaTeX Live Preview
    -- vim.g.livepreview_previewer = "skim" -- Beispiel: Nutzt Zathura als PDF-Viewer
    vim.g.livepreview_previewer = "open -a skim" -- Beispiel: Nutzt Zathura als PDF-Viewer
    --(doesn't work well when the pdf file updates too frequently):
    --let g:livepreview_previewer = 'open -a Skim'
    vim.g.livepreview_use_biber = 1 -- Aktiviert Biber für Bibliographieverwaltung
    vim.g.livepreview_engine = "pdflatex" -- Setzt pdflatex als TeX-Engine mit Optionen
  end,
}
