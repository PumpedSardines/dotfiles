{
  description = "Home Manager configuration of fritiofrusck";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    nix-darwin,
    ...
  }: let
    system = "aarch64-darwin";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    darwinConfigurations."Fritiofs-MacBook-Pro" = nix-darwin.lib.darwinSystem {
      system = system;
      modules = [./configuration.nix];
    };
    homeConfigurations."fritiofrusck" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [./home.nix];
      extraSpecialArgs = {
        gdbgui = nixpkgs.legacyPackages.x86_64-darwin.gdbgui;
      };
    };
  };
}
