{
  pkgs,
  ...
}:  {
  home.packages = with pkgs; [
    httpie
    ripgrep
    cargo
    neofetch
  ];
}
