local fritiof = require("fritiof")

if fritiof.get("ai.enabled") then
  local anthropic_path = os.getenv("HOME") .. "/.secrets/.anthropic"
  local f = io.open(anthropic_path, "r")
  if f == nil then
    vim.cmd [[
      echohl WarningMsg
      echo "Warning: Antrhopic path not found, codecompanion not instansiated!"
      echohl None
    ]]
    return
  end
  local anthropic_key = f:read("*a")
  f:close()
  anthropic_key = anthropic_key:gsub("%s+", "")
  if anthropic_key == "" then
    vim.cmd [[
      echohl WarningMsg
      echo "Warning: Antrhopic key is empty, codecompanion not instansiated!"
      echohl None
    ]]
    return
  end

  require("codecompanion").setup({
    adapters = {
      anthropic = function()
        return require("codecompanion.adapters").extend("anthropic", {
          env = {
            api_key = anthropic_key,
          },
        })
      end,
    },
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
      "CodeCompanion",
      desc = "Chat with AI"
    },
  })
end
