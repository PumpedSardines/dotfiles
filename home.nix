{
  config,
  pkgs,
  workspace,
  tmux-status-line,
  gdbgui,
  ...
}: let
  customPkgs = import ./pkgs.nix {
    inherit pkgs;
  };
  wss = pkgs.writeShellScriptBin "wss" ''
    workspace open -n "$(workspace ls | fzf | sed 's/:.*//')" && tmux -u a
  '';
  wso = pkgs.writeShellScriptBin "wso" ''
    workspace open -n "$1"
  '';
  wsa = pkgs.writeShellScriptBin "wsa" ''
    workspace add -n "$(pwd | sed "s/^.*\///")"
  '';
  wsr = pkgs.writeShellScriptBin "wsa" ''
    workspace rm -n "$(pwd | sed "s/^.*\///")"
  '';
in {
  home.username = "fritiofrusck";
  home.homeDirectory = "/Users/fritiofrusck";
  home.stateVersion = "23.11"; # Please read the comment before changing.

  imports = [./fish.nix ./nvim/nvim.nix];

  # Home Manager has problems adding pacakges to ~/Applications so this is needed
  # Not sure why?
  # https://gist.github.com/jmatsushita/5c50ef14b4b96cb24ae5268dab613050
  # environment.systemPackages = with pkgs; [
  #   alacritty
  # ];

  home.packages =
    [wss wso workspace tmux-status-line]
    ++ (with pkgs; [
      # dvipng # Used for Anki to generate LaTeX images

      # Main programs that i use a lot
      httpie
      nodejs_20
      cargo
      python3
      gdbgui
      jq
      zoxide

      # Neovim LSP
      # JavaScript
      prettierd # JavaScript formatter
      nodePackages.eslint_d # JavaScript linter
      nodePackages.typescript-language-server
      vscode-langservers-extracted # html, css, json, eslint

      # Spell check
      nodePackages.cspell
      # Lua
      stylua
      lua-language-server

      # Golang
      gopls
      go

      # Zig
      zig
      zls

      # Java
      jdk21

      # Gleam
      gleam
      erlang

      # Rust
      rustfmt
      rust-analyzer
      # nix
      alejandra
      nixd
    ]);

  # Adds files recursively to a path and keeps them in sync with home-manager
  # Very convinient :)
  home.file = {
    ".config/alacritty" = {
      source = ./alacritty;
      recursive = true;
    };
  };
  programs.home-manager.enable = true;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.ripgrep.enable = true;
  programs.gh.enable = true;
  programs.lazygit.enable = true;

  programs.git = {
    enable = true;
    ignores = [".nvim.lua" "node_modules/" ".envrc" ".direnv" ".DS_Store"];
  };

  programs.fzf.enable = true;

  programs.alacritty = {
    enable = true;
    settings = {
      live_config_reload = true;
      window = {
        dimensions = {
          columns = 100;
          lines = 30;
        };
      };
      env = {
        TERM = "xterm-256color";
      };
      font = {
        size = 11.75;
        # size = 11;
        normal = {
          family = "IntelOneMono Nerd Font";
        };
      };
      mouse = {
        hide_when_typing = true;
      };
      import = [
        "~/.config/alacritty/color.toml"
      ];
    };
  };

  programs.tmux = {
    enable = true;
    escapeTime = 0;
    mouse = true;
    keyMode = "vi";
    baseIndex = 1;
    extraConfig = ''
      set-option -sa terminal-overrides ',xterm-256color:RGB'
      set -g default-terminal "screen-256color"

      bind -r k select-pane -U
      bind -r j select-pane -D
      bind -r h select-pane -L
      bind -r l select-pane -R

      bind-key -T copy-mode-vi y send -X copy-selection-and-cancel
      bind-key -T copy-mode-vi v send -X begin-selection
      bind-key -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel

      bind s choose-tree -sZ -O name

      set-option -sg escape-time 10

      set-option -g focus-events on

      set-option -g status on
      set-option -g status-interval 2
      set-option -g status-left-length 60
      set-option -g status-right-length 200

      set -g status-bg black
      set -g status-fg white

      set-option -g status-right "#(tmux_status_line)"
    '';
  };
}
