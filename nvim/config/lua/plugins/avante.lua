local fritiof = require("fritiof")
require("avante_lib").load()

if fritiof.get("ai.enabled") then

  vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
      require("avante").setup({
        -- provider = "claude",
        -- claude = {
        --   model = "claude-sonnet-4-20250514",
        -- },
      })
    end,
  })
end
