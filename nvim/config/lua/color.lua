local fwatch = require("fwatch")
local alacrity_color_path = os.getenv("HOME") .. "/.config/alacritty/color.toml"

local function read_file(path)
  local file = io.open(path, "rb") -- r read mode and b binary mode
  if not file then
    return nil
  end
  local content = file:read("*a") -- *a or *all reads the whole file
  file:close()
  return content
end
local function update_theme(dark)
  local theme = (dark and "everforest" or "everforest")
  local dark = (dark and "dark" or "light")
  vim.cmd("let g:everforest_background = 'medium'")
  vim.cmd("colorscheme " .. theme)
  vim.cmd("set background=" .. dark)
  return { theme, dark }
end

function run_theme_calculation()
  local f = io.open(alacrity_color_path)
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
