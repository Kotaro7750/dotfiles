{ pkgs, ... }:

{
  imports = [
    ./common-variables.nix
    ./claude.nix
    ./nvim.nix
    ./zsh.nix
  ];

  home.packages = [
    pkgs.devcontainer
  ];
}
