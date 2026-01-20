{ pkgs, ... }:

{
  imports = [
    ./common-variables.nix
    ./codex.nix
    ./claude.nix
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
