#!/bin/bash

# ---------- KITTY ----------
# Recarga config (persistente)
killall -SIGUSR1 kitty 2>/dev/null

# ---------- HYPRLAND ----------
hyprctl reload

# ---------- WAYBAR ----------
pkill -x waybar 2>/dev/null

# Esperar a que muera de verdad
while pgrep -x waybar >/dev/null; do
  sleep 0.1
done

# Lanzar limpio
nohup waybar >/dev/null 2>&1 &

# ---------- NVIM (opcional) ----------
# Recarga en instancias abiertas (si usas server)
if command -v nvim >/dev/null; then
  nvim --server /tmp/nvim* --remote-send "<cmd>source ~/.cache/wallust/nvim.lua<CR>" 2>/dev/null
fi

# ---------- NOTIFICACIÓN ----------
notify-send "Tema actualizado" "Colores aplicados correctamente"
