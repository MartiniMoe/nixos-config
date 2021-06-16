#!/bin/sh

pushd ~/dotfiles

sudo nix-channel --update
./apply-system.sh
ls -1v /nix/var/nix/profiles | tail -n 2 | awk '{print "/nix/var/nix/profiles/" $0}' - | xargs nvd diff

popd
