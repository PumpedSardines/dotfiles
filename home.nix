{
  home.username = "fritiof";
  home.homeDirectory = "/home/fritiof";
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;

  imports = [
    ./nixos.nix
  ];
}
