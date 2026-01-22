{ config, lib, pkgs, ... }:

let
  script = "${./scripts/claude-config.sh}";
in
{
  home.packages = [
    pkgs.claude-code
  ];

  home.file.".claude/skills".source =
    config.lib.file.mkOutOfStoreSymlink
      (config.home.homeDirectory + "/dotfiles/claude/skills");

  home.activation.claudeManagedConfig = lib.hm.dag.entryAfter ["writeBoundary"] ''
    PATH="${pkgs.coreutils}/bin:${pkgs.jq}/bin:$PATH" sh "${script}"
  '';
}
