{
  description = "Home Manager configuration of fritiofrusck";
  inputs = {
    oldNixpkgs.url = "github:nixos/nixpkgs?rev=f8e2ebd66d097614d51a56a755450d4ae1632df1";
    nixpkgs.url = "github:nixos/nixpkgs?rev=5ac14523b6ae564923fb952ca3a0a88f4bfa0322";
    nixpkgsUnstable.url = "github:nixos/nixpkgs?rev=5ac14523b6ae564923fb952ca3a0a88f4bfa0322";
    home-manager = {
      url = "github:nix-community/home-manager?rev=7aae0ee71a17b19708b93b3ed448a1a0952bf111";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = {
    oldNixpkgs,
    nixpkgs,
    nixpkgsUnstable,
    home-manager,
    ...
  }: let
    system = "aarch64-darwin";
    allowed-unfree-packages = ["intelephense-1.10.2"];

    pkgs = import nixpkgs {
      system = system;
      config = {
        allowUnfree = true;
        allowUnfreePredicate = _: true;
      };
    };
  in {
    homeConfigurations."fritiofrusck" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [./home.nix];
      extraSpecialArgs = {
        nixpkgsUnstable = import nixpkgsUnstable {
          system = system;
        };
      };
    };
  };
}
