{
  home.username = "fritiofrusck";
  home.homeDirectory = "/Users/fritiofrusck";

  imports = [
    ../../modules/home/core/home-manager/home.nix    
    ../../modules/home/core/zsh/home.nix
    ../../modules/home/core/fish/home.nix
    ../../modules/home/core/git/home.nix
    ../../modules/home/core/lazygit/home.nix
    ../../modules/home/core/nvim/home.nix
    ../../modules/home/core/tmux/home.nix
    ../../modules/home/core/wezterm/home.nix
    ../../modules/home/core/direnv/home.nix
    ../../modules/home/core/fzf/home.nix
    ../../modules/home/core/tools/home.nix
  ];
}
