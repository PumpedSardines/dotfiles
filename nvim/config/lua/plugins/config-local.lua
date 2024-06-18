local config_local = require("config-local")

config_local.setup({
	config_files = { ".fritiof.lua" },

	autocommands_create = false,
	commands_create = true,
	silent = false,
	lookup_parents = true,
})

config_local.source()
