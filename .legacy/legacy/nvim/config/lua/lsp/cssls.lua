local lspconfig = require("lspconfig")
local fritiof = require("fritiof")

if fritiof.get("lsp.css.enabled", true) then
	lspconfig.cssls.setup({})
end
