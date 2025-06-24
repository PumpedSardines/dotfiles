local M = {}

local is_mac = function ()
  return vim.loop.os_uname().sysname == 'Darwin'
end

M.get_dark_mode = function ()
  if is_mac() then
    local script = "osascript -e 'tell application \"System Events\" to tell appearance preferences to return dark mode'"
    local handle = io.popen(script)
    if not handle then
      return nil, "Failed to execute command"
    end
    local result = handle:read("*a")
    handle:close()
    return result
  end
end

return M
