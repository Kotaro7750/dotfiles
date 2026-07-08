{ config, pkgs, ... }:

{
  home.username = "koutarou";
  home.homeDirectory = "/Users/koutarou";

  home.sessionPath = [
    "/usr/local/bin"
  ];
  
  home.packages = [
    pkgs.slack
    pkgs.discord
    pkgs.colima
    pkgs.docker
    pkgs.docker-compose
  ];
}
