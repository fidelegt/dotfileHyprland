#!/bin/bash

WALLDIR="$HOME/Pictures/Wallpapers"
CACHE="$HOME/.cache/Wallpapers"
CURRENT="$HOME/.cache/current_wallpaper"

mkdir -p "$CACHE"

# Generar lista con iconos
SELECTED=$(for img in "$WALLDIR"/*; do
  filename=$(basename "$img")
  thumb="$CACHE/$filename.png"

  if [ ! -f "$thumb" ]; then
    magick "$img" -resize 300x200 "$thumb"
  fi

  echo -en "$img\0icon\x1f$thumb\n"
done | rofi -dmenu -i -show-icons -p "󰸉 Wallpapers")

[ -z "$SELECTED" ] && exit

# Cambiar wallpaper
swww img "$SELECTED" \
  --transition-type grow \
  --transition-duration 1

#  guardar wallpaper actual
echo "$SELECTED" >"$CURRENT"

# Generar colores automáticamente
wallust run "$SELECTED"

# Recargar apps
~/.local/bin/manager-hyperland-style/colors.sh
