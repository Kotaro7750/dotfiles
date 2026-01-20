#!/bin/sh -xeu

dotfiles_root="${HOME}/dotfiles"
managed_file="${dotfiles_root}/codex/config.toml"
config_file="${HOME}/.codex/config.toml"

if [ ! -f "$managed_file" ]; then
  echo "codex: managed config missing at $managed_file; skipping update."
  exit 0
fi

if ! command -v tomlq >/dev/null 2>&1; then
  echo "codex: tomlq not found in PATH; skipping update."
  exit 0
fi

mkdir -p "$(dirname "$config_file")"

if [ ! -f "$config_file" ]; then
  cp "$managed_file" "$config_file"
  exit 0
fi

tmp_file="$(mktemp "${config_file}.XXXXXX")"
tomlq -t '
  . as $managed
  | (input) as $local
  | $managed
  | .projects = ($local.projects // {})
' "$managed_file" "$config_file" > "$tmp_file"
mv "$tmp_file" "$config_file"
