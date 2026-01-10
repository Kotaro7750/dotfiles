{ pkgs, ... }:

{
  home.packages = [
    pkgs.direnv
  ];

  xdg.configFile."direnv/direnvrc".source = ../../direnv/direnvrc;
}
