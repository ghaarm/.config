-- https://www.josean.com/posts/how-to-setup-wezterm-terminal
-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()


-- Deaktiviert alle vordefinierten Tastenkombinationen
config.disable_default_key_bindings = true

-- This is where you actually apply your config choices
-- config.color_scheme = 'Kanagawa Dragon (Gogh)'
-- my coolnight colorscheme
-- config.colors = {
--   foreground = "#CBE0F0",
--   background = "#011423",
--   cursor_bg = "#47FF9C",
--   cursor_border = "#47FF9C",
--   cursor_fg = "#011423",
--   selection_bg = "#033259",
--   selection_fg = "#CBE0F0",
--   ansi = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#0FC5ED", "#a277ff", "#24EAF7", "#24EAF7" },
--   brights = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#A277FF", "#a277ff", "#24EAF7", "#24EAF7" },
-- }

config.colors = {
  -- Allgemeine Farben
  foreground = "#C5C9C5",
  background = "#181616",
  cursor_bg = "#C8C093",
  cursor_border = "#C8C093",
  cursor_fg = "#C5C9C5",
  selection_bg = "#C8C093",
  selection_fg = "#181616",

  -- Standard ANSI-Farben
  ansi = {
    "#0D0C0C", -- Schwarz
    "#C4746E", -- Rot
    "#8A9A7B", -- Grün
    "#C4B28A", -- Gelb
    "#8BA4B0", -- Blau
    "#A292A3", -- Magenta
    "#8EA4A2", -- Cyan
    "#C8C093", -- Weiß
  },

  -- Helle ANSI-Farben
  brights = {
    "#A6A69C", -- Helles Schwarz
    "#E46876", -- Helles Rot
    "#87A987", -- Helles Grün
    "#E6C384", -- Helles Gelb
    "#7FB4CA", -- Helles Blau
    "#938AA9", -- Helles Magenta
    "#7AA89F", -- Helles Cyan
    "#C5C9C5", -- Helles Weiß
  },
}

config.font = wezterm.font("SauceCodePro Nerd Font Propo")
config.font_size = 14

config.enable_tab_bar = false

config.window_decorations = "RESIZE"
config.window_background_opacity = 0.6
config.macos_window_background_blur = 10

-- and finally, return the configuration to wezterm
return config
