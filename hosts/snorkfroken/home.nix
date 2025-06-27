{
  home.username = "fritiofrusck";
  home.homeDirectory = "/Users/fritiofrusck";

  imports = [
    ../../modules/common/core/home-manager/home.nix    
    ../../modules/common/optional/fish/home.nix
    ../../modules/common/optional/git/home.nix
    ../../modules/common/optional/lazygit/home.nix
    ../../modules/common/optional/nvim/home.nix
    ../../modules/common/optional/tmux/home.nix
    ../../modules/common/optional/wezterm/home.nix
    ../../modules/common/optional/direnv/home.nix
    ../../modules/common/optional/fzf/home.nix
    ../../modules/common/optional/tools/home.nix
    ../../modules/common/optional/secrets/home.nix

    ../../modules/common/optional/workspace/home.nix
    ../../modules/common/optional/tmux-status-line/home.nix

    ../../modules/darwin/optional/dark-theme/home.nix
  ];
}
