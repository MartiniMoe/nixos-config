#!/bin/sh

pushd ~/dotfiles

./apply-user.sh
./apply-system.sh

popd
