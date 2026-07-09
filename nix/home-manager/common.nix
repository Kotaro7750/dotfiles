{ pkgs, ... }:

{
  imports = [
    ./common-variables.nix
    ./codex.nix
    ./claude.nix
    ./nvim.nix
    ./zsh.nix
  ];

  home.packages = [
    pkgs.devcontainer
  ];
}
