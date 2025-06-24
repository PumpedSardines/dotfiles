{ config, ... }: {
  programs.waybar.enable = true;
  home.file = {
    ".config/waybar" = {
      source = config.lib.file.mkOutOfStoreSymlink /home/fritiof/nixos/modules/waybar/config;
      # source = ./config;
      recursive = true;
    };
  };
}
