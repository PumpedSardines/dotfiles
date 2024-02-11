local fwatch = require("fwatch")
local alacrity_color_path = os.getenv("HOME") .. "/.config/alacritty/color.toml"

local function update_theme(dark)
	local theme = (dark and "everforest" or "everforest")
	local is_dark = (dark and "dark" or "light")

	vim.cmd("let g:everforest_background = 'medium'")
	vim.cmd("colorscheme " .. theme)
	vim.cmd("set background=" .. is_dark)
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
