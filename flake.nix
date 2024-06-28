{
  description = "Darwin configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    darwin.url = "github:LnL7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    darwin,
    ...
  }: let
    system = "aarch64-darwin";
    customPackages = import ./packages/pkgs.nix;
    pkgs = nixpkgs.legacyPackages.${system}.extend (_: _: {
      workspace = customPackages.workspace;
      tmux-status-line = customPackages.tmux-status-line;
    });
  in {
    darwinConfigurations = {
      "Fritiofs-MacBook-Pro" = darwin.lib.darwinSystem {
        system = system;
        pkgs = pkgs;
        modules = [
          ./configuration.nix
          home-manager.darwinModules.home-manager
          {
            users.users.fritiofrusck.name = "fritiofrusck";
            users.users.fritiofrusck.home = "/Users/fritiofrusck";
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.fritiofrusck = import ./home-manager/home.nix;
          }
        ];
      };
    };
  };
}
