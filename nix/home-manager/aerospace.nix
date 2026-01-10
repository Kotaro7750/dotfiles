{ config, pkgs, lib, ... }:

 {
  home.packages = [
    pkgs.aerospace
  ];

  xdg.configFile."aerospace/aerospace.toml".source =
    config.lib.file.mkOutOfStoreSymlink
      (config.home.homeDirectory + "/dotfiles/aerospace/aerospace.toml");
}
