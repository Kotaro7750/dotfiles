#!/bin/sh -xeu

# Keep Codex CLI config in sync by copying the tracked template to ~/.codex/config.toml.

repo_dir="$(cd "$(dirname "$0")" && pwd)"
template_file="${repo_dir}/config.toml"
target_dir="${HOME}/.codex"
target_file="${target_dir}/config.toml"

mkdir -p "${target_dir}"
cp "${template_file}" "${target_file}"
