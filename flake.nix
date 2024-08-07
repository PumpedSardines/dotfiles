{
  description = "Darwin configuration";
  inputs = {
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    nixpkgs.url = "github:nixos/nixpkgs?rev=f8e2ebd66d097614d51a56a755450d4ae1632df1";
    darwin.url = "github:LnL7/nix-darwin?ref=50581970f37f06a4719001735828519925ef8310";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager?rev=5b9156fa9a8b8beba917b8f9adbfd27bf63e16af";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = {
    nixpkgs,
    home-manager,
    nix-homebrew,
    homebrew-core,
    homebrew-cask,
    darwin,
    ...
  }: let
    system = "aarch64-darwin";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    darwinConfigurations = {
      "Fritiofs-MacBook-Pro" = darwin.lib.darwinSystem {
        system = system;
        pkgs = import nixpkgs {system = "aarch64-darwin";};
        modules = [
          ./configuration.nix
          home-manager.darwinModules.home-manager
          nix-homebrew.darwinModules.nix-homebrew
          {
            users.users.fritiofrusck.name = "fritiofrusck";
            users.users.fritiofrusck.home = "/Users/fritiofrusck";
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.fritiofrusck.imports = [./home.nix];
            # home-manager.users.fritiofrusck = import ./home.nix;

            # Optionally, use home-manager.extraSpecialArgs to pass
            # arguments to home.nix
            nix-homebrew = {
              # Install Homebrew under the default prefix
              enable = true;

              # Apple Silicon Only: Also install Homebrew under the default Intel prefix for Rosetta 2
              enableRosetta = true;

              # User owning the Homebrew prefix
              user = "fritiofrusck";

              # Optional: Declarative tap management
              taps = {
                "homebrew/homebrew-core" = homebrew-core;
                "homebrew/homebrew-cask" = homebrew-cask;
              };

              # Optional: Enable fully-declarative tap management
              #
              # With mutableTaps disabled, taps can no longer be added imperatively with `brew tap`.
              mutableTaps = false;
            };
          }
        ];
      };
    };
  };
}
