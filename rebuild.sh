GENERATION=$(sudo nix-env -p /nix/var/nix/profiles/system --list-generations | tail -n1 | awk '{print $1}')
NEW_GENERATION=$(($GENERATION + 1))
git add .
git commit -m "Generation #$NEW_GENERATION"
sudo nixos-rebuild switch --flake .#fritiof-old-dell
