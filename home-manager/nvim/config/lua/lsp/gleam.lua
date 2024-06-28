require("lspconfig").gleam.setup({})

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.gleam",
	callback = function()
		vim.lsp.buf.format()
	end,
})
