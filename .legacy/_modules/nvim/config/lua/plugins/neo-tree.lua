require("nvim-web-devicons").setup({
  override_by_extension = {
    ["gleam"] = {
      icon = "",
      color = "#ffaff3",
      name = "Gleam",
    },
    ["astro"] = {
      icon = "",
      color = "#7482f7",
      name = "Astro",
    },
  },
})

require("neo-tree").setup({
  close_if_last_window = true,
  window = {
    width = 30,
    mappings = {
      ["h"] = "close_node",
      ["l"] = "open_with_window_picker",
      ["w"] = nil,
    },
  },
  filesystem = {
    follow_current_file = true,
    hijack_netrw_behavior = "open_current",
    default_component_configs = {},
    git_status = {
      symbols = {
        -- Change type
        added = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
        modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
        deleted = "✖", -- this can only be used in the git_status source
        renamed = "󰁕", -- this can only be used in the git_status source
        -- Status type
        untracked = "",
        ignored = "",
        unstaged = "󰄱",
        staged = "",
        conflict = "",
      },
    },
    use_libuv_file_watcher = true,
    filtered_items = {
      never_show = {
        ".git",
        ".DS_Store",
        "thumbs.db",
        ".envrc",
      },
      always_show = {
        ".gitignore",
      },
      always_show_by_pattern = {
        ".env*",
      },
      hide_by_name = {
        "Cargo.lock",
        "flake.lock",
        "package-lock.json",
      },
    },
  },
})
