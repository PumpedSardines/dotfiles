local M = {}

local settings = {
	["lsp.css.enabled"] = { type = "boolean", default = true },
	["ai.enabled"] = { type = "boolean", default = true },
}

local settings_values = {}

for key, value in pairs(settings) do
	settings_values[key] = value.default
end

local function validate_input(value, setting)
	local t = type(value)

	if t ~= setting.type then
		return false
	end

	return true
end

-- Set a setting
-- @param key string
-- @param value any
-- @return void
M.set = function(key, value)
	if settings[key] == nil then
		vim.print("Unknown setting: " .. key)
		return
	end

	if not validate_input(value, settings[key]) then
		vim.print("Invalid type for setting: " .. key)
		return
	end

	settings_values[key] = value
end

-- Get a setting
-- @param key string
-- @return any
M.get = function(key)
	if settings[key] == nil then
		vim.print("Attempted to get unknown setting: " .. key)
		return
	end

	return settings_values[key]
end

return M
