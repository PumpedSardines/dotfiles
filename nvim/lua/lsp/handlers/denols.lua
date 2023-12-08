return function()
  local lspconfig = require("lspconfig")

  lspconfig.denols.setup({
    root_dir = lspconfig.util.root_pattern("deno.json"),
  })
end
