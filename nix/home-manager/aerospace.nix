{ config, pkgs, lib, ... }:

lib.mkIf pkgs.stdenv.isDarwin {
  home.packages = [
    pkgs.aerospace
  ];

  xdg.configFile."aerospace/aerospace.toml".source =
    config.lib.file.mkOutOfStoreSymlink
      (config.home.homeDirectory + "/dotfiles/aerospace/aerospace.toml");
}
