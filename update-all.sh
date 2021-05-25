#!/bin/sh

sudo nix-channel --update
nix-channel --update
./apply-all.sh
