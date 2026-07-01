{ pkgs, lib, ... }:
let
  zedSettings = import ./config/settings.nix;
  zedKeymap = import ./config/keymap.nix;
in {
  programs.zed-editor = {
    enable = true;
    package = null; # installed through homebrew
    userSettings = zedSettings;
    userKeymaps = zedKeymap;
  };

  home.activation.configureZedSecrets = lib.hm.dag.entryAfter [ "zedSettingsActivation" ] ''
    zed_dir="$HOME/.config/zed"
    mkdir -p "$zed_dir"

    context7_key="$(/usr/bin/security find-generic-password -a "$USER" -s "context7_api_key" -w 2>/dev/null || true)"

    if [ -n "$context7_key" ]; then
      if [ -L "$zed_dir/settings.json" ]; then
        cp "$zed_dir/settings.json" "$zed_dir/settings.json.tmp"
        mv "$zed_dir/settings.json.tmp" "$zed_dir/settings.json"
      fi

      tmp_file="$(mktemp)"
      ${pkgs.jq}/bin/jq --arg key "$context7_key" '.context_servers."mcp-server-context7".settings.context7_api_key = $key' "$zed_dir/settings.json" > "$tmp_file"
      mv "$tmp_file" "$zed_dir/settings.json"
    fi
  '';
}
