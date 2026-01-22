#!/bin/sh -xeu

dotfiles_root="${HOME}/dotfiles"
managed_file="${dotfiles_root}/claude/settings.json"
config_file="${HOME}/.claude/settings.json"

if [ ! -f "$managed_file" ]; then
  exit 0
fi

if ! command -v jq >/dev/null 2>&1; then
  exit 0
fi

mkdir -p "$(dirname "$config_file")"

if [ ! -f "$config_file" ]; then
  cp "$managed_file" "$config_file"
  exit 0
fi

tmp_file="$(mktemp "${config_file}.XXXXXX")"
jq -s '
  .[0] as $managed |
  .[1] as $local |
  $managed + { permissions: ($local.permissions // {}) }
' "$managed_file" "$config_file" > "$tmp_file"
mv "$tmp_file" "$config_file"
