return {
	"sainnhe/everforest",
	config = function()
		vim.g.everforest_diagnostic_virtual_text = "colored"
		vim.g.everforest_background = "soft"

		vim.cmd([[
    if has('termguicolors')
      set termguicolors
    endif
    ]])
	end,
}
