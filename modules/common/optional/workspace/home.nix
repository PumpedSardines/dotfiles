{
  pkgs,
  ...
}: let
  # Bash scripts to handle workspaces, this bash script handles searching and opening a workspace in tmux
  wss = pkgs.writeShellScriptBin "wss" ''
    #!/bin/bash
    workspace

    if [ $? -eq 1 ]; then
      exit 1
    fi

    if [[ ! "$TERM_PROGRAM" = tmux ]]; then
      tmux -u a
    fi
  '';
  wse = pkgs.writeShellScriptBin "wse" ''
    nvim $(workspace config)
  '';
  workspace = let
    repo = pkgs.lib.cleanSource ./packages/workspace;
    manifest = (builtins.fromTOML (builtins.readFile "${repo}/Cargo.toml")).package;
  in
    pkgs.rustPlatform.buildRustPackage {
      pname = manifest.name;
      version = manifest.version;
      cargoLock.lockFile = "${repo}/Cargo.lock";
      src = repo;
    };
in {
  home.packages = [
    wss
    wse
    workspace
  ];
}
