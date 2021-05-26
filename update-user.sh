#!/bin/sh

pushd ~/dotfiles

nix-channel --update
./apply-user.sh

popd
