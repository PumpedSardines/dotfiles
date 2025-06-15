vim.g.everforest_diagnostic_virtual_text = "colored"
vim.g.everforest_background = "soft"

vim.cmd([[
  if has('termguicolors')
    set termguicolors
  endif
]])

vim.api.nvim_set_hl(0, 'DiagnosticUnderlineError', {
  undercurl = true,
  sp = '#FFA500', -- change to your desired color
})
