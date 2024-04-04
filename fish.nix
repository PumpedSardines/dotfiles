{
  config,
  pkgs,
  ...
}: {
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

      alias ws="workspace"
      zoxide init --cmd c fish | source
    '';
    functions = {
      alacritty-theme = {
        description = "Set the alacritty theme";
        argumentNames = ["theme"];
        body = ''
          # sed doesn't like symlinks, get the absolute path
          set -l light_path (realpath ~/.config/alacritty/light.toml)
          set -l dark_path (realpath ~/.config/alacritty/dark.toml)
          set -l color_path ~/.config/alacritty/color.toml

          if [ $theme = "dark" ]
            echo "$(cat $dark_path)" > $color_path
            return
          end

          if [ $theme = "light" ]
            echo "$(cat $light_path)" > $color_path
            return
          end

          echo "Invalid argument \"$theme\", can be either dark or light"
        '';
      };
      theme = {
        description = "Set the color theme";
        argumentNames = ["theme"];
        body = ''
          alacritty-theme $theme
        '';
      };
      new_flake = {
        description = "Create a new flake";
        body = ''

        '';
      };
      battery_percentage = {
        description = "Get the battery percentage";
        body = ''
          pmset -g batt | grep -Eo "\d+%" | cut -d% -f1
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
