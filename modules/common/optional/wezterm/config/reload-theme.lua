local wezterm = require("wezterm")

local is_darwin = function()
  return wezterm.target_triple:find("darwin") ~= nil
end

local get_dark_mode = function()
  if is_darwin() then
    local script = "osascript -e 'tell application \"System Events\" to tell appearance preferences to return dark mode'"
    local handle = io.popen(script)
    if not handle then
      return nil, "Failed to execute command"
    end
    local result = handle:read("*a")
    handle:close()
    return result == "true\n"
  end
end

local get_theme_name = function()
  if get_dark_mode() then
    return "Everforest Dark"
  else
    return "Everforest Light"
  end
end

local iter = function()
  current_theme = (current_theme % #themes) + 1
  window:set_config_overrides({
    color_scheme = get_theme_name(),
  })
  wezterm.time.call_after(5.0, function()
    iter()
  end)
end
wezterm.on('window-config-reloaded', function(window, _)
  iter()
end)

return get_theme_name()
