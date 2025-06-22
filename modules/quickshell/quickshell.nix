{ pkgs, pkgsUnstable, ... }: {
  home.packages = [
    pkgsUnstable.quickshell
  ];
}
