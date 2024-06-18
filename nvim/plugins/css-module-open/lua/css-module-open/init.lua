local M = {}

--- Gets the current buffer as a table of lines
-- @return table: The buffer as a table of lines
local buffer_to_lines = function()
  return vim.api.nvim_buf_get_lines(0, 0, vim.api.nvim_buf_line_count(0), false)
end

--- Filters the imports from the given lines and maps them to a table
-- @param lines table: The lines to filter
-- @return table: The imports as a table
local lines_filter_imports = function(lines)
  local imports = {}
  for _, line in ipairs(lines) do
    local m = string.match(line, "import.+from [\"'](.+)[\"']")
    if m then
      table.insert(imports, m)
    end
  end
  return imports
end

local filter_module_imports = function(imports, allowed_extensions)
  local final_imports = {}

  for _, import in ipairs(imports) do
    m = string.match(import, ".module.(.+)$")
    if m then
      if allowed_extensions[m] then
        table.insert(final_imports, import)
      end
    end
  end

  return final_imports
end

local get_file_path = function()
  local lines = buffer_to_lines()
  local imports = lines_filter_imports(lines)
  local allowed_extensions = {
    ["css"] = true,
    ["scss"] = true,
    ["sass"] = true,
    ["less"] = true,
  }
  local final_imports = filter_module_imports(imports, allowed_extensions)

  if #final_imports == 0 then
    return nil, "No module imports found"
  end

  if #final_imports > 1 then
    return nil, "Multiple module imports found"
  end

  local import_path = final_imports[1]
  local buffer_path = vim.api.nvim_buf_get_name(0)
  local buffer_dir = vim.fn.fnamemodify(buffer_path, ":h")
  local file_path = vim.fn.fnamemodify(buffer_dir .. "/" .. import_path, ":p")

  if vim.fn.filereadable(file_path) == 0 then
    return nil, "File does not exist"
  end

  return file_path, nil
end

local open_in_right_most_window = function(file_path)
  local windows = {}

  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    local buf_id = vim.api.nvim_win_get_buf(win)
    local buf_name = vim.api.nvim_buf_get_name(buf_id)

    if vim.fn.filereadable(buf_name) == 1 then
      table.insert(windows, win)
    end
  end

  if #windows == 0 then
    assert(false, "No windows found")
    return
  end

  if #windows == 1 then
    vim.cmd("vnew")
    vim.cmd("edit " .. file_path)
    return
  end

  local right_most = nil
  local right_most_col = 0

  for _, win in ipairs(windows) do
    local col = vim.api.nvim_win_get_position(win)[2]
    if col > right_most_col then
      right_most = win
      right_most_col = col
    end
  end

  vim.api.nvim_set_current_win(right_most)
  vim.cmd("edit " .. file_path)
end

M.open = function()
  local file_path, err = get_file_path()
  if err then
    print("Error: " .. err)
    return
  end

  -- Open new window with the file
  open_in_right_most_window(file_path)
end

return M
