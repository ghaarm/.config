-- https://github.com/ptdewey/knitr-nvim
return {
  "ptdewey/knitr-nvim",

  -- ensure plenary is installed
  dependencies = {
    "nvim-lua/plenary.nvim",
  },

  -- run plugin setup
  config = function()
    require("knitr").setup()
  end,
}

--Usage

-- This plugin provides two different commands for knitting R files:

-- knitting to PDF - :KnitRpdf

-- Knitting to HTML - :KniRhtml
-- Running either command will knit the file in the current buffer to the desired output format.Usage
