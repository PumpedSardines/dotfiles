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
    tmux-status-line = {
      url = "github:PumpedSardines/tmux-status-line";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    workspace,
    tmux-status-line,
    ...
  }: let
    system = "aarch64-darwin";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    homeConfigurations."fritiofrusck" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [./home.nix];
      extraSpecialArgs = {
        workspace = workspace.packages.aarch64-darwin.default;
        tmux-status-line = tmux-status-line.packages.aarch64-darwin.default;
      };
    };
  };
}
