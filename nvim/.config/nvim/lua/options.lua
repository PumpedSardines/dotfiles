-- :help options
local options = {
  backup = false,                         -- creates a backup file
  clipboard = "unnamedplus",              -- allows neovim to access the system clipboard
  cmdheight = 0,                          -- more space in the neovim command line for displaying messages
  completeopt = { "menuone", "noselect" }, -- mostly just for cmp
  conceallevel = 0,                       -- so that `` is visible in markdown files
  fileencoding = "utf-8",                 -- the encoding written to a file
  hlsearch = true,                        -- highlight all matches on previous search pattern
  ignorecase = true,                      -- ignore case in search patterns
  mouse = "a",                            -- allow the mouse to be used in neovim
  pumheight = 10,                         -- pop up menu height
  showmode = false,                       -- we don't need to see things like -- INSERT -- anymore
  showtabline = 4,                        -- always show tabs
  smartcase = true,                       -- smart case
  smartindent = true,                     -- make indenting smarter again
  splitbelow = true,                      -- force all horizontal splits to go below current window
  splitright = true,                      -- force all vertical splits to go to the right of current window
  swapfile = false,                       -- creates a swapfile
  --  termguicolors = true,                    -- set term gui colors (most terminals support this)
  timeoutlen = 500,                       -- time to wait for a mapped sequence to complete (in milliseconds)
  undofile = true,                        -- enable persistent undo
  updatetime = 300,                       -- faster completion (4000ms default)
  writebackup = false,                    -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  expandtab = true,                       -- convert tabs to spaces
  shiftwidth = 2,                         -- the number of spaces inserted for each indentation
  tabstop = 2,                            -- insert 2 spaces for a tab
  cursorline = true,                      -- highlight the current line
  number = true,                          -- set numbered lines
  relativenumber = false,                 -- set relative numbered lines
  numberwidth = 4,                        -- set number column width to 2 {default 4}
  signcolumn = "yes",                     -- always show the sign column, otherwise it would shift the text each time
  wrap = true,                            -- display lines as one long line
  scrolloff = 8,                          -- is one of my fav
  sidescrolloff = 8,
  langnoremap = true,
  encoding = "utf8",
}
vim.wo.fillchars = "eob: "
vim.opt.shortmess:append("c")
for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.cmd("set nonu")
-- vim.cmd("set relativenumber")
vim.cmd("set whichwrap+=<,>,[,],h,l")
vim.cmd([[set iskeyword+=-]])

-- Colortheme

local function read_file(path)
  local file = io.open(path, "rb") -- r read mode and b binary mode
  if not file then
    return nil
  end
  local content = file:read("*a") -- *a or *all reads the whole file
  file:close()
  return content
end
local function update_theme(dark)
  local theme = (dark and "terafox" or "dayfox")
  local dark = (dark and "dark" or "light")
  vim.cmd("colorscheme " .. theme)
  vim.cmd("set background=" .. dark)
  return { theme, dark }
end
function run_theme_calculation()
  local contents = read_file(os.getenv("HOME") .. "/.config/alacritty/color.yml")
  if contents == nil then
    return update_theme(true)
  end
  if contents:gsub("%s+", "") == "" then
    return update_theme(true)
  else
    return update_theme(false)
  end
end

local initial_theme = run_theme_calculation()
vim.cmd("command! -nargs=? Theme !colortheme <f-args>")
