local fritiof = require("fritiof")

if fritiof.get("ai.enabled") then
  require("avante_lib").load()

  vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
      require("avante").setup({
        provider = "claude",
        claude = {
          model = "claude-sonnet-4-20250514",
        },
      })
    end,
  })
end
