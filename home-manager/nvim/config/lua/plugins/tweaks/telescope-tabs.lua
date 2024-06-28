require("telescope-tabs").setup({
    entry_formatter = function(tab_id, buffer_ids, file_names, file_paths, is_current)
        local entry_string = table.concat(file_names, ", ")

        local name = vim.g["tabby_tabname_" .. tab_id]

        if name ~= nil then
            return name
        end

        return string.format("%d: %s%s", tab_id, entry_string, is_current and " <" or "")
    end,
})