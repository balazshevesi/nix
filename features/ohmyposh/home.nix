{ lib, pkgs, ... }:
let
  ohMyPoshConfig = import ./config/settings.nix;
in {
  home.activation.configureOhMyPosh = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ohmyposh_dir="$HOME/.config/ohmyposh"
    mkdir -p "$ohmyposh_dir"

    install -m 0644 ${pkgs.writeText "ohmyposh-config.json" (builtins.toJSON ohMyPoshConfig)} "$ohmyposh_dir/config.omp.json"
  '';
}
