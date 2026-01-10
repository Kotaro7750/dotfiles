{ pkgs, ... }:

{
  imports = [
    ./common-variables.nix
    ./direnv.nix
    ./nvim.nix
    ./zsh.nix
  ];

  home.packages = [
    pkgs.wezterm
  ];
}
