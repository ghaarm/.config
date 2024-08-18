-- return {
--   "L3MON4D3/LuaSnip",
--   event = { "BufReadPre", "BufNewFile" },
--   config = function()
--     require("luasnip.loaders.from_snipmate").load({ paths = "~/.config/nvim/snippets/" })
--
--     -- https://github.com/L3MON4D3/LuaSnip/issues/988 für leader es um
--     vim.keymap.set(
--       'n',
--       '<Leader>es',
--       function()
--         require('luasnip.loaders').edit_snippet_files({
--           extend = function(ft, paths)
--             if #paths == 0 then
--               return {
--                 {
--                   '$CONFIG/' .. ft .. '.snippets',
--                   string.format("%s/%s.snippets", '~/.config/nvim/snippets', ft),
--                 }
--               }
--             end
--
--             return {}
--           end
--         })
--       end,
--       { desc = 'Edit snippet' }
--     )
--   end,
-- }
--
return {
  "L3MON4D3/LuaSnip",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("luasnip.loaders.from_snipmate").load({ paths = vim.fn.expand("~/.config/nvim/snippets/") })

    vim.keymap.set(
      'n',
      '<Leader>es',
      function()
        local scan = require('plenary.scandir')

        -- Expand the home directory
        local snippet_dir = vim.fn.expand("~/.config/nvim/snippets")

        -- Scan the snippets directory for files
        local snippet_files = scan.scan_dir(snippet_dir, { depth = 1, add_dirs = false })

        -- Get just the filenames
        local choices = {}
        for _, file in ipairs(snippet_files) do
          table.insert(choices, vim.fn.fnamemodify(file, ":t"))
        end

        -- Display choices in a selection window
        vim.ui.select(choices, { prompt = 'Select a snippet file to edit:' }, function(choice)
          if choice then
            -- Find the full path of the selected file
            local full_path = snippet_dir .. '/' .. choice
            vim.cmd('edit ' .. full_path)
          else
            print("Keine Datei ausgewählt.")
          end
        end)
      end,
      { desc = 'Edit snippet' }
    )
  end,
}
