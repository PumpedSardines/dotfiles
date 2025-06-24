local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

parser_config.ejs = {
  filetype = "ejs",
}

require("nvim-treesitter.configs").setup({
  highlight = {
    enable = true,
    disable = { "haskell" },
  },
})
