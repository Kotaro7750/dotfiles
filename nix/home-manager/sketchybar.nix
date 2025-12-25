{ config, pkgs, lib, ... }:

{
  home.packages = [
    pkgs.sketchybar
  ];

  xdg.configFile."sketchybar/sketchybarrc".source =
    config.lib.file.mkOutOfStoreSymlink
      (config.home.homeDirectory + "/dotfiles/sketchybar/sketchybarrc");
}
