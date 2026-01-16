-- https://github.com/ahmedkhalf/project.nvim
-- damit R automatisch das Root Verzeichnis erkennt
--
--
return {
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup({
        detection_methods = { "pattern" }, -- oder { "lsp", "pattern" }
        patterns = { ".git", "*.Rproj" },  -- hier ergänzt du RStudio-Projekte
      })
    end,
  },
}
