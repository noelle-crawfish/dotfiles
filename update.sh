#!/bin/sh

# update flake.lock
# nix flake update

# apply the updates
#  sudo nixos-rebuild switch --flake .

# one cmd for both
sudo nixos-rebuild switch --flake .
