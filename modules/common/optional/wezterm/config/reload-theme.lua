local wezterm = require("wezterm")

local is_darwin = function()
  return wezterm.target_triple:find("darwin") ~= nil
end

local get_dark_mode = function ()
  local default_dark_mode = true

  if is_darwin() then
    local dark_theme_file = os.getenv("HOME") .. "/.config/dark-theme"
    local f = io.open(dark_theme_file, "r")
    if f == nil then
      return default_dark_mode
    end
    local content = f:read("*a")
    f:close()
    return content == "1\n"
  end

  return default_dark_mode
end

local get_theme_name = function()
  if get_dark_mode() then
    return "Everforest Dark"
  else
    return "Everforest Light"
  end
end

local iter = function()
  window:set_config_overrides({
    color_scheme = get_theme_name(),
  })
  wezterm.time.call_after(1.0, function()
    iter()
  end)
end

iter()

return get_theme_name()
