#
# Changes the theme for the terminal and then executes a command in vim to change theme as well
#
function colortheme --argument theme

  alacritty-theme $theme

  for six in (/opt/homebrew/bin/tmux list-sessions -F '#{session_name}')
    for wix in (/opt/homebrew/bin/tmux list-windows -t $six -F "$six:#{window_index}")
      for pix in (/opt/homebrew/bin/tmux list-panes -F "$six:#{window_index}.#{pane_index}" -t $wix)
        set -l is_vim "ps -o state= -o comm= -t '#{pane_tty}'  | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?\$'"
        /opt/homebrew/bin/tmux if-shell -t "$pix" "$is_vim" "send-keys -t $pix escape ENTER"
        /opt/homebrew/bin/tmux if-shell -t "$pix" "$is_vim" "send-keys -t $pix ':lua run_theme_calculation()' ENTER"
      end
    end
  end

end
