vim.cmd([[
  command! -nargs=1 Theme :call system('theme ' . <q-args>)
]])
require("plugins")

require("options")
require("color")
require("keymaps")

require("lsp")
require("tweaks")

require("neo-tree")
