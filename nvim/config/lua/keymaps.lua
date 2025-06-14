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
    ["[d"] = {
      ":lua vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })<CR>",
      "Previous diagnostic",
    },
    ["]d"] = {
      ":lua vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })<CR>",
      "Next diagnostic",
    },
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

wk.add({
  mode = "n",
  { "<leader>c", "<cmd>Bdelete<CR>", desc = "Close buffer" },
  { "<leader>e", "<cmd>Neotree toggle<CR>", desc = "Toggle Explorer" },
  { "<leader>s", "<cmd>Outline<CR>", desc = "Toggle Symbols Outline" },
  { "<leader>m", '<cmd>lua require("css-module-open").open()<CR>', desc = "Open css module file" },
  { "<leader>o", "<cmd>Neotree focus<CR>", desc = "Focus Explorer" },
  { "<leader>h", "<cmd>noh<CR>", desc = "Hide selected" },
  { "<leader>/", "<cmd>CommentToggle<CR>", desc = "Comment toggle" },

  -- Config Local
  { "<leader>L", group = "Config Local" },
  { "<leader>Lt", "<cmd>ConfigLocalTrust<cr>", desc = "Trust" },
  { "<leader>Li", "<cmd>ConfigLocalIgnore<cr>", desc = "Ignore" },

  -- Telescope
  { "<leader>f", group = "Find" },
  { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "File Name" },
  { "<leader>fw", ":Telescope live_grep<CR>", desc = "Words" },
  { "<leader>fs", ":Telescope lsp_document_symbols<CR>", desc = "Document Symbols" },
  { "<leader>fS", ":Telescope lsp_workspace_symbols<CR>", desc = "Workspace Symbols" },
  { "<leader>fd", ":Telescope diagnostics<CR>", desc = "Buffer Diagnostics" },
  { "<leader>fb", ":Telescope buffers<CR>", desc = "Buffers" },
  { "<leader>fh", ":Telescope help_tags<CR>", desc = "Help Docs" },
  { "<leader>fT", ":TodoTelescope<CR>", desc = "Search Todo comments" },
  { "<leader>ft", ":Telescope telescope-tabs list_tabs<CR>", desc = "Tabs" },

  -- LSP
  { "<leader>l", group = "LSP" },
  { "<leader>ld", "<cmd>lua vim.diagnostic.open_float()<CR>", desc = "Hover Diagnostic" },
  { "<leader>lf", "<cmd>lua vim.lsp.buf.format()<CR>", desc = "Format Code" },
  { "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>", desc = "Code Action" },
  { "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>", desc = "Rename Token" },
  { "<leader>lR", "<cmd>lua require('telescope.builtin').lsp_references()<CR>", desc = "Goto references" },
  { "<leader>lc", "<cmd>lua vim.lsp.codelens.run()<CR>", desc = "Run code lens" },

  -- Code Explorer
  { "<leader>C", group = "Code Explorer" },
  { "<leader>Cc", "<cmd>CECompile<CR>", desc = "Compile once" },
  { "<leader>Cl", "<cmd>CECompileLive<CR>", desc = "Compile live" },
  { "<leader>Ck", "<cmd>CEShowTooltip<CR>", desc = "Hover diagnostic in asm" },
  { "<leader>Cw", "<cmd>CEOpenWebsite<CR>", desc = "Open in website" },
  { "<leader>Cd", "<cmd>CEDeleteCache<CR>", desc = "Clear cache" },

  -- Git
  { "<leader>g", group = "Git" },
  { "<leader>gb", '<cmd>lua require("gitsigns").blame_line()<cr>', desc = "Blame Line" },

  -- Terminal
  { "<leader>T", group = "Terminal" },
  { "<leader>Tf", "<cmd>ToggleTerm direction=float<CR>", desc = "Float terminal" },

  -- Tabs
  { "<leader>t", group = "Tabs" },
  { "<leader>tn", "<cmd>tabnew<CR>", desc = "New Tab" },
  { "<leader>ts", "<cmd>tab split<CR>", desc = "Open buffer in new tab" },
  { "<leader>tc", "<cmd>tabclose<CR>", desc = "Close current tab" },
  { "<leader>tr", "<cmd>lua require('rename_tab')()<CR>", desc = "Rename tab" },
})
