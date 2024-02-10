return {
  "lewis6991/gitsigns.nvim",
  config = function()
    require("gitsigns").setup({
      preview_config = {
        -- Options passed to nvim_open_win
        border = { "", "", "", "", "", "", "", " " },
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
      },
    })
  end,
}
