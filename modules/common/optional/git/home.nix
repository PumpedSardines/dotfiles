{ pkgs, ... }: {
  home.packages = with pkgs; [
    git-crypt
    git-lfs
    git-secret
  ];
  programs.git = {
    enable = true;
    ignores = [".fritiof.lua" "node_modules/" ".envrc" ".direnv" ".DS_Store"];
    extraConfig = {
      commit.gpgsign = true;
      gpg.program = "gpg";
    };
  };
}
