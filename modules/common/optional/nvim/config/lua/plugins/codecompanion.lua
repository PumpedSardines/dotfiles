local fritiof = require("fritiof")

if fritiof.get("ai.enabled") then
  require("codecompanion").setup({
    strategies = {
      chat = {
        adapter = "anthropic",
      },

      inline = {
        adapter = {
          name = "anthropic",
          model = 'claude-3.5-sonnet',
        },
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

  local wk = require("which-key")
  wk.add({
    mode = "v",
    { "<leader>a", group = 'AI' },
    {
      "<leader>ak",
      function()
        vim.ui.input({ prompt = "Prompt: ", kind = "ai_inline" }, function(input)
          if input == nil or input == "" then
            return
          end

          vim.cmd("'<,'>CodeCompanion " .. input)
        end)
      end,
      desc = "Chat with AI"
    },
  })
end
