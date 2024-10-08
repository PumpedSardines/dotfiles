vim.cmd([[
augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=100}
augroup END

augroup ejs_ft
  au!
  autocmd BufNewFile,BufRead *.ejs   set syntax=ejs
augroup END
]])
