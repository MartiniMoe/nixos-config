#!/bin/sh

pushd ~/dotfiles

sudo nix-channel --update
./apply-system.sh

popd
