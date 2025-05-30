local fritiof = require("fritiof")

if fritiof.get("ai.enabled") then
	require("avante_lib").load()

	vim.api.nvim_create_autocmd("VimEnter", {
		callback = function()
			require("avante").setup({
        provider = "claude",
        openai = {
          model = "claude-sonnet-4-20250514",
          timeout = 30000,
          temperature = 0,
          max_completion_tokens = 8192,
        },
      })
		end,
	})
end
