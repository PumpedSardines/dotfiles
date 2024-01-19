{ pkgs }: {
  workspace =
    pkgs.callPackage
      (
        pkgs.fetchFromGitHub
          {
            owner = "PumpedSardines";
            repo = "workspace";
            rev = "0e28d95";
            sha256 = "sha256-F0qJIqfXJieaKAeveRF4u2cb9mcgLVts9K2OXqWYlro=";
          }
      )
      { };

  tmux-status-line =
    pkgs.callPackage
      (
        pkgs.fetchFromGitHub
          {
            owner = "PumpedSardines";
            repo = "tmux-status-line";
            rev = "63cdb25";
            sha256 = "sha256-yOVcpZh47IKROKqpatsY3+TfkWXm1drJl1iuXqaVVAk=";
          }
      )
      { };
}
