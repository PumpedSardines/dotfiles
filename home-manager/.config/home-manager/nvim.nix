{
  config,
  pkgs,
  ...
}: {
  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;

      extraLuaConfig = ''
        -- Flash lines on yank
        vim.cmd([[
        augroup highlight_yank
            autocmd!
            au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=100}
        augroup END
        ]])

        local options = {
          backup = false,
          clipboard = "unnamedplus",
          cmdheight = 0,
          completeopt = { "menuone", "noselect" },
          conceallevel = 0,
          fileencoding = "utf-8",
          hlsearch = true,
          ignorecase = true,
          mouse = "a",
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
        vim.cmd("colorscheme terafox")
      '';
      plugins = with pkgs.vimPlugins; [
        {
          plugin = nightfox-nvim;
        }
        {
          plugin = indent-blankline-nvim;
          type = "lua";
          config = ''
            require("indent_blankline").setup({
            	show_current_context = true,
            	show_current_context_start = false,
            })
          '';
        }
        {
          plugin = which-key-nvim;
          type = "lua";
          config = ''
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
          '';
        }
        {
          plugin = lualine-nvim;
          type = "lua";
          config = ''
            local function show_macro_recording()
              local recording_register = vim.fn.reg_recording()
              if recording_register == "" then
                return ""
              else
                return "Recording @" .. recording_register
              end
            end

            local lualine = require("lualine")
            vim.api.nvim_create_autocmd("recordingenter", {
              callback = function()
                lualine.refresh({
                  place = { "statusline" },
                })
              end,
            })
            vim.api.nvim_create_autocmd("RecordingLeave", {
              callback = function()
                -- This is going to seem really weird!
                -- Instead of just calling refresh we need to wait a moment because of the nature of
                -- `vim.fn.reg_recording`. If we tell lualine to refresh right now it actually will
                -- still show a recording occuring because `vim.fn.reg_recording` hasn't emptied yet.
                -- So what we need to do is wait a tiny amount of time (in this instance 50 ms) to
                -- ensure `vim.fn.reg_recording` is purged before asking lualine to refresh.
                local timer = vim.loop.new_timer()
                timer:start(
                  50,
                  0,
                  vim.schedule_wrap(function()
                    lualine.refresh({
                      place = { "statusline" },
                    })
                  end)
                )
              end,
            })

            require("lualine").setup({
              options = {
                globalstatus = true,
                component_separators = "|",
                section_separators = { left = "", right = "" },
              },
              sections = {
                lualine_a = {
                  { "mode", separator = { left = "" }, right_padding = 2 },
                },
                lualine_b = { "filename", "branch" },
                lualine_c = {
                  "fileformat",
                  {
                    "macro-recording",
                    fmt = show_macro_recording,
                  },
                },
                lualine_x = {},
                lualine_y = { "filetype", "progress" },
                lualine_z = {
                  { "location", separator = { right = "" }, left_padding = 2 },
                },
              },
              inactive_sections = {
                lualine_a = { "filename" },
                lualine_b = {},
                lualine_c = {},
                lualine_x = {},
                lualine_y = {},
                lualine_z = { "location" },
              },
              tabline = {},
              extensions = {},
            })
          '';
        }
        {
          plugin = telescope-nvim;
          type = "lua";
          config = ''
            require("telescope").setup({
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
          '';
        }
        {
          # Make file browsing easier
          plugin = neo-tree-nvim;
          type = "lua";
          config = ''
            require("neo-tree").setup {
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
            }
          '';
        }
        {
          plugin = nvim-treesitter.withAllGrammars;
          type = "lua";
          config = ''
            local treesitter = require('nvim-treesitter.configs')

            treesitter.setup {
              highlight = {
                enable = true,
              },
              indent = {
                enable = true,
              },
              playground = {
                enable = true,
                disable = {},
                updatetime = 25,
                persist_queries = false
              },
            }
          '';
        }
      ];
    };
  };
}
