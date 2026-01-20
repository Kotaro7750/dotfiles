{ config, pkgs, lib, ... }:

{
  home.packages = [
    pkgs.wezterm
  ];

  xdg.configFile."wezterm/wezterm.lua".source =
    config.lib.file.mkOutOfStoreSymlink
      (config.home.homeDirectory + "/dotfiles/wezterm/wezterm.lua");

  xdg.configFile."wezterm/override_config.lua".source =
    config.lib.file.mkOutOfStoreSymlink
      (config.home.homeDirectory + "/dotfiles/wezterm/override_config.lua");
}
