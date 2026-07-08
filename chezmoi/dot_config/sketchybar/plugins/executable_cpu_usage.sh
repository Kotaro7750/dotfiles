#!/bin/bash -xeu
set +x

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/color.sh"

idle="$(
  LC_ALL=C top -l 1 -n 0 |
    awk -F'[, ]+' '
      /^CPU usage:/ {
        for (i = 1; i <= NF; i++) {
          if ($i == "idle") {
            v = $(i-1)
            gsub(/%/, "", v)
            print v
            exit
          }
        }
      }
    '
)"

cpu_pct="$(
  awk -v idle="$idle" 'BEGIN {
    v = 100 - idle
    if (v < 0) v = 0
    if (v > 100) v = 100
    printf "%.0f", v
  }'
)"

sketchybar --set "$NAME" label="${cpu_pct}%" icon="" icon.background.color="${STATS_COLOR}" label.width=40
