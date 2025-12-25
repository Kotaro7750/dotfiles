#!/bin/sh -xeu
set +x

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/color.sh"

workspace="$(aerospace list-workspaces --focused --format '%{workspace}' 2>/dev/null || true)"

if [ -z "$workspace" ]; then
  workspace="N/A"
fi

sketchybar --set "$NAME" icon="" label="$workspace" icon.background.color="${APP_COLOR}"
