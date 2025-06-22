{ config, quickshell, ... }: {
  home.packages = [
    quickshell
  ];
  home.file = {
    ".config/quickshell" = {
      source = config.lib.file.mkOutOfStoreSymlink /home/fritiof/nixos/modules/quickshell/config;
      # source = ./config;
      recursive = true;
    };
  };
}
