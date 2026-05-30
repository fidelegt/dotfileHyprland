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

echo "Instalando swww desde source..."

mkdir -p ~/Downloads/swww
rm -rf ~/Downloads/swww/*
cd ~/Downloads/swww

git clone --depth 1 https://github.com/LGFae/swww.git
cd swww

cargo build --release

sudo install -Dm755 target/release/swww /usr/local/bin/swww
sudo install -Dm755 target/release/swww-daemon /usr/local/bin/swww-daemon

cd ~
rm -rf ~/Downloads/swww

echo "Instalación completa"
echo "Reinicia sesión para aplicar Zsh como shell por defecto."
