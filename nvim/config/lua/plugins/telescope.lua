require("telescope").setup({
  extensions = {
    fzy_native = {
      override_generic_sorter = false,
      override_file_sorter = true,
    },
  },
  pickers = {
    find_files = {
      theme = "ivy",
    },
    live_grep = {
      theme = "ivy",
    },
    buffers = {
      theme = "dropdown",
    },
    help_tags = {
      theme = "ivy",
    },
    lsp_workspace_symbols = {
      theme = "ivy",
    },
    diagnostics = {
      theme = "ivy",
    },
  },
})

require("telescope").load_extension("fzy_native")