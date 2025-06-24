{ pkgs, ... }: {
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
}
