{
  description = "Darwin configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?rev=f8e2ebd66d097614d51a56a755450d4ae1632df1";
    nixpkgs-unstable.url = "github:nixos/nixpkgs?rev=b833ff01a0d694b910daca6e2ff4a3f26dee478c";
    darwin.url = "github:LnL7/nix-darwin?ref=50581970f37f06a4719001735828519925ef8310";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager?rev=5b9156fa9a8b8beba917b8f9adbfd27bf63e16af";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = {
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    darwin,
    ...
  }: let
    system = "aarch64-darwin";
    pkgs = nixpkgs.legacyPackages.${system};
    pkgsUnstable = nixpkgs-unstable.legacyPackages.${system};
  in {
    darwinConfigurations = {
      "Fritiofs-MacBook-Pro" = darwin.lib.darwinSystem {
        system = system;
        pkgs = import nixpkgs {system = "aarch64-darwin";};
        modules = [
          ./configuration.nix
          home-manager.darwinModules.home-manager
          {
            users.users.fritiofrusck.name = "fritiofrusck";
            users.users.fritiofrusck.home = "/Users/fritiofrusck";
            home-manager.extraSpecialArgs = {inherit pkgsUnstable;};
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.fritiofrusck.imports = [./home.nix];
          }
        ];
      };
    };
  };
}
