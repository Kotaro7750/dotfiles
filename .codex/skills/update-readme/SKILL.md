---
name: update-readme
description: Keep all README files aligned with the current codebase by rewriting setup steps, removing outdated content, and syncing documentation to the latest repository state whenever asked to update, refresh, or sync READMEs.
---

# Update README

## Goals

- Keep every README in the repo accurate for the current codebase.
- Ensure README explains the current chezmoi setup workflow.
- Ensure README includes the mise install step that runs after chezmoi apply.
- Ensure README explains the practical split between Homebrew and mise.
- Remove outdated or no-longer-true statements.
- Write in concise Japanese unless the user explicitly asks for another language.

## Workflow

1) Discover README targets

- List README files with `rg --files -g 'README*'` from the repo root.
- Only the top-level `README.md` is permitted; subdirectory READMEs are not allowed.
- If any subdirectory README files exist, remove them and consolidate their content into the top-level README.

2) Determine scope for the README

- The top-level `README.md` must be the only README in the repo.
- Use the filesystem to confirm what exists before writing.

3) Rewrite the README

- Keep content minimal; include `## セットアップ`.
- `## セットアップ`
  - Describe the exact setup steps required now.
  - Install Homebrew by following the official installation instructions, then install chezmoi with `brew install chezmoi`.
  - Include copy-pasteable commands in Markdown code blocks so the setup can be executed directly.
  - After `chezmoi --source ./chezmoi apply`, include `mise install -C ~`.
  - Remove deprecated steps or tooling references.
  - Explain that Homebrew manages OS-level packages and mise manages versioned development tools.

4) Remove obsolete content

- Delete any badges, deprecated sections, or instructions that are no longer true.
- If a section cannot be substantiated from current files, remove it.

## Output expectations

- Do not add extra sections unless the user explicitly asks for them.
- For the root README, never mention deprecated folders (like `init/` or old Nix/Home Manager paths) or non-active folders unless instructed.
- Only `README.md` at repo root may exist; delete any others.

## Notes

- This repo treats `chezmoi/` as the active configuration root.
- The setup starts by installing Homebrew with the official installer, then installing chezmoi with Homebrew.
- The canonical dry-run/check command is `chezmoi --source ./chezmoi diff`.
- The canonical apply command is `chezmoi --source ./chezmoi apply`.
- The canonical mise tool installation command is `mise install -C ~`.
- If a README claims to manage files or scripts that no longer exist, remove those claims.
