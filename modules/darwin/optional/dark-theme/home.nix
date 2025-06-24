{ pkgs, lib, ... }: let
  recalculate-dark-theme = pkgs.writeShellScriptBin "recalculate-dark-theme" ''
    #!/bin/bash
    FILE="$HOME/.config/dark-theme"
    DARK_THEME=$(osascript -e 'tell application "System Events" to tell appearance preferences to return dark mode')

    if [ ! -f "$FILE" ]; then
      echo "0" > "$FILE"
    fi

    CURRENT_THEME=$(cat "$FILE")
    if [ "$DARK_THEME" = "true" ] && [ "$CURRENT_THEME" != "1" ]; then
      echo "1" > "$FILE"
      echo "Dark mode enabled"
      # Add your command to enable dark theme here
    elif [ "$DARK_THEME" = "false" ] && [ "$CURRENT_THEME" != "0" ]; then
      echo "0" > "$FILE"
      echo "Dark mode disabled"
      # Add your command to disable dark theme here
    else
      echo "No change in dark mode status"
    fi
  '';
  plistName = "com.fritiof.recalculate-dark-theme.plist";
  plistPath = "Library/LaunchAgents/${plistName}";
  fullPlistPath = "$HOME/${plistPath}";

  plistContent = ''
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN"
     "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
      <key>Label</key>
      <string>com.fritiof.recalculate-dark-theme</string>
      <key>ProgramArguments</key>
      <array>
        <string>${recalculate-dark-theme}/bin/recalculate-dark-theme</string>
      </array>
      <key>StartInterval</key>
      <integer>1</integer>
      <key>RunAtLoad</key>
      <true/>
      <key>StandardOutPath</key>
      <string>/tmp/recalculate-dark-theme.out</string>
      <key>StandardErrorPath</key>
      <string>/tmp/recalculate-dark-theme.err</string>
    </dict>
    </plist>
  '';
in {
  home.packages = [
    recalculate-dark-theme
  ];
  home.file."${plistPath}".text = plistContent;
  home.activation.loadLaunchAgent = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if [ -f "${fullPlistPath}" ]; then
      launchctl unload "${fullPlistPath}" 2>/dev/null || true
      launchctl load "${fullPlistPath}"
    fi
  '';
}
