require("lsp.tsserver")
require("lsp.lua_ls")
require("lsp.nixd")
require("lsp.null_ls")
require("lsp.cssls")
require("lsp.golang")
require("lsp.zls")
require("lsp.gleam")
require("lsp.astro")
require("lsp.clangd")

-- require("lsp.rust-analyzer")

-- local autocmd = vim.api.nvim_create_autocmd
-- local augroup = vim.api.nvim_create_augroup

-- DON'T LIKE THIS BEHVAIOUR ANYMORE
-- -- set up code lens
-- autocmd("LspAttach", {
-- 	desc = "LSP",
-- 	group = augroup("lsp", { clear = false }),
-- 	callback = function(ev)
-- 		local client = vim.lsp.get_client_by_id(ev.data.client_id)
-- 		local lsp = vim.lsp
--
-- 		if client and client.supports_method("textDocument/codeLens") then
-- 			autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
-- 				buffer = ev.buf,
-- 				group = augroup("codelens", { clear = false }),
-- 				callback = function()
-- 					lsp.codelens.refresh()
-- 				end,
-- 			})
-- 		end
-- 	end,
-- })
