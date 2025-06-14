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
    prompt_library = {
      ["todo unit test service"] = {
        strategy = "inline",
        description = "Todo Unit Tests",
        opts = {
          index = 11,
          is_slash_cmd = false,
          auto_submit = false,
          short_name = "docs",
        },
        -- references = {},
        prompts = {
          {
            role = "user",
            content =
              [[
                Take this entire service and write todo tests for it. I want there to be no implementation of any tests. 
                Look at what the code does and write tests that should be implemented.

                These should be unit tests, so remember that all dependencies should be mocked out. Think about this when writing,
                the tests. WRite tests scenarios where the dependency errors or similar.
              ]]
          },
        },
      },
    },
  })
end
