# Codex CLI profile

This directory keeps the shared Codex CLI configuration. The profile only defines reusable defaults; each machine still
decides how to wire them into `~/.codex/config.toml`.

## Setup
`~/.codex/config.toml` can be overwritten by Codex itself, so treat the tracked
`config.toml` in this directory as the canonical template. Re-copy it whenever
you refresh a machine:

```sh
./sync-config.sh
```

The helper script ensures `~/.codex/` exists and then copies the template into
place. Run it after pulling updates or tweaking the template so every machine
stays consistent.
