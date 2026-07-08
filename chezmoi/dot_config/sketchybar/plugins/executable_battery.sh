#!/bin/bash -xeu
set +x

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/color.sh"

# AC Power or Battery Power
POWER_SOURCE="$(pmset -g batt | sed -n "1s/.*'\(.*\)'.*/\1/p")"

LINE="$(pmset -g batt | sed -n '2p')"
PERCENT="$(echo "$LINE" | awk 'match($0, /[0-9]+%/) { print substr($0, RSTART, RLENGTH-1) }')"
STATE="$(echo "$LINE" | awk -F';' '{gsub(/^[[:space:]]+|[[:space:]]+$/,"",$2); print $2}')"

level="$((PERCENT / 10))"

discharge_icons=( "󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" )
charging_icons=( "󰢟" "󰢜" "󰂆" "󰂇" "󰂈" "󰢝" "󰂉" "󰢞" "󰂊" "󰂋" "󰂅" )

case "$STATE" in
  discharging*)
    icon="${discharge_icons[$level]:-󰂑}"
    ;;
  *AC\ attached*)
    icon="󰚥"
    ;;
  charging*|Charging*|finishing\ charge*|Finishing\ charge*)
    icon="${charging_icons[$level]:-󰂑}"
    ;;
  *)
    icon="󰂑"
    ;;
esac

sketchybar --set "$NAME" icon="$icon" label="${PERCENT}%" update_freq=5 icon.background.color="${BATTERY_COLOR}"
