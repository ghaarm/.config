-- local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
-- if not vim.loop.fs_stat(lazypath) then
--   vim.fn.system({
--     "git",
--     "clone",
--     "--filter=blob:none",
--     "https://github.com/folke/lazy.nvim.git",
--     "--branch=stable", -- latest stable release
--     lazypath,
--   })
-- end
-- vim.opt.rtp:prepend(lazypath)

-- require("lazy").setup({
--   {
--     import = "josean.plugins" },
--     { import = "josean.plugins.lsp" }
--   }, {
--   checker = {
--     enabled = true,
--     notify = false,
--   },
--   change_detection = {
--     notify = false,
--   },
--   rocks = {
--     enabled = false, -- Deaktiviere LuaRocks explizit
--   }
-- })

-- local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
-- if not vim.loop.fs_stat(lazypath) then
--   vim.fn.system({
--     "git",
--     "clone",
--     "--filter=blob:none",
--     "https://github.com/folke/lazy.nvim.git",
--     "--branch=stable", -- latest stable release
--     lazypath,
--   })
-- end
-- vim.opt.rtp:prepend(lazypath)

-- require("lazy").setup({
--   {
--     import = "josean.plugins"
--   },
--   {
--     import = "josean.plugins.lsp"
--   },
--   {
--     "L3MON4D3/LuaSnip",
--     event = { "BufReadPre", "BufNewFile" },
--     config = function()
--       require("luasnip.loaders.from_snipmate").load({ paths = "~/.config/nvim/snippets/" })
--     end
--   },
--   {
--     "lervag/vimtex",
--     ft = "tex",
--   },
--   {
--     checker = {
--       enabled = true,
--       notify = false,
--     },
--     change_detection = {
--       notify = false,
--     },
--     rocks = {
--       enabled = false, -- Deaktiviere LuaRocks explizit
--     }
--   }
-- })
-- Install plugins using lazy.nvim
-- local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
-- if not vim.loop.fs_stat(lazypath) then
--   vim.fn.system({
--     "git",
--     "clone",
--     "--filter=blob:none",
--     "https://github.com/folke/lazy.nvim.git",
--     "--branch=stable", -- latest stable release
--     lazypath,
--   })
-- end
-- vim.opt.rtp:prepend(lazypath)

-- require("lazy").setup({
--   {
--     import = "josean.plugins"
--   },
--   {
--     import = "josean.plugins.lsp"
--   },
--   {
--     "L3MON4D3/LuaSnip",
--     event = { "BufReadPre", "BufNewFile" },
--     config = function()
--       require("luasnip.loaders.from_snipmate").load({ paths = "~/.config/nvim/snippets/" })
--     end
--   },
--   {
--     "lervag/vimtex",
--     ft = "tex",
--   },
--   {
--     "hrsh7th/nvim-cmp",
--     config = function()
--       local cmp = require'cmp'
--       local luasnip = require'luasnip'

--       cmp.setup({
--         snippet = {
--           expand = function(args)
--             require('luasnip').lsp_expand(args.body)
--           end,
--         },
--         mapping = {
--           ['<Tab>'] = cmp.mapping(function(fallback)
--             if cmp.visible() then
--               cmp.select_next_item()
--             elseif luasnip.expand_or_jumpable() then
--               luasnip.expand_or_jump()
--             else
--               fallback()
--             end
--           end, { 'i', 's' }),
--           ['<S-Tab>'] = cmp.mapping(function(fallback)
--             if cmp.visible() then
--               cmp.select_prev_item()
--             elseif luasnip.jumpable(-1) then
--               luasnip.jump(-1)
--             else
--               fallback()
--             end
--           end, { 'i', 's' }),
--           ['<CR>'] = cmp.mapping.confirm({ select = true }),
--         },
--         sources = cmp.config.sources({
--           { name = 'nvim_lsp' },
--           { name = 'luasnip' },
--         }, {
--           { name = 'buffer' },
--         })
--       })
--     end
--   }
-- })

-- Optional: Laden der Layout-Konfiguration
-- vim.opt.wrap = true
-- vim.opt.linebreak = true
-- vim.opt.showbreak = "↪"
-- vim.opt.breakindent = true

-- Install plugins using lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    import = "josean.plugins",
  },
  {
    import = "josean.plugins.lsp",
  },
  {
    "L3MON4D3/LuaSnip",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("luasnip.loaders.from_snipmate").load({ paths = "~/.config/nvim/snippets/" })
    end,
  },
  {
    "lervag/vimtex",
    ft = "tex",
  },
  {
    "hrsh7th/nvim-cmp",
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = {
          -- ['<Tab>'] = cmp.mapping(function(fallback)
          --   if cmp.visible() then
          --     cmp.select_next_item()
          --   elseif luasnip.expand_or_jumpable() then
          --     luasnip.expand_or_jump()
          --   elseif has_words_before() then
          --     cmp.complete()
          --   else
          --     fallback()
          --   end
          -- end, { 'i', 's' }),
          -- ['<S-Tab>'] = cmp.mapping(function(fallback)
          --   if cmp.visible() then
          --     cmp.select_prev_item()
          --   elseif luasnip.jumpable(-1) then
          --     luasnip.jump(-1)
          --   else
          --     fallback()
          --   end
          -- end, { 'i', 's' }),
        },
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "cmp_r" },
          { name = "path" }, -- file system paths
        }),
      })

      -- Autocompletion for snippets using <Tab>
      -- vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", { expr = true })
      -- vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", { expr = true })
      -- vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", { expr = true })
      -- vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", { expr = true })
      --
      -- _G.tab_complete = function()
      --   if cmp.visible() then
      --     cmp.select_next_item()
      --   elseif luasnip.expand_or_jumpable() then
      --     luasnip.expand_or_jump()
      --   elseif has_words_before() then
      --     cmp.complete()
      --   else
      --     return "<Tab>"
      --   end
      --   return ""
      -- end
      --
      -- _G.s_tab_complete = function()
      --   if cmp.visible() then
      --     cmp.select_prev_item()
      --   elseif luasnip.jumpable(-1) then
      --     luasnip.jump(-1)
      --   else
      --     return "<S-Tab>"
      --   end
      --   return ""
      -- end
    end,
  },
})

-- Optional: Laden der Layout-Konfiguration
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.showbreak = "↪"
vim.opt.breakindent = true
-- Optional: Setzen Sie `breakindentopt` für weitere Anpassungen
-- vim.opt.breakindentopt = "shift:2,min:20"
