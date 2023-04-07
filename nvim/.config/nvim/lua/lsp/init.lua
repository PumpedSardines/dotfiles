require("mason-lspconfig").setup_handlers({
	function(server)
		local lspconfig = require("lspconfig")
		lspconfig[server].setup({})
	end,
	["tsserver"] = require("lsp.handlers.tsserver"),
	["denols"] = require("lsp.handlers.denols"),
})
