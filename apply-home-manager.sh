#!/bin/sh -xeu

if [ $# -ne 1 ]; then
  cat <<'EOF'
Usage: ./apply-home-manager.sh <host>
Apply Home Manager from the flake output at ./nix#<host>.
Example: ./apply-home-manager.sh private-osx-arm
EOF
  exit 1
fi

if ! command -v home-manager >/dev/null 2>&1; then
  echo "home-manager command is not available in PATH." >&2
  exit 1
fi

host="$1"
exec home-manager switch --flake "./nix#${host}"
