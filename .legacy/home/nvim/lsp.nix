# All packages for LSP
{ pkgs }: let
  javaScript = with pkgs; [
      deno
      prettierd # JavaScript formatter
      nodePackages.eslint_d # JavaScript linter
      nodePackages.pnpm
      nodePackages.typescript-language-server
      vscode-langservers-extracted # html, css, json, eslint
      nodePackages."@astrojs/language-server"
      nest-cli
  ];
  lua = with pkgs; [
    stylua
    lua-language-server
  ];
  nix = with pkgs; [
    alejandra
    nixd
  ];
  zig = with pkgs; [
    zig
    zls
  ];
  go = with pkgs; [
    gopls
    go
  ];
  java = with pkgs; [
    jdk21
  ];
  gleam = with pkgs; [
    gleam
    erlang
  ];
  rust = with pkgs; [
    rustfmt
    rust-analyzer
  ];
  php = with pkgs; [
    php
    php83Packages.php-cs-fixer
    php83Packages.composer
    nodePackages_latest.intelephense
  ];
in
  javaScript ++ lua ++ nix ++ zig ++ go ++ java ++ gleam ++ rust ++ php
