#!/bin/sh

pushd ~/dotfiles

./apply-system.sh
./apply-user.sh

popd
