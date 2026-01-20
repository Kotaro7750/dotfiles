{ lib, pkgs, ... }:

let
  script = "${./scripts/codex-config.sh}";
in
{
  home.activation.codexManagedConfig = lib.hm.dag.entryAfter ["writeBoundary"] ''
    PATH="${pkgs.coreutils}/bin:${pkgs.python3Packages.yq}/bin:$PATH" sh "${script}"
  '';
}
