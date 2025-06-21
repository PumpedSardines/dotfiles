# This file is made with the help of the following resources:
#
# https://gist.github.com/nat-418/d76586da7a5d113ab90578ed56069509
# https://github.com/LongerHV/nixos-configuration/blob
{
  pkgs,
  ...
}:  {
  home.packages = with pkgs; [
    httpie
    pipewire    
    discord
    spotify
  ];
}
