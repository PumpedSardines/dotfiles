return {
  "nvim-treesitter/nvim-treesitter",
  config = function()
    require("nvim-treesitter.configs").setup({
      -- Doesn't take much space, but we get LSP support in all directories
      ensure_installed = "all",
      highlight = {
        enable = true,
        disable = { "haskell" },
      },
    })
  end,
}
