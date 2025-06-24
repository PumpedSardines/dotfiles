-- vim.g.everforest_diagnostic_virtual_text = "colored"
-- vim.g.everforest_background = "soft"
--
-- vim.cmd([[
--   if has('termguicolors')
--     set termguicolors
--   endif
-- ]])

require("everforest").setup({
  on_highlights = function(hl, palette)
    hl.DiagnosticError = { fg = palette.none, bg = palette.none, sp = palette.red }
    hl.DiagnosticWarn = { fg = palette.none, bg = palette.none, sp = palette.yellow }
    hl.DiagnosticInfo = { fg = palette.none, bg = palette.none, sp = palette.blue }
    hl.DiagnosticHint = { fg = palette.none, bg = palette.none, sp = palette.green }
  end,
})

-- vim.api.nvim_set_hl(0, 'DiagnosticUnderlineError', {
--   undercurl = true,
--   sp = '#FFA500', -- change to your desired color
-- })
-- require("everforest").setup({
--  on_highlights = function(hl, palette)
--    hl.DiagnosticError = { fg = palette.none, bg = palette.none, sp = palette.red }
--    hl.DiagnosticWarn = { fg = palette.none, bg = palette.none,  sp = palette.yellow }
--    hl.DiagnosticInfo = { fg = palette.none, bg = palette.none,  sp = palette.blue }
--    hl.DiagnosticHint = { fg = palette.none, bg = palette.none,  sp = palette.green }
--  end,
-- })
