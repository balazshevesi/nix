{ config, lib, pkgs, ... }: {
  home.packages = with pkgs; [
    nodePackages.typescript
    nodePackages.typescript-language-server
    nodePackages.eslint
    nodePackages.prettier
  ];

  home.sessionPath = [
    "${config.home.homeDirectory}/.bun/bin"
  ];

  home.activation.installOpencodeFromBun = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    bun_install_dir="${config.home.homeDirectory}/.bun"
    bun_bin="${pkgs.bun}/bin/bun"

    if [ ! -x "$bun_bin" ]; then
      echo "Skipping opencode-ai bun install: bun binary not available at $bun_bin"
      exit 0
    fi

    mkdir -p "$bun_install_dir"
    BUN_INSTALL="$bun_install_dir" "$bun_bin" add -g opencode-ai@latest
  '';
}
