local lspconfig = require("lspconfig")
local local_settings = vim.g.fritiof and vim.g.fritiof.lsp and vim.g.fritiof.lsp.css or {}
local enabled = true

if local_settings.enabled ~= nil then
	enabled = local_settings.enabled
end

if enabled then
	lspconfig.cssls.setup({})
end
