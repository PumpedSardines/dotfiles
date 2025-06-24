local M = {}

local callbacks = {}

local is_darwin = function ()
  return vim.loop.os_uname().sysname == 'Darwin'
end

local get_dark_mode = function ()
  local default_dark_mode = true

  if is_darwin() then
    local dark_theme_file = os.getenv("HOME") .. "/.config/dark_theme"
    local f = io.open(dark_theme_file, "r")
    if f == nil then
      return default_dark_mode
    end
    local content = f:read("*a")
    f:close()
    return content == "1"
  end

  return default_dark_mode
end

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
  if is_darwin() then
    local fwatch = require("fwatch")
    -- Using the darwin dark-theme program that is made by me :)
    local dark_theme_file = os.getenv("HOME") .. "/.config/dark_theme"
    local f = io.open(dark_theme_file)
    if f == nil then
      -- Dark theme module is not installed
      -- Don't refresh automatically
      return
    end

    fwatch.watch(dark_theme_file, {
      on_event = function()
        vim.defer_fn(function()
          M.refresh()
        end, 100)
      end,
    })
  end
end

M.setup = function ()
  L.refresh_loop()
end

M.register(function (dark_mode)
  local theme = (dark_mode and "everforest" or "everforest")
  local is_dark = (dark_mode and "dark" or "light")

  vim.cmd("let g:everforest_background = 'medium'")
  vim.cmd("set background=" .. is_dark)
  vim.cmd("colorscheme " .. theme)
end)
M.setup()
