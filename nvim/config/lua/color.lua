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
vim.cmd([[
  command! -nargs=1 Theme :call system('theme ' . <q-args>)
]])

local fwatch = require("fwatch")
local alacrity_color_path = os.getenv("HOME") .. "/.config/alacritty/color.toml"

local function update_theme(dark)
  local theme = (dark and "everforest" or "everforest")
  local is_dark = (dark and "dark" or "light")

  vim.cmd("let g:everforest_background = 'medium'")
  vim.cmd("set background=" .. is_dark)
  vim.cmd("colorscheme " .. theme)
  return { theme, dark }
end

local function run_theme_calculation()
  local f = io.open(alacrity_color_path)

  -- If the file does not exist, we set theme to dark
  if f == nil then
    update_theme(true)
  end

  local first_line = f:lines()()
  if first_line == "# DARK" then
    update_theme(true)
  else
    update_theme(false)
  end
  f:close()
end

run_theme_calculation()

fwatch.watch(alacrity_color_path, {
  on_event = function()
    vim.defer_fn(function()
      run_theme_calculation()
    end, 100)
  end,
})
