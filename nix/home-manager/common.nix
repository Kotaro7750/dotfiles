{ pkgs, ... }:

{
  imports = [
    ./common-variables.nix
    ./direnv.nix
    ./lazygit.nix
    ./nvim.nix
    ./zsh.nix
  ];

  home.packages = [
    pkgs.wezterm
    pkgs.devcontainer
  ];
}
