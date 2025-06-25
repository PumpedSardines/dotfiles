{ pkgs, ... }: let
  tmux-status-line = let
    repo = pkgs.lib.cleanSource ./.;
    manifest = (builtins.fromTOML (builtins.readFile "${repo}/Cargo.toml")).package;
  in
    pkgs.rustPlatform.buildRustPackage {
      pname = manifest.name;
      version = manifest.version;
      buildInputs = [];
      cargoLock.lockFile = "${repo}/Cargo.lock";
      src = repo;
    };
in {
  home.packages = [
    tmux-status-line
  ];
}
