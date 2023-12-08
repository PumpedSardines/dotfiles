return function()
  local lspconfig = require("lspconfig")

  lspconfig.tsserver.setup({
    root_dir = lspconfig.util.root_pattern("package.json"),
  })
end
