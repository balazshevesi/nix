{ lib, pkgs, ... }:
let
  karabinerScripts = ./scripts;
in {
  home.activation.configureKarabiner = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p "$HOME/.config/karabiner"

    ${pkgs.deno}/bin/deno run \
      --allow-read \
      --allow-write \
      --allow-env \
      --allow-net \
      --no-lock \
      --config ${karabinerScripts}/deno.json \
      ${karabinerScripts}/index.ts
  '';
}
