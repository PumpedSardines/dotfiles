{
  programs.tmux = {
    enable = true;
    escapeTime = 0;
    mouse = true;
    keyMode = "vi";
    baseIndex = 1;
    extraConfig = ''
      set-option -sa terminal-overrides ',xterm-256color:RGB'
      set -g default-terminal "tmux-256color"

      bind k select-pane -U
      bind j select-pane -D
      bind h select-pane -L
      bind l select-pane -R

      bind-key -T copy-mode-vi y send -X copy-selection-and-cancel
      bind-key -T copy-mode-vi v send -X begin-selection
      bind-key -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel

      bind s choose-tree -sZ -O name

      set-option -sg escape-time 10

      set-option -g focus-events on

      set-option -g status on
      set-option -g status-interval 2
      set-option -g status-left-length 60
      set-option -g status-right-length 200

      set -g status-bg black
      set -g status-fg white

      set -g mode-style bg=green,fg=#000000
      set-option -g status-right "#(tmux_status_line)"
    '';
  };
}
