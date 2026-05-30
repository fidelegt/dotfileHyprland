#!/bin/bash

export PATH=/usr/local/bin:/usr/bin:/bin
DEFAULT="$HOME/.config/assets/backgrounds/forky.jpg"

while true; do
  playerctl -F metadata mpris:artUrl 2>/dev/null | while read -r url; do
    if [ -n "$url" ]; then
      curl -sL "$url" -o /tmp/hyprlock-art.png
    else
      cp "$DEFAULT" /tmp/hyprlock-art.png
    fi
    pkill -SIGUSR2 hyprlock
  done
  sleep 1
done
