# This file is made with the help of the following resources:
# 
# https://gist.github.com/nat-418/d76586da7a5d113ab90578ed56069509
# https://github.com/LongerHV/nixos-configuration/blob
{
    config
    ,pkgs
    , lib
    , ...
}: let
    vimPackageFromGitHub = owner: repo: rev: sha256: pkgs.vimUtils.buildVimPlugin {
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

            nvim-lspconfig
            nvim-treesitter.withAllGrammars
            
            which-key-nvim
            neo-tree-nvim
            tabby-nvim
            dressing-nvim
            gitsigns-nvim
            luasnip
            nvim-cmp
            cmp-nvim-lsp
            cmp-path
            cmp-buffer
            cmp-cmdline
            lualine-nvim
            
            # Tweaks
            nvim-comment
            bufdelete-nvim
            autoclose-nvim
            indent-blankline-nvim
            nvim-colorizer-lua
            telescope-nvim
            telescope-fzy-native-nvim
            nvim-window-picker

            everforest
            fwatch-nvim # To update the colortheme on the fly

            (vimPackageFromGitHub 
                "LukasPietzschmann"
                "telescope-tabs"
                "c357235"
                "sha256-4mVDF/GOeQod89jeSkmbKoQpGzyL8dYaiwnZK3M4sFU="
            )
        ];
    };
    home.file = {
        ".config/nvim" = {
          source = ./config;
          recursive = true;
        };
    };
}
