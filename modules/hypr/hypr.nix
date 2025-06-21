{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs; [
    hyprpaper
  ];
  home.file = {
    ".config/hypr" = {
      source = config.lib.file.mkOutOfStoreSymlink ./modules/hypr/config;
      # source = ./config;
      recursive = true;
    };
  };
}
