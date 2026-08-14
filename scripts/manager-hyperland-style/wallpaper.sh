#!/bin/bash

WALLDIR="$HOME/Pictures/Wallpapers"
CACHE="$HOME/.cache/Wallpapers"
CURRENT="$HOME/.cache/current_wallpaper"

mkdir -p "$CACHE"

# Generar lista con iconos mejorada
SELECTED=$(for img in "$WALLDIR"/*; do
  [ -f "$img" ] || continue

  filename=$(basename "$img")
  thumb="$CACHE/${filename}.png"

  # Crear thumbnail más grande si no existe
  if [ ! -f "$thumb" ]; then
    magick "$img" -resize 400x300 -gravity center -extent 400x300 "$thumb"
  fi

  # Mostrar solo el nombre del archivo + icono
  echo -en "$filename\0icon\x1f$thumb\n"
done | rofi -dmenu \
  -i \
  -show-icons \
  -p "󰸉 Selecciona Wallpaper" \
  -theme-str 'listview { columns: 3; }' \
  -theme-str 'element { padding: 8px; }' \
  -theme-str 'element-icon { size: 120px; }' \
  -width 80 \
  -lines 6)

[ -z "$SELECTED" ] && exit

# Reconstruir la ruta completa a partir del nombre
SELECTED="$WALLDIR/$SELECTED"

# Cambiar wallpaper
swww img "$SELECTED" \
  --transition-type grow \
  --transition-duration 1 \
  --transition-fps 60

# Guardar wallpaper actual
echo "$SELECTED" >"$CURRENT"

# Generar colores
wallust run "$SELECTED"

# Recargar apps
~/.local/bin/manager-hyperland-style/colors.sh
