#!/bin/bash

git add .
git commit -m "Update configuration"

nix run home-manager/master -- switch --flake ~/.config/home-manager
