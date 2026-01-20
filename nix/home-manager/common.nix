{ pkgs, ... }:

{
  imports = [
    ./common-variables.nix
    ./direnv.nix
    ./lazygit.nix
    ./nvim.nix
    ./zsh.nix
    ./wezterm.nix
  ];

  home.packages = [
    pkgs.devcontainer
  ];
}
