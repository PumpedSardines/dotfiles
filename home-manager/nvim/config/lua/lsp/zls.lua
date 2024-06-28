local lspconfig = require("lspconfig")

-- https://github.com/zigtools/zls/issues/856
-- The default zig support in vim has some real annoyances, these settings disables them
vim.g.zig_fmt_parse_errors = 0
vim.g.zig_fmt_autosave = 0

lspconfig.zls.setup({})
