#!/bin/bash -xeu
set +x

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/color.sh"

mem_total="$(sysctl -n hw.memsize)"
page_size="$(sysctl -n hw.pagesize)"

read -r pages_free pages_spec < <(
  vm_stat | awk '
    /Pages free/ { gsub(/[^0-9]/, "", $3); free=$3 }
    /Pages speculative/ { gsub(/[^0-9]/, "", $3); spec=$3 }
    END { printf "%s %s\n", free+0, spec+0 }
  '
)

mem_available="$(( (pages_free + pages_spec) * page_size ))"
mem_used="$(( mem_total - mem_available ))"

used_gb="$(
  awk -v used="$mem_used" 'BEGIN { printf "%.1f", used / (1024*1024*1024) }'
)"

sketchybar --set "$NAME" label="${used_gb}G" icon.background.color="${STATS_COLOR}" label.width=60 icon=""
