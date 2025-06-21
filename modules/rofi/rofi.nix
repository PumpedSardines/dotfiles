{config, pkgs, ...}: {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    configPath = "/home/fritiof/.config/rofi/config.rasi";
    theme = "/home/fritiof/nixos/modules/rofi/config/style.rasi";
  };
}
