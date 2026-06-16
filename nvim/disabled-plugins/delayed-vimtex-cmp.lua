-- return {
--   "micangl/cmp-vimtex",
--   -- lazy = true, -- Lädt das Plugin nur, wenn es benötigt wird
--   ft = { "tex", "plaintex", "bib", "rnw" }, -- Lädt das Plugin nur für LaTeX-Dateien und R sweave dateien
--   config = function()
--     require("cmp_vimtex").setup({
--       additional_information = {
--         info_in_menu = true,
--         info_in_window = true,
--         info_max_length = 60,
--         match_against_info = true,
--         symbols_in_menu = true,
--       },
--       bibtex_parser = {
--         enabled = true,
--       },
--       search = {
--         browser = "xdg-open",
--         default = "google_scholar",
--         search_engines = {
--           google_scholar = {
--             name = "Google Scholar",
--             get_url = require("cmp_vimtex").url_default_format("https://scholar.google.com/scholar?hl=en&q=%s"),
--           },
--           -- Other search engines.
--         },
--       },
--     })
--   end,
-- }
return {
  "micangl/cmp-vimtex",
  ft = { "tex", "plaintex", "bib", "rnw" },
  dependencies = { "lervag/vimtex", "hrsh7th/nvim-cmp" },
  config = function()
    local function setup_cmp_vimtex()
      require("cmp_vimtex").setup({
        additional_information = {
          info_in_menu = true,
          info_in_window = true,
          info_max_length = 60,
          match_against_info = true,
          symbols_in_menu = true,
        },
        bibtex_parser = { enabled = true },
        search = {
          browser = "xdg-open",
          default = "google_scholar",
          search_engines = {
            google_scholar = {
              name = "Google Scholar",
              get_url = require("cmp_vimtex").url_default_format("https://scholar.google.com/scholar?hl=en&q=%s"),
            },
          },
        },
      })
    end

    -- Wenn vimtex schon da ist, direkt; sonst warten bis Vimtex fertig initialisiert ist
    vim.api.nvim_create_autocmd("User", {
      pattern = "VimtexEventInitPost",
      callback = setup_cmp_vimtex,
      once = true,
    })

    -- Fallback: falls das Event aus irgendeinem Grund nicht feuert (selten)
    vim.defer_fn(function()
      pcall(setup_cmp_vimtex)
    end, 200)
  end,
}
