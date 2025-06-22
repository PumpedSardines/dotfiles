{ nixpkgsUnstable, ... }: {
  home.packages = [
    nixpkgsUnstable.quickshell
  ];
}
