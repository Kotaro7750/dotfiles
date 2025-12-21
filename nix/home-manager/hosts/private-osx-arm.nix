{ config, pkgs, ... }:

{
  imports = [
    ../aerospace.nix
  ];

  home.username = "koutarou";
  home.homeDirectory = "/Users/koutarou";

  
  home.packages = [
    pkgs.slack
    pkgs.discord
  ];
}
