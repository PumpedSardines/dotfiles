{
  description = "Home Manager configuration of fritiofrusck";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    workspace = {
      url = "github:PumpedSardines/workspace/6052219";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    workspace,
    ...
  }: let
    system = "aarch64-darwin";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    homeConfigurations."fritiofrusck" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [./home.nix];
      extraSpecialArgs = {
        workspace = workspace.packages.${system}.default;
        gdbgui = nixpkgs.legacyPackages.x86_64-darwin.gdbgui;
      };
    };
  };
}
