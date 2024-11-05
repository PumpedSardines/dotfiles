#!/bin/bash

git add .
nix run home-manager/master -- switch --flake ~/.config/home-manager
