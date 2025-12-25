#!/bin/sh -xeu
set +x

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/color.sh"

TIME="$(date '+%H:%M:%S')"

HOUR24="$(date '+%H')"
HOUR24=$((10#$HOUR24)) # Convert to decimal to avoid issues with leading zeros

if [ "$HOUR24" -ge 13 ]; then
  HOUR12="$((HOUR24 - 12))"
else
  HOUR12="$HOUR24"
fi

ICON=""
case "$HOUR12" in
  0) ICON="󱑖" ;;
  1) ICON="󱑋" ;;
  2) ICON="󱑌" ;;
  3) ICON="󱑍" ;;
  4) ICON="󱑎" ;;
  5) ICON="󱑏" ;;
  6) ICON="󱑐" ;;
  7) ICON="󱑑" ;;
  8) ICON="󱑒" ;;
  9) ICON="󱑓" ;;
  10) ICON="󱑔" ;;
  11) ICON="󱑕" ;;
  12) ICON="󱑖" ;;
esac

sketchybar --set "$NAME" icon="$ICON" label="${TIME}" update_freq=1 icon.background.color="${TIME_COLOR}" label.width=80
