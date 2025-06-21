{ config, ... }: {
  programs.waybar.enable = true;
  home.file = {
    ".config/waybar" = {
      source = config.lib.file.mkOutOfStoreSymlink /etc/nixos/modules/waybar/config;
      recursive = true;
    };
  };
}
