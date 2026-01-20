{ config, pkgs, lib, ... }:

 {
  home.packages = [
    pkgs.claude-code
  ];
}
