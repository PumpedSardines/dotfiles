function workspace --argument workspace_name

  switch $workspace_name
    case arkivet-storefront
      if test -m $TERM 
        tmux new -s arkivet-storefront -c ~/Code/5Monkeys/arkivet/storefront -d
      else 
        tmux new -s arkivet-storefront -c ~/Code/5Monkeys/arkivet/storefront
      end
    case webshipper-widget
      if test -n $TERM 
        tmux new -s webshipper-widget -c ~/Code/5Monkeys/webshipper-widget -d
      else 
        tmux new -s webshipper-widget -c ~/Code/5Monkeys/webshipper-widget
      end
    case '*'
      echo 'Workspace not found'
  end

end
