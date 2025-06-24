{
  programs.fish = {
    enable = true;
    shellInit = ''
      set fish_greeting
      set -x VIRTUAL_ENV_DISABLE_PROMPT 1

      alias ls="lsd"
      zoxide init --cmd cd fish | source
    '';
  };
}
