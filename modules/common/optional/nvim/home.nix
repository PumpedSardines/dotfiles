{
  pkgs,
  lib,
  ...
}: let
  vimPackageFromPluginDir = name: version:
    pkgs.vimUtils.buildVimPlugin {
      pname = "${lib.strings.sanitizeDerivationName name}";
      version = version;
      src = ./plugins/${name};
    };
  vimPackageFromGitHub = owner: repo: rev: sha256:
    pkgs.vimUtils.buildVimPlugin {
      pname = "${lib.strings.sanitizeDerivationName (owner + "/" + repo)}";
      version = rev;
      src = pkgs.fetchFromGitHub {
        owner = owner;
        repo = repo;
        rev = rev;
        sha256 = sha256;
      };
    };
in {
# LSP
  home.packages = with pkgs; [
    deno
    prettierd # JavaScript formatter
    nodePackages.eslint_d # JavaScript linter
    nodePackages.pnpm
    nodePackages.typescript-language-server
    vscode-langservers-extracted # html, css, json, eslint
    nodePackages."@astrojs/language-server"
    nest-cli
    stylua
    lua-language-server
    alejandra
    nixd
    zig
    zls
    gopls
    go
    jdk21
    gleam
    erlang
    rustfmt
    rust-analyzer
    php
    php83Packages.php-cs-fixer
    php83Packages.composer
    nodePackages_latest.intelephense
  ];
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    withNodeJs = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    plugins = with pkgs.vimPlugins; [
      # Tools
      plenary-nvim
      nvim-web-devicons
      nui-nvim
      nvim-web-devicons

      nvim-lspconfig
      none-ls-nvim

      avante-nvim
      codecompanion-nvim

      (nvim-treesitter.withPlugins (_:
        nvim-treesitter.allGrammars
        ++ [
          (pkgs.tree-sitter.buildGrammar {
            language = "ejs";
            version = "v0.21.0";
            src = pkgs.fetchFromGitHub {
              owner = "tree-sitter";
              repo = "tree-sitter-embedded-template";
              rev = "38d5004a797298dc42c85e7706c5ceac46a3f29f";
              sha256 = "sha256-IPPCexaq42Em5A+kmrj5e/SFrXoKdWCTYAL/TWvbDJ0=";
            };
          })
        ]))

      nvim-dap
      nvim-dap-ui

      which-key-nvim
      nvim-config-local
      neo-tree-nvim
      (
        vimPackageFromPluginDir
        "fritiof"
        "1.0"
      )
      (
        vimPackageFromPluginDir
        "hihi"
        "1.0"
      )
      (
        vimPackageFromPluginDir
        "css-module-open"
        "1.0"
      )
      leap-nvim
      tabby-nvim
      dressing-nvim
      gitsigns-nvim
      luasnip

      nvim-cmp
      cmp-nvim-lsp
      cmp-path
      cmp-buffer
      cmp-cmdline
      cmp_luasnip

      lualine-nvim
      copilot-vim
      todo-comments-nvim

      # Tweaks
      nvim-comment
      editorconfig-nvim
      bufdelete-nvim
      autoclose-nvim
      indent-blankline-nvim
      nvim-colorizer-lua
      telescope-nvim
      telescope-fzy-native-nvim
      nvim-window-picker

      (
        vimPackageFromGitHub
        "neanias"
        "everforest-nvim"
        "2eb7c34"
        "sha256-LMIGPDhKZVqriGuPR9ICVo55QdyByLXOoRK82KfsRxU="
      )
      lush-nvim
      (
        vimPackageFromGitHub
        "iagorrr"
        "noctis-high-contrast.nvim"
        "45dc48a"
        "sha256-lJct4CISxv28Y5IeZtcTmvUZ8FBLv2TLf1MBiLYDmnw="
      )

      fwatch-nvim # To update the colortheme on the fly
      outline-nvim
      cspell-nvim
    ];
  };
  home.file = {
    ".config/nvim" = {
      source = ./config;
      recursive = true;
    };
  };
}
