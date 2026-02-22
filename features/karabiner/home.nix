{ lib, pkgs, ... }:
let
  karabinerScripts = ./scripts;
in {
  home.activation.configureKarabiner = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p "$HOME/.config/karabiner"

    ${pkgs.bun}/bin/bun run ${karabinerScripts}/index.ts
  '';
}
