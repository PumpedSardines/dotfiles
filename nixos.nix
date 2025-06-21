{ pkgs, ... }: {
  home.packages = with pkgs; [
    pipewire    
    discord
    spotify
    slack
  ];
  imports = [
    ./modules/nvim/nvim.nix
    ./modules/tmux/tmux.nix
    ./modules/git/git.nix
    ./modules/lazygit/lazygit.nix
    ./modules/wezterm/wezterm.nix
    ./modules/misc/misc.nix

    # NixOS specific
    ./modules/hypr/hypr.nix
    ./modules/nautilus/nautilus.nix
    ./modules/electron-flags/electron-flags.nix
    ./modules/dunst/dunst.nix
    ./modules/waybar/waybar.nix
    ./modules/rofi/rofi.nix
  ];
}
