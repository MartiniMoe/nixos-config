#!/bin/sh

pushd ~/dotfiles

sudo nix-channel --update
nix-channel --update
./apply-all.sh

popd
