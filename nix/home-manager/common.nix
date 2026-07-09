{ pkgs, ... }:

{
  imports = [
    ./common-variables.nix
    ./nvim.nix
    ./zsh.nix
  ];

  home.packages = [
    pkgs.devcontainer
  ];
}
