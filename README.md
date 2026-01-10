## Setup
With Nix and Home Manager installed, run the setup command from the repository root and specify the host-specific configuration in the flake output:

```sh
home-manager switch --flake ./nix#<host>
```

Example for the current host configuration:

```sh
home-manager switch --flake ./nix#private-osx-arm
```

## Nix layout
- Common packages and shared settings live under `nix/home-manager/` (for example `nix/home-manager/common.nix` and the shared module files).
- Host-specific configuration lives under `nix/home-manager/hosts/` and each host has its own `.nix` file (for example `nix/home-manager/hosts/private-osx-arm.nix`).
