#!/bin/bash

set -e

echo "Instalando paquetes..."

sudo pacman -S --needed --noconfirm \
  $(grep -vE '^\s*#|^\s*$' packages/pacman.txt)

if command -v paru &>/dev/null; then
  paru -S --needed --noconfirm \
    $(grep -vE '^\s*#|^\s*$' packages/aur.txt)
fi

echo "Configurando Zsh..."

# Cambiar shell por defecto
if [ "$SHELL" != "$(which zsh)" ]; then
  chsh -s "$(which zsh)"
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

echo "Configurando Kitty para usar Zsh..."

mkdir -p ~/.config/kitty

if ! grep -q "^shell " ~/.config/kitty/kitty.conf 2>/dev/null; then
  echo "shell $(which zsh)" >>~/.config/kitty/kitty.conf
fi

echo "Instalando scripts..."
mkdir -p ~/.local/bin
chmod +x scripts/*
cp -rf scripts/* ~/.local/bin/

echo "Instalando wallpapers..."
mkdir -p ~/Pictures/Wallpapers/
cp -rf assets/wallpapers/* ~/Pictures/Wallpapers/

echo "Instalando recursos..."
mkdir -p ~/.config/assets/
cp -rf assets/resources/* ~/.config/assets/

echo "Instalando swww..."

mkdir -p ~/.cache/swww
cd ~/.cache/swww

LATEST=$(curl -s https://api.github.com/repos/LGFae/swww/releases/latest)

TAG=$(echo "$LATEST" | grep '"tag_name"' | cut -d '"' -f4)

ASSET=$(echo "$LATEST" | grep browser_download_url | grep linux | grep x86_64 | grep tar.gz | cut -d '"' -f4 | head -n 1)

if [ -z "$ASSET" ]; then
  echo "No se pudo encontrar el binario de swww"
  exit 1
fi

curl -L -o swww.tar.gz "$ASSET"

tar -xzf swww.tar.gz

sudo find . -type f -name "swww*" -exec install -Dm755 {} /usr/local/bin/ \;

rm -rf ~/.cache/swww/*
cd - >/dev/null

echo "Instalación completa"
echo "Reinicia sesión para aplicar Zsh como shell por defecto."
