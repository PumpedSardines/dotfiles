#
# Enables the changing of the alacritty theme between light and dark
#
function alacritty-theme --argument theme
  if ! test -f ~/.config/alacritty/color.yml
    echo "file ~/.config/alacritty/color.yml doesn't exist"
    return
  end

  # sed doesn't like symlinks, get the absolute path
  set -l config_path (realpath ~/.config/alacritty/color.yml)
  set -l alacritty_path (realpath ~/.config/alacritty/alacritty.yml)

  if [ $theme = "dark" ]
    echo "" > $config_path
    echo "" >> $alacritty_path
    return
  end

  if [ $theme = "light" ]
    echo "import: [\"~/.config/alacritty/themes/themes/papercolor_light.yaml\"]" > $config_path
    echo "" >> $alacritty_path
    return
  end

  echo "Invalid argument \"$theme\", can be either dark or light"
end 
