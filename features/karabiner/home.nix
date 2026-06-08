{ lib, pkgs, ... }:
let
  karabinerScripts = ./scripts;
  hyperPointerSpeed = pkgs.stdenv.mkDerivation {
    pname = "hyper-pointer-speed";
    version = "1.0.0";
    src = ./pointer-speed/hyper-pointer-speed.c;

    dontUnpack = true;

    buildPhase = ''
      $CC "$src" -o hyper-pointer-speed -framework IOKit -framework CoreFoundation
    '';

    installPhase = ''
      mkdir -p "$out/bin"
      install -m 0755 hyper-pointer-speed "$out/bin/hyper-pointer-speed"
    '';
  };
in {
  home.packages = [ hyperPointerSpeed ];

  home.activation.configureKarabiner = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p "$HOME/.config/karabiner"

    ${pkgs.bun}/bin/bun run ${karabinerScripts}/index.ts
  '';
}
