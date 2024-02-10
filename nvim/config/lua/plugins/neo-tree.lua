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
    use_libuv_file_watcher = true,
    filtered_items = {
        never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
        ".DS_Store",
        "thumbs.db",
        },
    },
    },
})
