{ pkgs, ... }:

{
  imports = [
    ./common-variables.nix
    ./common-nvim.nix
    ./common-zsh.nix
  ];

  home.packages = [
    pkgs.wezterm
  ];
}
