{
  programs.fish = {
    enable = true;
    shellInit = ''
      set fish_greeting
      set -x VIRTUAL_ENV_DISABLE_PROMPT 1

      alias ls="lsd"
      zoxide init --cmd cd fish | source
    '';
    fish_prompt = {
      description = "Custom fish prompt";
      body = "printf '%s%s%s > ' (set_color $fish_color_cwd) (prompt_pwd) (set_color normal)";
    };
  };
}
