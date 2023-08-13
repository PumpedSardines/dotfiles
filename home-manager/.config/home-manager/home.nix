{ config
, pkgs
, ...
}: {
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
  home.stateVersion = "23.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.

  home.packages = with pkgs; [
    # The main programs
    httpie

    # programs
    nodejs_20
    ripgrep

    # tools
    stow

    # Random nvim things
    nodePackages.prettier_d_slim
    nodePackages.eslint_d
    alejandra
  ];
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
  };

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
    ignores = [ ".envrc" ".direnv" ".DS_Store" ];
  };

  programs.fzf.enable = true;

  programs.neovim = {
    enable = true;
  };

  # imports = [./nvim.nix];

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

      # set-option -g status-right "#(~/.config/tmux/statusline/target/release/statusline)"
    '';
  };

  programs.fish = {
    enable = true;
    plugins = [
      # Need this when using Fish as a default macOS shell in order to pick
      # up ~/.nix-profile/bin
      {
        name = "nix-env";
        src = pkgs.fetchFromGitHub {
          owner = "lilyball";
          repo = "nix-env.fish";
          rev = "00c6cc762427efe08ac0bd0d1b1d12048d3ca727";
          sha256 = "1hrl22dd0aaszdanhvddvqz3aq40jp9zi2zn0v1hjnf7fx4bgpma";
        };
      }
    ];
    shellInit = ''
      # Disable fish greeting
      set fish_greeting
      # Disable 'activate.fish' auto setting and displaying fish status
      set -x VIRTUAL_ENV_DISABLE_PROMPT 1
    '';
    functions = {
      alacritty-theme = {
        description = "Set the alacritty theme";
        argumentNames = [ "theme" ];
        body = ''
          if ! test -f ~/.config/alacritty/color.yml
            echo "file ~/.config/alacritty/color.yml doesn't exist"
            return
          end

          # sed doesn't like symlinks, get the absolute path
          set -l config_path (realpath ~/.config/alacritty/color.yml)
          set -l alacritty_path (realpath ~/.config/alacritty/alacritty.yml)

          if [ $theme = "dark" ]
            echo "" > $config_path
            return
          end

          if [ $theme = "light" ]
            echo "import: [\"~/.config/alacritty/themes/themes/papercolor_light.yaml\"]" > $config_path
            return
          end

          echo "Invalid argument \"$theme\", can be either dark or light"
        '';
      };
      colortheme = {
        description = "Set the color theme (DONT WORK ATM)";
        argumentNames = [ "theme" ];
        body = ''
          alacritty-theme $theme

          for six in (~/.nix-profile/bin/tmux list-sessions -F '#{session_name}')
            for wix in (~/.nix-profile/bin/tmux list-windows -t $six -F "$six:#{window_index}")
              for pix in (~/.nix-profile/bin/tmux list-panes -F "$six:#{window_index}.#{pane_index}" -t $wix)
                set -l is_vim "ps -o state= -o comm= -t '#{pane_tty}'  | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?\$'"
                ~/.nix-profile/bin/tmux if-shell -t "$pix" "$is_vim" "send-keys -t $pix escape ENTER"
                ~/.nix-profile/bin/tmux if-shell -t "$pix" "$is_vim" "send-keys -t $pix ':lua run_theme_calculation()' ENTER"
              end
            end
          end
        '';
      };
      fish_prompt = {
        description = "Custom fish prompt";
        body = "printf '%s%s%s > ' (set_color $fish_color_cwd) (prompt_pwd) (set_color normal)";
      };
      __direnv_export_eval = {
        description = "Hook function that fix direnv print";
        onEvent = "fish_prompt";
        body = ''
          begin;
              begin;
                  "direnv" export fish
              end 1>| source
          end 2>| egrep -v -e "^direnv: export"
        '';
      };
    };
  };
}
