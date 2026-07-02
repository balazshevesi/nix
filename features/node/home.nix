{ config, lib, pkgs, ... }: {
  home.packages = with pkgs; [
    typescript
    typescript-language-server
    eslint
    prettier
    # kill-port
  ];

  home.sessionPath = [
    "${config.home.homeDirectory}/.bun/bin"
  ];

  home.activation.installBunGlobalPackages = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    bun_bin="${pkgs.bun}/bin/bun"
    bun_install_dir="${config.home.homeDirectory}/.bun"

    mkdir -p "$bun_install_dir"
    BUN_INSTALL="$bun_install_dir" "$bun_bin" add -g prettier@3.7.4
  '';
}
