--[[

This file is used to dynamically update the color theme.

How it works:
  Alacritty and Wezterm have auto rleoad enabled.
  Both config files depend on a file that lives outside of nix and home-manager.
  When running the "theme" command from the terminal, the alacritty and wezterm config files will be updated
  In nvim we watch one of theses files (in this case, alacritty), and dedouce the theme from that file
  This way, we can change the theme in the terminal and nvim will follow

--]]

-- Helper so we easily can change the theme from nvim
local t = require("theme")
t.register(function(dark)
  local theme = (dark and "everforest" or "everforest")
  local is_dark = (dark and "dark" or "light")

  vim.cmd("let g:everforest_background = 'medium'")
  vim.cmd("set background=" .. is_dark)
  vim.cmd("colorscheme " .. theme)
end)
t.setup()
