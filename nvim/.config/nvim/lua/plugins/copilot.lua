vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true

return {
  "github/copilot.vim",
  config = function()
    -- HACK: This needs to be called as a vim expression for some reason.
    -- This couldn't register when i added it to keymaps.lua
    vim.cmd([[
      imap <silent><script><expr> <C-F> copilot#Accept("\<CR>")
    ]])
  end,
}
