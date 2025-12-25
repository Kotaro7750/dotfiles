#!/bin/sh -xeu
set +x

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/color.sh"

DATE="$(date '+%a %Y-%m-%d')"
sketchybar --set "$NAME" icon="󰸗" label="${DATE}" update_freq=60 icon.background.color="${TIME_COLOR}"
