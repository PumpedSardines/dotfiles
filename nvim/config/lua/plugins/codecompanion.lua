local fritiof = require("fritiof")

if fritiof.get("ai.enabled") then
  require("codecompanion").setup({
    strategies = {
      chat = {
        adapter = "anthropic",
      },
      inline = {
        adapter = "anthropic",
      },
    },
  })
end
