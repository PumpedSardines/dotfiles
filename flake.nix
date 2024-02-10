{
  description = "Home Manager configuration of fritiofrusck";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    workspace = {
      url = "github:PumpedSardines/workspace";
    };
  };

  outputs = {
    nixpkgs,
    workspace,
    home-manager,
    ...
  }: let
    system = "aarch64-darwin";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    homeConfigurations."fritiofrusck" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [./home.nix];
    };
  };
}
