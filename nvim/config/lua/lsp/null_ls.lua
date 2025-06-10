local b = require("null-ls").builtins
local cspell = require("cspell")

require("null-ls").setup({
	sources = {
		cspell.diagnostics.with({
			diagnostics_postprocess = function(diagnostic)
				diagnostic.severity = vim.diagnostic.severity.INFO
			end,
			diagnostic_config = {
				underline = true,
				virtual_text = false,
				signs = true,
				update_in_insert = false,
				severity_sort = true,
			},
		}),
		cspell.code_actions.with({
			config = {
				create_config_file = true,
				config_file_preferred_name = ".cspell.json",
			},
		}),
		-- b.formatting.phpcsfixer,
		b.formatting.zigfmt,
		b.formatting.alejandra,
		b.formatting.black,
		b.formatting.stylua,
		b.formatting.prettier.with({
			command = "prettierd",
		}),
		-- b.code_actions.eslint_d,
		-- b.diagnostics.eslint_d.with({
		-- 	filter = function(diagnostic)
		-- 		local possible_useless = {
		-- 			diagnostic.code == "prettier/prettier",
		-- 			not not diagnostic.message:find("Error: No ESLint configuration found"),
		-- 		}

		-- 		return not vim.tbl_contains(possible_useless, true)
		-- 	end,
		-- }),
		-- b.formatting.eslint_d,
		b.formatting.rustfmt,
	},
})
