local lspconfig = require("lspconfig")

lspconfig.hls.setup({
  filetypes = { "haskell", "lhaskell" },
  cmd = { "stack", "exec", "--", "haskell-language-server-wrapper", "--lsp" },
  root_dir = lspconfig.util.root_pattern("stack.yaml", "package.yaml", "*.cabal"),
  settings = {
    haskell = {
      formattingProvider = "ormolu",
    },
  },
})
