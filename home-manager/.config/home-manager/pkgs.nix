{ pkgs }: {
  workspace =
    pkgs.callPackage
      (
        pkgs.fetchFromGitHub
          {
            owner = "PumpedSardines";
            repo = "workspace";
            rev = "0c3a495";
            sha256 = "sha256-K1QW5uILSlWVwl6suQw9AlhJLnrkd1QUZfsirIas0LM=";
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
