#!/bin/sh -xeu
set +x

. "$(cd "$(dirname "$0")" && pwd)/color.sh"

sketchybar --set "$NAME" label="${INFO:-}" icon="" icon.background.color="${APP_COLOR}"
