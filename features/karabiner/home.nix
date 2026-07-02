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

    tmp_dir="$(mktemp -d)"
    trap 'rm -rf "$tmp_dir"' EXIT

    cp -R ${karabinerScripts}/. "$tmp_dir/"
    chmod -R u+w "$tmp_dir"
    ${pkgs.bun}/bin/bun install --cwd "$tmp_dir" --frozen-lockfile
    ${pkgs.bun}/bin/bun "$tmp_dir/index.ts"
  '';
}
