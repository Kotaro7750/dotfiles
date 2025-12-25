{ config, pkgs, ... }:

{
  imports = [
    ../aerospace.nix
    ../sketchybar.nix
  ];

  home.username = "koutarou";
  home.homeDirectory = "/Users/koutarou";

  home.sessionPath = [
    "/usr/local/bin"
  ];
  
  home.packages = [
    pkgs.slack
    pkgs.discord
  ];
}
