vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
-- disable

local fritiof = require("fritiof")
vim.g.copilot_enabled = fritiof.get("ai.enabled")

vim.cmd([[
  imap <silent><script><expr> <C-F> copilot#Accept("\<CR>")
]])
