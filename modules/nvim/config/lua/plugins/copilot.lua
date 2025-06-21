vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true

vim.cmd([[
  imap <silent><script><expr> <C-F> copilot#Accept("\<CR>")
]])
