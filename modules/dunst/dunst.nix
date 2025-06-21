{ pkgs, config, ... }: {
  home.packages = with pkgs; [
    libnotify
  ];
  services.dunst = {
    enable = true;
    configFile = config.lib.file.mkOutOfStoreSymlink "/home/fritiof/nixos/modules/dunst/dunstrc";
    # configFile = ./dunstrc;
  };
}
