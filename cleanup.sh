#!/bin/sh

nix-store --optimise
nix-store --gc
nix-env -p /nix/var/nix/profiles/system --delete-generations +2
