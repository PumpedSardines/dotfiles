require("dressing").setup({
  input = {
    get_config = function(opts)
      if opts.kind == "rename_tab" then
        return {
          backend = "nui",
          nui = {
            relative = "cursor",
            max_width = 40,
          },
        }
      end
    end,
  },
})

