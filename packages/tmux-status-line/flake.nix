{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    nixpkgsUnstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flakeUtils.url = "github:numtide/flake-utils";
  };
  outputs = {
    self,
    nixpkgs,
    nixpkgsUnstable,
    flakeUtils,
  }:
    flakeUtils.lib.eachDefaultSystem (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
        pkgsUnstable = nixpkgsUnstable.legacyPackages.${system};
        pkgsFor = nixpkgs.legacyPackages;
        manifest = (pkgs.lib.importTOML ./Cargo.toml).package;
        frameworks = pkgs.darwin.apple_sdk.frameworks;
      in {
        packages.default = pkgs.rustPlatform.buildRustPackage rec {
          pname = manifest.name;
          version = manifest.version;
          buildInputs = [
            frameworks.Security
            frameworks.CoreFoundation
            frameworks.CoreServices
            frameworks.ApplicationServices
            frameworks.SystemConfiguration
            frameworks.CoreVideo
            frameworks.AppKit
          ];
          cargoLock.lockFile = ./Cargo.lock;
          src = pkgs.lib.cleanSource ./.;
        };
      }
    );
}
