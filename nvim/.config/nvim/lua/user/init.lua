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
  vim.cmd("colorscheme " .. theme)
  return theme
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

--              AstroNvim Configuration Table
-- All configuration changes should go inside of the table

-- You can think of a Lua "table" as a dictionary like data structure the
-- normal format is "key = value". These also handle array like data structures
-- where a value with no key simply has an implicit numeric key
local config = {
  -- Configure AstroNvim updates
  updater = {
    remote = "origin",   -- remote to use
    channel = "stable",  -- "stable" or "nightly"
    version = "latest",  -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
    branch = "main",     -- branch name (NIGHTLY ONLY)
    commit = nil,        -- commit hash (NIGHTLY ONLY)
    pin_plugins = nil,   -- nil, true, false (nil will pin plugins on stable only)
    skip_prompts = false, -- skip prompts about breaking changes
    show_changelog = true, -- show the changelog after performing an update
    auto_reload = false, -- automatically reload and sync packer after a successful update
    auto_quit = false,   -- automatically quit the current session after a successful update
    -- remotes = { -- easily add new remotes to track
    --   ["remote_name"] = "https://remote_url.come/repo.git", -- full remote url
    --   ["remote2"] = "github_user/repo", -- GitHub user/repo shortcut,
    --   ["remote3"] = "github_user", -- GitHub user assume AstroNvim fork
    -- },
  },
  -- Set colorscheme to use
  colorscheme = initial_theme,
  -- Add highlight groups in any theme
  highlights = {
    init = function(scheme)
      local C = require("default_theme.colors")

      -- scheme["DiagnosticsErrorFloat"] = { fg = C.blue, underline = true }
      -- scheme["HintFloat"] = { fg = C.blue, underline = true }
      -- scheme["InfoFloat"] = { fg = C.blue, underline = true }
      -- scheme["WarnFloat"] = { fg = C.blue, underline = true }

      -- scheme["IndentBlanklineContextStart"] = { fg = C.blue, underline = true }
      -- scheme["IndentBlanklineContextChar"] = { fg = C.blue, nocombine = true }
      -- scheme["IndentBlanklineContextStart"] = { fg = C.blue, underline = true }
      -- scheme["IndentBlanklineContextChar"] = { fg = C.blue, nocombine = true }

      return scheme
    end,
  },
  -- set vim options here (vim.<first_key>.<second_key> = value)
  options = {
    opt = {
      relativenumber = true, -- sets vim.opt.relativenumber
      number = true,      -- sets vim.opt.number
      spell = false,      -- sets vim.opt.spell
      signcolumn = "auto", -- sets vim.opt.signcolumn to auto
      wrap = true,        -- sets vim.opt.wrap
      -- Everforest color theme light
      background = "dark",
    },
    g = {
      -- everforest plugin
      everforest_diagnostic_virtual_text = "colored",
      everforest_background = "soft",
      -- copilot plugin
      copilot_no_tab_map = true,
      -- random plugins
      mapleader = " ",                -- sets vim.g.mapleader
      autoformat_enabled = true,      -- enable or disable auto formatting at start (lsp.formatting.format_on_save must be enabled)
      cmp_enabled = true,             -- enable completion at start
      autopairs_enabled = true,       -- enable autopairs at start
      diagnostics_enabled = true,     -- enable diagnostics at start
      status_diagnostics_enabled = true, -- enable diagnostics in statusline
      icons_enabled = true,           -- disable icons in the UI (disable if no nerd font is available, requires :PackerSync after changing)
      heirline_bufferline = true,     -- enable new heirline based bufferline (requires :PackerSync after changing)
    },
  },
  -- If you need more control, you can use the function()...end notation
  -- options = function(local_vim)
  --   local_vim.opt.relativenumber = true
  --   local_vim.g.mapleader = " "
  --   local_vim.opt.whichwrap = vim.opt.whichwrap - { 'b', 's' } -- removing option from list
  --   local_vim.opt.shortmess = vim.opt.shortmess + { I = true } -- add to option list
  --
  --   return local_vim
  -- end,

  -- Set dashboard header
  header = {
    " _  ___   _____ __  __ ",
    "| \\| \\ \\ / /_ _|  \\/  |",
    "| .` |\\ V / | || |\\/| |",
    "|_|\\_| \\_/ |___|_|  |_|",
    --
    -- " █████  ███████ ████████ ██████   ██████",
    -- "██   ██ ██         ██    ██   ██ ██    ██",
    -- "███████ ███████    ██    ██████  ██    ██",
    -- "██   ██      ██    ██    ██   ██ ██    ██",
    -- "██   ██ ███████    ██    ██   ██  ██████",
    -- " ",
    -- "███    ██ ██    ██ ██ ███    ███",
    -- "████   ██ ██    ██ ██ ████  ████",
    -- "██ ██  ██ ██    ██ ██ ██ ████ ██",
    -- "██  ██ ██  ██  ██  ██ ██  ██  ██",
    -- "██   ████   ████   ██ ██      ██",
  },
  -- Default theme configuration
  default_theme = {
    -- Modify the color palette for the default theme
    colors = {
      fg = "#abb2bf",
      bg = "#1e222a",
    },
    highlights = function(hl) -- or a function that returns a new table of colors to set
      local C = require("default_theme.colors")

      -- hl.Normal = { fg = C.fg, bg = C.bg }

      -- New approach instead of diagnostic_style
      hl.DiagnosticError.italic = true
      hl.DiagnosticHint.italic = true
      hl.DiagnosticInfo.italic = true
      hl.DiagnosticWarn.italic = true

      return hl
    end,
    -- enable or disable highlighting for extra plugins
    plugins = {
      aerial = true,
      beacon = false,
      bufferline = true,
      cmp = true,
      dashboard = true,
      highlighturl = true,
      hop = false,
      indent_blankline = true,
      lightspeed = false,
      ["neo-tree"] = true,
      notify = true,
      ["nvim-tree"] = false,
      ["nvim-web-devicons"] = true,
      rainbow = true,
      symbols_outline = false,
      telescope = true,
      treesitter = true,
      vimwiki = false,
      ["which-key"] = true,
    },
  },
  -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
  diagnostics = {
    virtual_text = true,
    underline = true,
  },
  -- Extend LSP configuration
  lsp = {
    -- enable servers that you already have installed without mason
    servers = {
      -- "pyright"
    },
    formatting = {
      -- control auto formatting on save
      format_on_save = {
        enabled = true, -- enable or disable format on save globally
        allow_filetypes = { -- enable format on save for specified filetypes only
          -- "go",
        },
        ignore_filetypes = { -- disable format on save for specified filetypes
          -- "python",
        },
      },
      disabled = { -- disable formatting capabilities for the listed language servers
        -- "sumneko_lua",
      },
      timeout_ms = 1000, -- default format timeout
      -- filter = function(client) -- fully override the default formatting function
      --   return true
      -- end
    },
    -- easily add or disable built in mappings added during LSP attaching
    mappings = {
      n = {
        ["K"] = {
          function()
            vim.lsp.buf.hover()
          end,
          desc = "Hover symbol details",
        },
      },
    },
    -- add to the global LSP on_attach function
    -- on_attach = function(client, bufnr)
    -- end,

    -- override the mason server-registration function
    server_registration = function(server, opts)
      local utils = require("lspconfig/util")

      if opts["handlers"] == nil then
        opts["handlers"] = {}
      end
      opts["handlers"]["textDocument/completion"] = {
        completionItem = {
          snippetSupport = false,
        },
      }

      ---@diagnostic disable-next-line: empty-block
      if server == "curlylint" then
      end

      -- tsserver custom shit here
      if server == "tsserver" then
        -- This code makes it so that when going to definition on a react component
        -- It automatically picks the first options. Tsserver responds with both the component and the file for the TypeDef for React.FC
        -- You would never want to go to the definition of React.FC

        local function filter(arr, fn)
          if type(arr) ~= "table" then
            return arr
          end

          local filtered = {}
          for k, v in pairs(arr) do
            if fn(v, k, arr) then
              table.insert(filtered, v)
            end
          end

          return filtered
        end

        local function filterReactDTS(value)
          if value["targetUri"] ~= nil then
            return string.match(value.targetUri, "react/index.d.ts") == nil
          end
          return string.match(value.uri, "react/index.d.ts") == nil
        end

        opts["handlers"]["textDocument/definition"] = function(err, result, method, ...)
          if vim.tbl_islist(result) and #result > 1 then
            local filtered_result = filter(result, filterReactDTS)
            return vim.lsp.handlers["textDocument/definition"](err, filtered_result, method, ...)
          end

          return vim.lsp.handlers["textDocument/definition"](err, result, method, ...)
        end

        opts.root_dir = utils.root_pattern("package.json", "tsconfig.json")
        require("lspconfig")[server].setup(opts)
        return
      end

      if server == "denols" then
        opts.root_dir = utils.root_pattern("deno.json", "import_map.json")
        opts["single_file_support"] = false
        require("lspconfig")[server].setup(opts)
        return
      end

      require("lspconfig")[server].setup(opts)
    end,
    -- Add overrides for LSP server settings, the keys are the name of the server
    ["server-settings"] = {
      -- example for addings schemas to yamlls
      -- yamlls = { -- override table for require("lspconfig").yamlls.setup({...})
      --   settings = {
      --     yaml = {
      --       schemas = {
      --         ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*.{yml,yaml}",
      --         ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
      --         ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
      --       },
      --     },
      --   },
      -- },
    },
  },
  -- Mapping data with "desc" stored directly by vim.keymap.set().
  --
  -- Please use this mappings table to set keyboard mapping since this is the
  -- lower level configuration and more robust one. (which-key will
  -- automatically pick-up stored data by this setting.)
  mappings = {
    -- first key is the mode
    n = {
      ["o"] = { "o<Esc>", desc = "New line without insert" },
      ["O"] = { "O<Esc>", desc = "New line without insert" },
      ["<leader>v"] = { "<cmd>vsplit<cr>", desc = "Split vertical" },
      -- second key is the lefthand side of the map
      -- mappings seen under group name "Buffer"
      -- ["<leader>bb"] = { "<cmd>tabnew<cr>", desc = "New tab" },
      -- ["<leader>bc"] = { "<cmd>BufferLinePickClose<cr>", desc = "Pick to close" },
      -- ["<leader>bj"] = { "<cmd>BufferLinePick<cr>", desc = "Pick to jump" },
      -- ["<leader>bt"] = { "<cmd>BufferLineSortByTabs<cr>", desc = "Sort by tabs" },

      -- turn off annoying keybindings
      ["|"] = false,
      ["\\"] = false,
    },
  },
  -- Configure plugins
  plugins = {
    init = {
      -- Disable astronvim plugins
      ["max397574/better-escape.nvim"] = { disable = true }, -- disabled jk binding for esc
      ["stevearc/aerial.nvim"] = { disable = true },      -- Disables symbol outline, becuase this plugin is janky as hell
      ["mfussenegger/nvim-dap"] = { disabled = true },    -- Disables the debugger, becuase it's hard too use and really buggy compared to IDE's with built in debuggers
      --
      -- My personal plugins
      { "prisma/vim-prisma" },       -- Color theme for prisma
      { "gpanders/editorconfig.nvim" }, -- Parse .editorconfig files
      { "rhaiscript/vim-rhai" },     -- Color theme for rhai
      --
      -- Color themes
      { "morhetz/gruvbox" },
      { "sainnhe/everforest" },
      { "EdenEast/nightfox.nvim" },
      --
      -- Custom plugins
      { "~/.config/nvim/lua/user/plugins/lorem-ipsum" }, -- Enables the LoremIpsum command
    },
    -- All other entries override the require("<key>").setup({...}) call for default plugins
    ["null-ls"] = function(config) -- overrides `require("null-ls").setup(config)`
      -- config variable is the default configuration table for the setup function call
      local null_ls = require("null-ls")

      -- Check supported formatters and linters
      -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
      -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics

      config.sources = {
        -- Set a formatter
        null_ls.builtins.diagnostics.cspell.with({
          diagnostics_postprocess = function(diagnostic)
            diagnostic.severity = vim.diagnostic.severity.INFO
          end,
          diagnostic_config = {
            underline = true,
            virtual_text = false,
            signs = true,
            update_in_insert = false,
            severity_sort = true,
          },
        }),
        null_ls.builtins.code_actions.cspell.with({
          config = {
            create_config_file = true,
            create_config_file_name = ".cspell.json",
          },
        }),
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettierd,
        null_ls.builtins.code_actions.eslint_d,
        null_ls.builtins.diagnostics.eslint_d.with({
          filter = function(diagnostic)
            local possible_useless = {
              diagnostic.code == "prettier/prettier",
              not not diagnostic.message:find("Error: No ESLint configuration found"),
            }

            return not vim.tbl_contains(possible_useless, true)
          end,
        }),
        null_ls.builtins.formatting.eslint_d,
        null_ls.builtins.formatting.rustfmt,
      }
      return config -- return final config table
    end,
    treesitter = {
      ensure_installed = { "vim", "lua", "typescript", "javascript", "tsx", "rust" },
    },
    -- use mason-lspconfig to configure LSP installations
    ["mason-lspconfig"] = { -- overrides `require("mason-lspconfig").setup(...)`
      ensure_installed = { "sumneko_lua", "tsserver", "denols" },
    },
    -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
    ["mason-null-ls"] = { -- overrides `require("mason-null-ls").setup(...)`
      ensure_installed = { "prettierd", "eslint_d", "stylua", "cspell", "rustfmt", "black" },
    },
    ["mason-nvim-dap"] = {},
    ["neo-tree"] = {
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = true,
        },
      },
      source_selector = {
        winbar = false,
        statusline = false,
      },
      window = {
        mappings = {
          ["v"] = "open_vsplit",
          ["H"] = "toggle_hidden",
          ["L"] = false,
        },
      },
    },
    cmp = function(opts)
      -- opts parameter is the default options table
      -- the function is lazy loaded so cmp is able to be required
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      -- modify the mapping part of the table
      opts.mapping["<Tab>"] = cmp.mapping(function(fallback)
        if luasnip.jumpable(1) then
          luasnip.jump(1)
        else
          fallback()
        end
      end, { "i", "s" })

      opts.mapping["<S-Tab>"] = cmp.mapping(function(fallback)
        if luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" })

      opts["enabled"] = function()
        return vim.fn.reg_recording() == ""
      end

      -- i don't think cmp border looks good
      opts["window"]["documentation"] = nil
      opts["window"]["completion"] = nil

      -- return the new table to be used
      return opts
    end,
    telescope = {
      defaults = {
        file_ignore_patterns = { "node_modules", "package-lock.json", "yarn.lock", "deno.lock" },
      },
    },
  },
  -- LuaSnip Options
  luasnip = {
    -- Extend filetypes
    filetype_extend = {
      javascriptreact = { "javascript" },
      typescriptreact = { "typescript" },
    },
    -- Configure luasnip loaders (vscode, lua, and/or snipmate)
    snipmate = {
      -- Add paths for including more VS Code style snippets in luasnip
      paths = {
        "~/.config/nvim/lua/user/snippets",
      },
    },
  },
  -- CMP Source Priorities
  -- modify here the priorities of default cmp sources
  -- higher value == higher priority
  -- The value can also be set to a boolean for disabling default sources:
  -- false == disabled
  -- true == 1000
  cmp = {
    source_priority = {
      nvim_lsp = 1000,
      luasnip = false,
      buffer = 500,
      path = 250,
    },
  },
  -- Modify which-key registration (Use this with mappings table in the above.)
  ["which-key"] = {
    -- Add bindings which show up as group name
    register = {
      -- first key is the mode, n == normal mode
      n = {
        -- second key is the prefix, <leader> prefixes
        ["<leader>"] = {
          -- third key is the key to bring up next level and its displayed
          -- group name in which-key top level menu
          ["b"] = nil,
          ["D"] = nil,
        },
      },
    },
  },
  polish = function()
    -- vim.api.nvim_create_autocmd("SigUSR1", {
    --   command = "lua run_theme_calculation()",
    -- })
    -- vim.api.nvim_create_autocmd("RecordingLeave", {
    --   command = "Copilot enable",
    -- })

    -- vim.api.nvim_create_autocmd("VimEnter,BufNewFile,BufReadPost", { command = "call HardMode()" })

    vim.cmd("set iskeyword+=$")
    vim.cmd("set iskeyword+=-")

    vim.cmd("command! -nargs=? Theme !colortheme <f-args>")

    -- vim.cmd [[let g:copilot_no_tab_map = v:true]]
    -- local copilot_options = { silent = true, expr = true, script = true }
    -- vim.api.nvim_set_keymap("i", "<C-f>", "copilot#Accept(<Tab>)", copilot_options)

    vim.cmd([[set foldlevel=99]])
    vim.cmd([[set foldmethod=expr]])
    vim.cmd([[set foldexpr=nvim_treesitter#foldexpr()]])

    -- vim.cmd [[command! -nargs=? LoremIpsum lua write_under_line(lorem_ipsum(<args>))]]
  end,
}

return config
