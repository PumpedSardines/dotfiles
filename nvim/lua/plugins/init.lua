local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  require("plugins.tools.fwatch"),

  require("plugins.colorschemes.everforest"),
  require("plugins.colorschemes.nightfox"),
  -- require("plugins.colorschemes.accent"),
  -- require("plugins.colorschemes.base64"),

  require("plugins.lsp.mason"),
  require("plugins.lsp.null_ls"),
  require("plugins.lsp.mason-lspconfig"),
  require("plugins.lsp.nvim-lspconfig"),

  require("plugins.luasnip"),
  -- require("plugins.barbecue"),
  require("plugins.neo-tree"),
  -- require("plugins.symbols-outline"),
  -- require("plugins.toggle-term"),
  require("plugins.treesiter"),
  require("plugins.telescope"),
  require("plugins.gitsigns"),
  require("plugins.cmp"),
  require("plugins.lualine"),
  require("plugins.dressing"),
  require("plugins.tabby"),
  require("plugins.which-key"),
  require("plugins.todo-comments"),
  require("plugins.copilot"),
  require("plugins.config-local"),

  require("plugins.tweaks.bufdelete"),
  require("plugins.tweaks.telescope-tabs"),
  require("plugins.tweaks.window-picker"),
  -- require("plugins.tweaks.nvim-colorizer"),
  -- require("plugins.tweaks.limelight"),
  require("plugins.tweaks.autoclose"),
  require("plugins.tweaks.comment"),
  require("plugins.tweaks.indent-lines"),
})
