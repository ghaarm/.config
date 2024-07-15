return {
  "L3MON4D3/LuaSnip",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("luasnip.loaders.from_snipmate").load({ paths = "~/.config/nvim/snippets/" })

    vim.keymap.set(
      'n',
      '<Leader>es',
      function()
        require('luasnip.loaders').edit_snippet_files({
          extend = function(ft, paths)
            if #paths == 0 then
              return {
                {
                  '$CONFIG/' .. ft .. '.snippets',
                  string.format("%s/%s.snippets", '~/.config/nvim/snippets', ft),
                }
              }
            end

            return {}
          end
        })
      end,
      { desc = 'Edit snippet' }
    )
  end,
}

