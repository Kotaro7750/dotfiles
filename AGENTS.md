# Repository Guidelines

## Project Structure & Module Organization
Active configurations live in `git/`, `nvim/`, `wezterm/`, and `zsh/`, each holding the dotfiles for that tool. Neovim lives in `nvim/`, with Lua modules under `nvim/lua/`, filetype overrides in `nvim/ftplugin/`, and plugin locks in `nvim/lazy-lock.json`. Bootstrap code in `init/` and other legacy directories are considered deprecated; ignore them unless explicitly instructed, and expect them to be removed or heavily rewritten.

## Build, Test, and Development Commands
- No repo-wide bootstrap commands are supported; disregard historical `make -C init/linux ...` targets.
- Handle relinks or provisioning tasks manually within the active directories and document any ad-hoc steps in future updates.
- Skip build or test targets that touch deprecated directories; focus effort on the active `git/`, `nvim/`, `wezterm/`, and `zsh/` trees unless told otherwise.

## Coding Style & Naming Conventions
Default to POSIX `sh` unless the script needs Bash; keep the `#!/bin/sh -xeu` or `#!/bin/bash -xeu` shebang and use 2-space indentation. Script filenames stay lowercase with hyphens (`tmux.sh`, `pyenv.sh`), while exported variables remain uppercase. Neovim Lua modules follow snake_case and configure through `vim.opt`/`vim.keymap.set`. Commit generated lockfiles such as `lazy-lock.json` whenever plugin revisions are updated.

## Testing Guidelines
Automated CI is not configured, so rely on local checks. After provisioning, run `nvim --headless "+Lazy sync" +qa` to confirm plugin health, `zsh -n ./zsh/.zshrc` for syntax validation, and `shellcheck` on new shell scripts. Exercise bootstrap changes in both WSL and non-WSL VMs to ensure `isWSL` logic works.

## Commit & Pull Request Guidelines
Reuse the `Type: Summary` style seen in history (`Add: Override wezterm config`, `Fix: Wrong repository root detection`). Keep commits focused on a single tool, include regenerated assets, and document behavioral impact in the body. PRs should link issues, state the tested environments (e.g., Ubuntu 22.04, WSL2), and attach screenshots or terminal snippets for UI-facing tweaks.

## Security & Configuration Tips
Audit scripts before executing; many invoke privileged package installs or tweak input methods. Keep machine-specific secrets out of the repo and rely on untracked overrides (such as the WezTerm override in recent commits). Sanitize personal paths before sharing updates.
