require("lsp.tsserver")
require("lsp.lua_ls")
require("lsp.nixd")
require("lsp.null_ls")
require("lsp.rust-analyzer")

-- vim.lsp.buf.format({
-- 	filter = function(client)
-- 		return client.name ~= "tsserver"
-- 	end,
-- })
