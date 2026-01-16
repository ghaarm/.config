-- return {
--   "stevearc/conform.nvim",
--   event = { "BufReadPre", "BufNewFile" },
--   config = function()
--     local conform = require("conform")
--
--     conform.setup({
--       formatters_by_ft = {
--         javascript = { "prettier" },
--         typescript = { "prettier" },
--         javascriptreact = { "prettier" },
--         typescriptreact = { "prettier" },
--         svelte = { "prettier" },
--         css = { "prettier" },
--         html = { "prettier" },
--         json = { "prettier" },
--         yaml = { "prettier" },
--         markdown = { "prettier" },
--         graphql = { "prettier" },
--         liquid = { "prettier" },
--         lua = { "stylua" },
--         python = { "isort", "black" },
--       },
--       format_on_save = {
--         lsp_fallback = true,
--         async = false,
--         timeout_ms = 1000,
--       },
--     })
--
--     vim.keymap.set({ "n", "v" }, "<leader>mp", function()
--       conform.format({
--         lsp_fallback = true,
--         async = false,
--         timeout_ms = 1000,
--       })
--     end, { desc = "Format file or range (in visual mode)" })
--   end,
-- }
--
return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")

    -- einmal definieren, dann für setup UND format_on_save verwenden
    local formatters_by_ft = {
      javascript      = { "prettier" },
      typescript      = { "prettier" },
      javascriptreact = { "prettier" },
      typescriptreact = { "prettier" },
      svelte          = { "prettier" },
      css             = { "prettier" },
      html            = { "prettier" },
      json            = { "prettier" },
      yaml            = { "prettier" },
      markdown        = { "prettier" },
      graphql         = { "prettier" },
      liquid          = { "prettier" },
      lua             = { "stylua" },
      python          = { "isort", "black" },
    }

    conform.setup({
      formatters_by_ft = formatters_by_ft,

      -- Nur für Filetypes auto-formatieren, die oben eingetragen sind.
      -- R hat hier keinen Eintrag -> kein Format-on-save für R.
      format_on_save = function(bufnr)
        local ft = vim.bo[bufnr].filetype

        -- Nur auto-format, wenn wir explizit Formatter dafür definiert haben
        if formatters_by_ft[ft] == nil then
          return
        end

        return {
          lsp_fallback = true,
          async = false,
          timeout_ms = 1000,
        }
      end,
    })

    -- Manuelles Format (bleibt erhalten)
    vim.keymap.set({ "n", "v" }, "<leader>mp", function()
      conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      })
    end, { desc = "Format file or range (in visual mode)" })
  end,
}
