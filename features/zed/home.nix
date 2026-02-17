{ pkgs, lib, ... }:
let
  zedSettings = import ./settings.nix;
  zedKeymap = import ./keymap.nix;
in {
  home.activation.configureZed = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    zed_dir="$HOME/.config/zed"
    mkdir -p "$zed_dir"

    install -m 0644 ${pkgs.writeText "zed-settings.json" (builtins.toJSON zedSettings)} "$zed_dir/settings.json"
    install -m 0644 ${pkgs.writeText "zed-keymap.json" (builtins.toJSON zedKeymap)} "$zed_dir/keymap.json"

    context7_key="$(/usr/bin/security find-generic-password -a "$USER" -s "context7_api_key" -w 2>/dev/null || true)"

    if [ -n "$context7_key" ]; then
      tmp_file="$(mktemp)"
      ${pkgs.jq}/bin/jq --arg key "$context7_key" '.context_servers."mcp-server-context7".settings.context7_api_key = $key' "$zed_dir/settings.json" > "$tmp_file"
      mv "$tmp_file" "$zed_dir/settings.json"
    fi
  '';
}
