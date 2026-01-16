-- https://github.com/hiphish/rainbow-delimiters.nvim
return {
  "HiPhish/rainbow-delimiters.nvim",
  event = "BufReadPost",
  config = function()
    local rainbow_delimiters = require 'rainbow-delimiters'

    vim.g.rainbow_delimiters = {
      strategy = {
        [''] = rainbow_delimiters.strategy['global'],
        vim = rainbow_delimiters.strategy['local'],
      },
      query = {
        [''] = 'rainbow-delimiters',
        lua = 'rainbow-blocks',
      },
      priority = {
        [''] = 110,
        lua = 210,
      },
      highlight = {
        'RainbowDelimiterRed',
        'RainbowDelimiterYellow',
        -- 'RainbowDelimiterBlue',
        'RainbowDelimiterTeal',
        'RainbowDelimiterOrange',
        'RainbowDelimiterGreen',
        'RainbowDelimiterViolet',
        'RainbowDelimiterCyan',
      },
    }
    -- Optional: Farbdefinitionen hinzufügen
    -- vim.cmd [[
    --         highlight RainbowDelimiterRed guifg=#FF0000
    --         highlight RainbowDelimiterYellow guifg=#FFFF00
    --         highlight RainbowDelimiterBlue guifg=#0000FF
    --         highlight RainbowDelimiterOrange guifg=#FFA500
    --         highlight RainbowDelimiterGreen guifg=#00FF00
    --         highlight RainbowDelimiterViolet guifg=#EE82EE
    --         highlight RainbowDelimiterCyan guifg=#00FFFF
    --     ]]
  end,
}
