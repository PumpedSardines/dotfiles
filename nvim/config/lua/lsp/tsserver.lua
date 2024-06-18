local lspconfig = require("lspconfig")

-- Work around for a bug where react/index.d.ts always apears in the go to definition
-- https://github.com/typescript-language-server/typescript-language-server/issues/216
local function filter(arr, fn)
	if type(arr) ~= "table" then
		return arr
	end

	local filtered = {}
	for k, v in pairs(arr) do
		if fn(v, k, arr) then
			table.insert(filtered, v)
		end
	end

	return filtered
end

local function filterReactDTS(value)
	-- Depends on the version of the typescript-language-server
	-- Can very between typescript versions
	if value.targetUri ~= nil then
		return string.match(value.targetUri, "react/index.d.ts") == nil
	end

	if value.uri ~= nil then
		return string.match(value.uri, "react/index.d.ts") == nil
	end

	return true
end

lspconfig.tsserver.setup({
	handlers = {
		["textDocument/definition"] = function(err, result, method, ...)
			if vim.tbl_islist(result) and #result > 1 then
				local filtered_result = filter(result, filterReactDTS)
				return vim.lsp.handlers["textDocument/definition"](err, filtered_result, method, ...)
			end

			vim.lsp.handlers["textDocument/definition"](err, result, method, ...)
		end,
	},
})
