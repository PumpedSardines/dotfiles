local M = {}

local callbacks = {}

local is_mac = function ()
  return vim.loop.os_uname().sysname == 'Darwin'
end

local get_dark_mode = function ()
  if is_mac() then
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

-- For debugging right now
M.get_dark_mode = get_dark_mode

M.register = function (cb)
  if type(cb) ~= 'function' then
    error("Callback must be a function")
  end
  table.insert(callbacks, cb)
  cb(get_dark_mode())
end

M.refresh = function ()
  local dark_mode, err = get_dark_mode()
  if err then
    print("Error getting dark mode: " .. err)
    return
  end

  for _, cb in ipairs(callbacks) do
    cb(dark_mode)
  end
end

local L = {}
L.refresh_loop = function ()
  vim.defer_fn(function ()
    M.refresh()
    L.refresh_loop()
  end, 5000)
end

M.setup = function ()
  L.refresh_loop()
end

return M
