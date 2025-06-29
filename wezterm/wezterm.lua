local wezterm = require("wezterm")

local config = {}
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- https://github.com/Gogh-Co/Gogh
config.color_schemes = {
  ["NeoVim Default Light"] = {
    background = "#E0E2EA",
    foreground = "#2c2e33",

    cursor_bg = "#2c2e33",
    cursor_fg = "#E0E2EA",

    ansi = {
      "#4f5258",
      "#590008",
      "#005523",
      "#DBBC7F",
      "#004c63",
      "#470045",
      "#007373",
      "#EEF1F8",
    },
    brights = {
      "#4f5258",
      "#590008",
      "#005523",
      "#DBBC7F",
      "#004c63",
      "#470045",
      "#007373",
      "#EEF1F8",
    },
  },
  ["NeoVim Default Dark"] = {
    background = "#14161B",
    foreground = "#E0E2EA",

    cursor_bg = "#E0E2EA",
    cursor_fg = "#14161B",

    ansi = {
      "#9b9ea4",
      "#FFC0B9",
      "#b4f6c0",
      "#FCE094",
      "#A6DBFF",
      "#FFCAFF",
      "#8cf8f7",
      "#EEF1F8",
    },
    brights = {
      "#9b9ea4",
      "#FFC0B9",
      "#b4f6c0",
      "#FCE094",
      "#A6DBFF",
      "#FFCAFF",
      "#8cf8f7",
      "#EEF1F8",
    },
  },
  ["Everforest Dark"] = {
    background = "#2D353B",
    foreground = "#D3C6AA",

    cursor_bg = "#D3C6AA",
    cursor_fg = "#2D353B",

    ansi = {
      "#343F44",
      "#E67E80",
      "#A7C080",
      "#DBBC7F",
      "#7FBBB3",
      "#D699B6",
      "#83C092",
      "#D3C6AA",
    },
    brights = {
      "#5C6A72",
      "#F85552",
      "#8DA101",
      "#DFA000",
      "#3A94C5",
      "#DF69BA",
      "#35A77C",
      "#DFDDC8",
    },
  },
  ["Everforest Light"] = {
    background = "#FDF6E3",
    foreground = "#5C6A72",

    cursor_fg = "#FDF6E3",
    cursor_bg = "#5C6A72",

    ansi = {
      "#5C6A72",
      "#F85552",
      "#8DA101",
      "#DFA000",
      "#3A94C5",
      "#DF69BA",
      "#35A77C",
      "#DFDDC8",
    },
    brights = {

      "#343F44",
      "#E67E80",
      "#A7C080",
      "#DBBC7F",
      "#7FBBB3",
      "#D699B6",
      "#83C092",
      "#D3C6AA",
    },
  },
}
config.hide_tab_bar_if_only_one_tab = true
config.automatically_reload_config = true
config.window_close_confirmation = "NeverPrompt"

config.font = wezterm.font("CaskaydiaCove Nerd Font")

config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

local theme = require("theme") or "Everforest Dark"
config.color_scheme = theme

return config
