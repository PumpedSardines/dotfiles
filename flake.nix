{
  description = "Home Manager configuration of fritiofrusck";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?rev=f8e2ebd66d097614d51a56a755450d4ae1632df1";
    nixpkgsUnstable.url = "github:nixos/nixpkgs?rev=43001f1cdf2f9fbb8c15a1d95d1392a3f581f276";
    nixpkgsHaskell = {
      url = "github:nixoS/nixpkgs?ref=8b27c1239e5c421a2bbc2c65d52e4a6fbf2ff296";
    };
    home-manager = {
      url = "github:nix-community/home-manager?rev=5b9156fa9a8b8beba917b8f9adbfd27bf63e16af";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = {
    nixpkgs,
    nixpkgsUnstable,
    nixpkgsHaskell,
    home-manager,
    ...
  }: let
    system = "aarch64-darwin";
    allowed-unfree-packages = ["intelephense-1.10.2"];
    pkgsHaskell = import nixpkgsHaskell {
      system = system;
    };

    pkgs = import nixpkgs {
      system = system;
      config = {
        allowUnfree = true;
        allowUnfreePredicate = _: true;
      };
      overlays = [
        (final: prev: {
          # Haskell development tools from nixpkgsHaskell
          inherit
            (pkgsHaskell)
            ghc
            haskell-language-server
            stack
            ormolu
            cabal-install
            ;
        })
      ];
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
