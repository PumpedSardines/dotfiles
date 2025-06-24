{ pkgs, ... }: {
  home.username = "fritiof";
  home.homeDirectory = "/home/fritiof";
  home.stateVersion = "25.05";
  programs.home-manager.enable = true;
  home.packages = with pkgs; [
    httpie
    ripgrep
    cargo
    neofetch
    nodejs
    python3
    lazydocker
    jq
    zoxide
    lsd
    cmake
    aider-chat-full
    go-task
    postgresql
    openssh
    openssl
    git-crypt

    # other packages that i need to use
    samply
    gnupg
    lldb
    git-lfs
    git-secret
    kubernetes-helm
    sshfs
    dtc
  ];
  imports = [
    ./nvim/nvim.nix
    ./tmux/tmux.nix
    ./fish/fish.nix
    ./git/git.nix
    ./lazygit/lazygit.nix
  ];
}
