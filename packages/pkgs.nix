{
  config,
  pkgs,
  ...
}: let
  tmux-status-line = let
    repo = pkgs.lib.cleanSource ../packages/tmux-status-line;
    frameworks = pkgs.darwin.apple_sdk.frameworks;
    manifest = (builtins.fromTOML (builtins.readFile "${repo}/Cargo.toml")).package;
  in
    pkgs.rustPlatform.buildRustPackage {
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
      cargoLock.lockFile = "${repo}/Cargo.lock";
      src = repo;
    };
  workspace = let
    repo = pkgs.lib.cleanSource ../packages/workspace;
    manifest = (builtins.fromTOML (builtins.readFile "${repo}/Cargo.toml")).package;
  in
    pkgs.rustPlatform.buildRustPackage {
      pname = manifest.name;
      version = manifest.version;
      cargoLock.lockFile = "${repo}/Cargo.lock";
      src = repo;
    };
in {
  tmux-status-line = tmux-status-line;
  workspace = workspace;
}
