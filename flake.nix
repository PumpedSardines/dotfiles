{
  description = "Home Manager configuration of fritiofrusck";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?rev=f8e2ebd66d097614d51a56a755450d4ae1632df1";
    dtekv-emulator.url = "github:PumpedSardines/dtekv-emulator?rev=b04c68586a97c666a702fcfd4e7b0b49ff25c19e";
    home-manager = {
      url = "github:nix-community/home-manager?rev=5b9156fa9a8b8beba917b8f9adbfd27bf63e16af";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = {
    nixpkgs,
    dtekv-emulator,
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
        inherit dtekv-emulator;
      };
    };
  };
}
