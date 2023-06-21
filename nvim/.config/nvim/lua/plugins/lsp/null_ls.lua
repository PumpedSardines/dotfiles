return {
  "jose-elias-alvarez/null-ls.nvim",
  config = function()
    local b = require("null-ls").builtins

    require("null-ls").setup({
      on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format()
            end,
          })
        end
      end,
      sources = {
        b.diagnostics.cspell.with({
          diagnostics_postprocess = function(diagnostic)
            diagnostic.severity = vim.diagnostic.severity.INFO
          end,
          diagnostic_config = {
            underline = true,
            virtual_text = false,
            signs = true,
            update_in_insert = false,
            severity_sort = true,
          },
        }),
        b.code_actions.cspell.with({
          config = {
            create_config_file = true,
            create_config_file_name = ".cspell.json",
          },
        }),
        b.formatting.alejandra,
        b.formatting.black,
        b.formatting.stylua,
        b.formatting.prettier_d_slim,
        b.code_actions.eslint_d,
        b.diagnostics.eslint_d.with({
          filter = function(diagnostic)
            local possible_useless = {
              diagnostic.code == "prettier/prettier",
              not not diagnostic.message:find("Error: No ESLint configuration found"),
            }

            return not vim.tbl_contains(possible_useless, true)
          end,
        }),
        b.formatting.eslint_d,
        b.formatting.rustfmt,
      },
    })
  end,
}
