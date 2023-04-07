return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.1",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("telescope").setup({
			pickers = {
				find_files = {
					theme = "ivy",
				},
				live_grep = {
					theme = "ivy",
				},
				buffers = {
					theme = "dropdown",
				},
				help_tags = {
					theme = "ivy",
				},
				lsp_workspace_symbols = {
					theme = "ivy",
				},
				diagnostics = {
					theme = "ivy",
				},
			},
		})
	end,
}
