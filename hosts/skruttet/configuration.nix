{ config, pkgs, ... }:
{
  imports = [./hardware-configuration.nix ./nvidia.nix];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";
  hardware.bluetooth.enable = true;

  networking.networkmanager.enable = true;
  time.timeZone = "Europe/Stockholm";
  i18n.defaultLocale = "en_US.UTF-8";

  services.tlp = {
    enable = true;
  };

  nix.settings.auto-optimise-store = true;
  nix.gc.automatic = true;
  nix.gc.dates = "daily";
  nix.gc.options = "--delete-older-than +20";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "sv_SE.UTF-8";
    LC_IDENTIFICATION = "sv_SE.UTF-8";
    LC_MEASUREMENT = "sv_SE.UTF-8";
    LC_MONETARY = "sv_SE.UTF-8";
    LC_NAME = "sv_SE.UTF-8";
    LC_NUMERIC = "sv_SE.UTF-8";
    LC_PAPER = "sv_SE.UTF-8";
    LC_TELEPHONE = "sv_SE.UTF-8";
    LC_TIME = "sv_SE.UTF-8";
  };

  users.users.fritiof = {
    isNormalUser = true;
    description = "Fritiof";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # services.xserver.enable = true;
  services.xserver.xkb.extraLayouts.custom = {
    description = "US layout with ao on AltGr+[";
    languages = ["eng"];
    symbolsFile = ./us-custom.xkb;
  };

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.droid-sans-mono
  ];

  programs.hyprland.enable = true;
  programs.steam.enable = true;

  environment.variables = {
    NIXOS_OZONE_WL = "1";
  };

  system.stateVersion = "25.05";
}
