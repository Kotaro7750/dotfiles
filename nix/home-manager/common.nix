{ pkgs, ... }:

{
  imports = [
    ./common-variables.nix
    ./nvim.nix
  ];

  home.packages = [
    pkgs.devcontainer
  ];
}
