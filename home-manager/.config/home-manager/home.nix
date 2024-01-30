{ config
, pkgs
, ...
}:
let
  customPkgs = import ./pkgs.nix {
    inherit pkgs;
  };
  debug = pkgs.writeShellScriptBin "debug" ''
    echo ${customPkgs.tmux-status-line}
  '';
  wss = pkgs.writeShellScriptBin "wss" ''
    workspace open -n "$(workspace ls | fzf | sed 's/:.*//')" && tmux -u a
  '';
  wso = pkgs.writeShellScriptBin "wso" ''
    workspace open -n "$1"
  '';
in
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "fritiofrusck";
  home.homeDirectory = "/Users/fritiofrusck";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home. stateVersion = "23.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.

  home.packages =
    [ wss wso debug customPkgs.workspace customPkgs.tmux-status-line ]
    ++ (with pkgs; [
      # Main programs that i use a lot
      httpie
      nodejs_20
      cargo
      python3

      # Random nvim things
      nodePackages.prettier_d_slim
      nodePackages.eslint_d
      alejandra
    ]);
  # # Adds the 'hello' command to your environment. It prints a friendly
  # # "Hello, world!" when run.
  # pkgs.hello

  # # It is sometimes useful to fine-tune packages, for example, by applying
  # # overrides. You can do that directly here, just don't forget the
  # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
  # # fonts?
  # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

  # # You can also create simple shell scripts directly inside your
  # # configuration. For example, this adds a command 'my-hello' to your
  # # environment:
  # (pkgs.writeShellScriptBin "my-hello" ''
  #   echo "Hello, ${config.home.username}!"
  # '')

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    ".config/nvim" = {
      source = ../../../nvim;
      recursive = true;
    };
    ".config/alacritty" = {
      source = ../../../alacritty;
      recursive = true;
    };

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/fritiofrusck/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    # EDITOR = "emacs";
    TERM = "xterm-256color";
  };

  imports = [ ./fish.nix ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.gh.enable = true;
  programs.lazygit.enable = true;

  programs.git = {
    enable = true;
    ignores = [ ".nvim.lua" "node_modules/" ".envrc" ".direnv" ".DS_Store" ];
  };

  programs.fzf.enable = true;

  programs.neovim = {
    enable = true;
  };

  programs.alacritty = {
    enable = true;
    settings = {
      live_config_reload = true;
      env = {
        TERM = "xterm-256color";
      };
      font = {
        normal = {
          family = "IntelOneMono Nerd Font";
        };
      };
      mouse = {
        hide_when_typing = true;
      };
      import = [
        "~/.config/alacritty/color.yml"
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
      # set-option -g status-right "#[fg=default,bg=default] 2 minutes #[fg=#000000,bg=#dfa000]  7% #[fg=default,bg=default] Tue 15:48 2023-12-12"

    '';
  };
}
