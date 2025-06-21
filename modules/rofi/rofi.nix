{config, pkgs, ...}: {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    configPath = "/home/fritiof/.config/rofi/config.rasi";
    theme = "/etc/nixos/modules/rofi/config/style.rasi";
  };
}
