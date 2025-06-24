{
  pkgs,
  config,
  ...
}: {
  home.file = {
    ".config/electron-flags.conf" = {
      source = config.lib.file.mkOutOfStoreSymlink /etc/nixos/modules/electron-flags/electron-flags.conf;
    };
    ".config/chrome-flags.conf" = {
      source = config.lib.file.mkOutOfStoreSymlink /etc/nixos/modules/electron-flags/electron-flags.conf;
    };
  };
}
