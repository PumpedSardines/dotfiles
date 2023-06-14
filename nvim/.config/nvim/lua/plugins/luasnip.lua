return {
  "L3MON4D3/LuaSnip",
  dependencies = {
    "saadparwaiz1/cmp_luasnip",
  },
  config = function()
    require("luasnip.loaders.from_snipmate").lazy_load({ path = { "./snippets" } })
  end,
}
