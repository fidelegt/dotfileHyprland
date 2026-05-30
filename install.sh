#!/bin/bash

set -e

echo "Instalando paquetes..."
sudo pacman -S --needed - <packages/pacman.txt

if command -v paru &>/dev/null; then
  paru -S --needed - <packages/aur.txt
fi

echo "Copiando configuraciones..."

mkdir -p ~/.config

for dir in config/*; do
  if [ -d "$dir" ]; then
    folder=$(basename "$dir")

    echo "→ Instalando $folder"

    mkdir -p ~/.config/"$folder"

    cp -rf "$dir"/* ~/.config/"$folder"/
  fi
done

echo "Instalando scripts..."
mkdir -p ~/.local/bin
chmod +x scripts/*
cp -rf scripts/* ~/.local/bin/

echo "Instalando assets..."
mkdir -p ~/Pictures/Wallpapers/
cp -rf assets/wallpapers/* ~/Pictures/Wallpapers/

mkdir -p ~/.config/assets/
cp -rf assets/resources/* ~/.config/assets/

echo "Instalación completa"
