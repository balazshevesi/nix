{ config, lib, pkgs, ... }:
let
  opencodeConfig = import ./config/settings.nix;
  opencodeNotifierConfig = import ./config/notifier.nix;
  opencodePackageJson = import ./config/package.nix;
  opencodeBunLock = import ./config/bun-lock.nix;
in {
  home.activation.configureOpencode = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    opencode_dir="$HOME/.config/opencode"
    bun_install_dir="${config.home.homeDirectory}/.bun"
    bun_bin="${pkgs.bun}/bin/bun"

    mkdir -p "$opencode_dir"

    install -m 0644 ${pkgs.writeText "opencode.json" (builtins.toJSON opencodeConfig)} "$opencode_dir/opencode.json"
    install -m 0644 ${pkgs.writeText "opencode-notifier.json" (builtins.toJSON opencodeNotifierConfig)} "$opencode_dir/opencode-notifier.json"
    install -m 0644 ${pkgs.writeText "opencode-package.json" (builtins.toJSON opencodePackageJson)} "$opencode_dir/package.json"
    install -m 0644 ${pkgs.writeText "opencode-bun.lock" (builtins.toJSON opencodeBunLock)} "$opencode_dir/bun.lock"

    context7_key="$(/usr/bin/security find-generic-password -a "$USER" -s "context7_api_key" -w 2>/dev/null || true)"
    if [ -n "$context7_key" ]; then
      tmp_file="$(mktemp)"
      ${pkgs.jq}/bin/jq --arg key "$context7_key" '.mcp.context7.headers.CONTEXT7_API_KEY = $key' "$opencode_dir/opencode.json" > "$tmp_file"
      mv "$tmp_file" "$opencode_dir/opencode.json"
    fi

    if [ -x "$bun_bin" ]; then
      mkdir -p "$bun_install_dir"
      BUN_INSTALL="$bun_install_dir" "$bun_bin" add -g opencode-ai@latest
      BUN_INSTALL="$bun_install_dir" "$bun_bin" install --cwd "$opencode_dir" --frozen-lockfile || \
        BUN_INSTALL="$bun_install_dir" "$bun_bin" install --cwd "$opencode_dir"
    else
      echo "Skipping OpenCode bun install: bun binary not available at $bun_bin"
    fi
  '';
}
