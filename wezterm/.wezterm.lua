-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.hide_tab_bar_if_only_one_tab = true
config.font = wezterm.font_with_fallback({
  {
    family = "JetBrains Mono",
    weight = "Medium",
    harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
  },
  { family = "Terminus", weight = "Bold" },
  "Noto Color Emoji",
})
-- config.enable_tab_bar = false

-- and finally, return the configuration to wezterm
return config
