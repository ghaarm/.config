return {
  "hrsh7th/nvim-cmp",
  event = { "InsertEnter", "CmdlineEnter" },
  dependencies = {
    "hrsh7th/cmp-buffer", -- source for text in buffer
    "hrsh7th/cmp-path", -- source for file system paths
    "L3MON4D3/LuaSnip", -- snippet engine
    "saadparwaiz1/cmp_luasnip", -- for autocompletion
    -- "rafamadriz/friendly-snippets", -- useful snippets
    -- "onsails/lspkind.nvim", -- vs-code like pictograms
    "hrsh7th/cmp-cmdline",
    "petertriho/cmp-git",
    -- "f3fora/cmp-spell", -- auskommentieren, wenn spell vorschläge nicht im dropdown angezeigt werden tollen
    "micangl/cmp-vimtex",
    -- "aspeddro/cmp-pandoc.nvim",
  },
  config = function()
    local cmp = require("cmp")

    local luasnip = require("luasnip")

    local kind_icons = {
      article = "󰧮",
      book = "",
      incollection = "󱓷",
      Function = "󰊕",
      Constructor = "",
      Text = "󰦨",
      Method = "",
      Field = "󰅪",
      Variable = "󱃮",
      Class = "",
      Interface = "",
      Module = "",
      Property = "",
      Unit = "",
      Value = "󰚯",
      Enum = "",
      Keyword = "",
      Snippet = "",
      Color = "󰌁",
      -- Color = "",
      File = "",
      Reference = "",
      Folder = "",
      EnumMember = "",
      -- spell = "",
      -- EnumMember = "",
      Constant = "󰀫",
      Struct = "",
      -- Struct = "",
      Event = "",
      Operator = "󰘧",
      TypeParameter = "",
    }
    -- find more here: https://www.nerdfonts.com/cheat-sheet

    cmp.setup({
      -- completion = {
      --   completeopt = "menu,noselect",
      --   -- completeopt = "menuone,preview,noinsert,noselect",
      --   keyword_length = 1,
      -- },
      snippet = { -- configure how nvim-cmp interacts with snippet engine
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      -- mapping = cmp.mapping.preset.insert({
      --   ['<Tab>'] = cmp.mapping(function(fallback)
      --     if cmp.visible() then
      --       cmp.select_next_item()
      --     elseif luasnip.expandable() then
      --       luasnip.expand()
      --     elseif luasnip.jumpable() then
      --       luasnip.jump(1)
      --     else
      --       fallback()
      --     end
      --   end, { 'i', 's' }),
      --
      --   ['<S-Tab>'] = cmp.mapping(function(fallback)
      --     if cmp.visible() then
      --       cmp.select_prev_item()
      --     elseif luasnip.jumpable(-1) then
      --       luasnip.jump(-1)
      --     else
      --       fallback()
      --     end
      --   end, { 'i', 's' }),

      mapping = cmp.mapping.preset.insert({
        -- Tab springt nur zwischen Snippet-Platzhaltern
        ["<Tab>"] = cmp.mapping(function(fallback)
          if luasnip.jumpable(1) then
            luasnip.jump(1) -- Springe zum nächsten Platzhalter im Snippet
          else
            fallback() -- Führe Standard-Tab-Verhalten aus (Einrücken)
          end
        end, { "i", "s" }),

        -- Shift+Tab springt zum vorherigen Platzhalter im Snippet
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if luasnip.jumpable(-1) then
            luasnip.jump(-1) -- Springe zum vorherigen Platzhalter
          else
            fallback() -- Standard Shift+Tab-Verhalten
          end
        end, { "i", "s" }),
        ["<C-Space>"] = cmp.mapping.complete(), -- <── das hier ergänzen
        -- Control + K für den nächsten Eintrag in der Autocompletion
        ["<D-j>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item() -- Wähle den nächsten Autocomplete-Eintrag
          else
            fallback() -- Wenn kein Menü offen ist, mache nichts
          end
        end, { "i", "c" }),

        -- Control + J für den vorherigen Eintrag in der Autocompletion (optional)
        ["<D-k>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item() -- Wähle den vorherigen Autocomplete-Eintrag
          else
            fallback()
          end
        end, { "i", "c" }),
        -- NEU: Pfeiltasten für Menü-Navigation, sonst normales Cursorverhalten
        ["<Down>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          else
            fallback()
          end
        end, { "i", "c" }),
        ["<Up>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end, { "i", "c" }),

        ["<D-b>"] = cmp.mapping.scroll_docs(-4),

        ["<D-f>"] = cmp.mapping.scroll_docs(4),
        -- ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Bestätigt die Auswahl mit Enter
        -- https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#safely-select-entries-with-cr damit bei enter nicht etwas ausgewählt wird auch wenn nicht markiert ist
        ["<CR>"] = cmp.mapping({
          i = function(fallback)
            if cmp.visible() and cmp.get_active_entry() then
              cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
            else
              fallback()
            end
          end,
          s = cmp.mapping.confirm({ select = true }),
          c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
        }),
        -- ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        --
        -- ['<C-f>'] = cmp.mapping.scroll_docs(4),
      }),
      -- formatting for autocompletion
      formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
          vim_item.kind = string.format("%s", kind_icons[vim_item.kind]) -- Kind icons
          vim_item.menu = ({
            -- vimtex = (vim_item.menu ~= nil and vim_item.menu or "[VimTex]"),
            -- vimtex = test_fn(vim_item.menu, entry.source.name),
            vimtex = vim_item.menu,
            luasnip = "[Snippet]",
            nvim_lsp = "[LSP]",
            buffer = "[Buffer]",
            spell = "[Spell]",
            -- orgmode = "[Org]",
            -- latex_symbols = "[Symbols]",
            cmdline = "[CMD]",
            path = "[Path]",
          })[entry.source.name]
          return vim_item
        end,
      },
      -- sources for autocompletion
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" }, -- snippets
        { name = "vimtex" },
        -- { name = "orgmode" },
        -- { name = "pandoc" },
        -- { name = "omni" },
        { name = "buffer", keyword_length = 3 }, -- text within current buffer
        -- { -- auskommentieren, wenn spell vorschläge nicht im dropdown angezeigt werden tollen
        --   name = "spell",
        --   keyword_length = 4,
        --   option = {
        --     keep_all_entries = false,
        --     enable_in_context = function()
        --       return true
        --     end,
        --   },
        -- },
        { name = "path" },

        { name = "cmp_r" },
      }),
      confirm_opts = {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
      },
      view = {
        entries = "custom",
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
        -- completion = {
        --   border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
        -- },
        -- documentation = {
        --   border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
        -- },
      },
      performance = {
        trigger_debounce_time = 500,
        throttle = 550,
        fetching_timeout = 80,
      },
    })

    -- -- `/` cmdline setup für suche.
    -- cmp.setup.cmdline('/', {
    --   mapping = cmp.mapping.preset.cmdline(),
    --   sources = {
    --     { name = 'buffer' }
    --   }
    -- })
    --
    -- -- `:` cmdline setup für commandline.
    -- cmp.setup.cmdline(':', {
    --   mapping = cmp.mapping.preset.cmdline(),
    --   sources = {
    --     { name = 'path' },
    --     { name = 'cmdline' }
    --   }
    -- })

    -- -- `/` cmdline setup für suche.
    cmp.setup.cmdline("/", {
      mapping = cmp.mapping.preset.cmdline({
        ["<CR>"] = cmp.mapping(function(fallback)
          if cmp.visible() and cmp.get_active_entry() then
            cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
          else
            fallback()
          end
        end, { "c" }),
      }),
      sources = cmp.config.sources({
        { name = "buffer", keyword_length = 3 }, -- Nur Wörter mit mindestens 3 Zeichen vorschlagen
        -- { name = "spell" }, -- Optionale Rechtschreibprüfung  auskommentieren, wenn spell vorschläge nicht im dropdown angezeigt werden tollen
      }),
      completion = {
        completeopt = "menu,menuone,noselect", -- Verhindert automatische Auswahl
      },
    })

    -- -- `:` cmdline setup für commandline.
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline({
        ["<CR>"] = cmp.mapping(function(fallback)
          if cmp.visible() and cmp.get_active_entry() then
            cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
          else
            fallback()
          end
        end, { "c" }),
      }),
      sources = cmp.config.sources({
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
        { name = "cmdline" },
      }),
      completion = {
        completeopt = "menu,menuone,noselect", -- Verhindert automatische Auswahl
      },
    })
  end,
}
