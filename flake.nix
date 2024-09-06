{
  description = "Home Manager configuration of fritiofrusck";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?rev=f8e2ebd66d097614d51a56a755450d4ae1632df1";
    home-manager = {
      url = "github:nix-community/home-manager?rev=5b9156fa9a8b8beba917b8f9adbfd27bf63e16af";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = {
    nixpkgs,
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
