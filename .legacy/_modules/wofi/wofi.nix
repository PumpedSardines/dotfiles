{config, ...}: {
  programs.wofi = {
    enable = true;
  };
  home.file = {
    ".config/wofi" = {
      source = config.lib.file.mkOutOfStoreSymlink /etc/nixos/modules/wofi/config;
      # source = ./config;
      recursive = true;
    };
  };
}
