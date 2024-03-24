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
    tmux-status-line = {
      url = "github:PumpedSardines/tmux-status-line/4d264e5";
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
        workspace = workspace.packages.${system}.default;
        tmux-status-line = tmux-status-line.packages.${system}.default;
        gdbgui = nixpkgs.legacyPackages.x86_64-darwin.gdbgui;
      };
    };
  };
}
