local map_table = {
  i = {
    -- TODO: Make this work with the keymap table
    -- ["<C-f>"] = {
    --   "<cmd>call copilot#Accept()<cr>",
    --   "Accept copilot",
    --   opts = {
    --     silent = true,
    --     expr = true,
    --     script = true,
    --   },
    -- },
  },
  n = {
    ["<S-k>"] = ":lua vim.lsp.buf.hover()<CR>",
    ["gd"] = ":lua vim.lsp.buf.definition()<CR>",
    ["gi"] = ":lua vim.lsp.buf.implementation()<CR>",
    -- LSP bindings
    --
    -- Resize the windows
    ["<C-Up>"] = ":resize +2<CR>",
    ["<C-Down>"] = ":resize -2<CR>",
    ["<C-Left>"] = ":vertical resize -2<CR>",
    ["<C-Right>"] = ":vertical resize +2<CR>",
    ["[d"] = { ":lua vim.diagnostic.goto_prev()<CR>", "Previous diagnostic" },
    ["]d"] = { ":lua vim.diagnostic.goto_next()<CR>", "Next diagnostic" },
    ["[t"] = { "<cmd>tabp<cr>", "Previous diagnostic" },
    ["]t"] = { "<cmd>tabn<cr>", "Next diagnostic" },
  },
  v = {
    [">"] = ">gv",
    ["<"] = "<gv",
    -- HACK: Make comment toggle work on multiple lines,
    -- There is probably a way to this within the plugin itself
    ["<leader>/"] = ":'<,'>CommentToggle<CR>",
  },
}

local opts = { noremap = true, silent = true }
--

-- vim.api.nvim_set_keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

for mode, maps in pairs(map_table) do
  for keymap, command in pairs(maps) do
    if type(command) == "table" then
      local new_opts = command[3] or opts
      vim.api.nvim_set_keymap(mode, keymap, command[1], new_opts)
    else
      vim.api.nvim_set_keymap(mode, keymap, command, opts)
    end
  end
end

local wk = require("which-key")

wk.register({
  ["c"] = { "<cmd>Bdelete<CR>", "Close buffer" },
  ["e"] = { "<cmd>Neotree toggle<CR>", "Toggle Explorer" },
  ["s"] = { "<cmd>SymbolsOutline<CR>", "Toggle Symbols Outline" },
  ["o"] = { "<cmd>Neotree focus<CR>", "Focus Explorer" },
  ["h"] = { "<cmd>noh<CR>", "Hide selected" },
  ["/"] = { "<cmd>CommentToggle<CR>", "Comment toggle" },
  -- === Telescope ===
  ["f"] = {
    name = "+Find",
    f = { "<cmd>Telescope find_files<cr>", "File Name" },
    w = { ":Telescope live_grep<CR>", "Words" },
    s = { ":Telescope lsp_workspace_symbols<CR>", "Workspace Symbols" },
    d = { ":Telescope diagnostics<CR>", "Buffer Diagnostics" },
    b = { ":Telescope buffers<CR>", "Buffers" },
    h = { ":Telescope help_tags<CR>", "Help Docs" },
    T = { ":TodoTelescope<CR>", "Search Todo comments" },
    t = { ":Telescope telescope-tabs list_tabs<CR>", "Tabs" },
  },
  -- === LSP ===
  ["l"] = {
    name = "+LSP",
    ["d"] = { ":lua vim.diagnostic.open_float()<CR>", "Hover Diagnostic" },
    ["f"] = { ":lua vim.lsp.buf.format()<CR>", "Format Code" },
    ["a"] = { ":lua vim.lsp.buf.code_action()<CR>", "Code Action" },
    ["r"] = { ":lua vim.lsp.buf.rename()<CR>", "Rename Token" },
  },
  -- === GIT ==
  ["g"] = {
    name = "+Git",
    ["b"] = { '<cmd>lua require("gitsigns").blame_line()<cr>', "Blame Line" },
  },
  -- === Terminal ===
  ["T"] = {
    name = "+Terminal",
    ["f"] = { "<cmd>ToggleTerm direction=float<CR>", "Float terminal" },
  },
  -- === Tabs ===
  ["t"] = {
    name = "+Tabs",
    ["n"] = { "<cmd>tabnew<CR>", "New Tab" },
    ["s"] = { "<cmd>tab split<CR>", "Open buffer in new tab" },
    ["c"] = { "<cmd>tabclose<CR>", "Close current tab" },
    ["r"] = { "<cmd>lua require('rename_tab')()<CR>", "Rename tab" },
  },
}, { mode = "n", prefix = "<leader>" })