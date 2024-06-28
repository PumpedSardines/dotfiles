local function rename_current_tab()
  local api = require("tabby.module.api")

  vim.ui.input({ prompt = "Name: ", kind = "rename_tab" }, function(input)
    local current_tab = api.get_current_tab()

    if input == nil or input == "" then
      return
    end

    vim.g["tabby_tabname_" .. current_tab] = input
    require("tabby.feature.tab_name").set(current_tab, input)
  end)
end

return rename_current_tab
