{ pkgs, ... }: {
  home.packages = with pkgs; [
    blueman
    pipewire    

    brightnessctl
    playerctl
    wl-clipboard
  ];
}
