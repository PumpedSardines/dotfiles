local fritiof = require("fritiof")
require("avante_lib").load()

local system_prompt = [[
Defintions:
- test defs: Test definitions without an implementation. example: test.skip(\"Hello World\")

Implementations:
- jest:
  - test defs: write multiple test definitions after each other, always leave out the anonymous function
    - note: for class files, don't create a class name describe block. I.e don't do:
      describe(\"MyClass\", () => {
        describe(\"method\", () => {
          test.skip(\"test\");
        });
      });
    - Example:
      describe(\"feature1\", () => {
        test.skip(\"test1\");
        test.skip(\"test2\");
      });
]]

if fritiof.get("ai.enabled") then
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

  vim.api.nvim_create_autocmd("User", {
    pattern = "ToggleMyPrompt",
    callback = function()
      require("avante.config").override({ system_prompt = system_prompt })
    end,
  })

  vim.keymap.set("n", "<leader>am", function()
    vim.api.nvim_exec_autocmds("User", { pattern = "ToggleMyPrompt" })
  end, { desc = "avante: toggle my prompt" })
end
