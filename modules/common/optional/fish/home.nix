{
  programs.fish = {
    enable = true;
    shellInit = ''
      set fish_greeting
      set -x VIRTUAL_ENV_DISABLE_PROMPT 1

      alias ls="lsd"
      zoxide init --cmd cd fish | source
    '';
    functions = {
      fish_prompt = {
        description = "Custom fish prompt";
        body = "printf '%s%s%s > ' (set_color $fish_color_cwd) (prompt_pwd) (set_color normal)";
      };
      wezterm-theme = {
        description = "Set the wezterm theme";
        argumentNames = ["theme"];
        body = ''
          set -l theme_path ~/.config/wezterm/theme.lua

          if [ $theme = "dark" ]
            echo "return \"Everforest Dark\"" > $theme_path
            return
          end

          if [ $theme = "light" ]
            echo "return \"Everforest Light\"" > $theme_path
            return
          end

          echo "Invalid argument \"$theme\", can be either dark or light"
        '';
      };
    };
  };
}
