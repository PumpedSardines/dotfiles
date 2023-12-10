{ pkgs }: {
  workspace =
    pkgs.callPackage
      (
        pkgs.fetchFromGitHub
          {
            owner = "PumpedSardines";
            repo = "workspace";
            rev = "87819ac";
            sha256 = "sha256-vabtJG+AXkVY4O29PFJdsil3wWlc8vjlVicnSYuY+NI=";
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
