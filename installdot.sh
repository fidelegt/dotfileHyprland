#!/bin/bash
set -e

REPO="https://github.com/fidelegt/dotfileHyprland.git"
DIR="$HOME/.dotfiles"

echo "Clonando dotfiles..."

rm -rf "$DIR"
git clone --depth 1 "$REPO" "$DIR"

cd "$DIR"

chmod +x install.sh
./install.sh
