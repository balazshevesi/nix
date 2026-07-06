{ pkgs, lib, inputs, ... }:
let
  zedTemplate = "${inputs.stylix.inputs.tinted-zed}/templates/base16.mustache";
  mkZedTheme = scheme:
    pkgs.runCommand "zed-${builtins.baseNameOf scheme}.json" {
      nativeBuildInputs = [ pkgs.ruby ];
    } ''
      ruby - "${zedTemplate}" "${scheme}" > "$out" <<'RUBY'
      require "yaml"

      template_path, scheme_path = ARGV
      scheme = YAML.load_file(scheme_path)
      values = {
        "scheme-name" => scheme.fetch("name"),
        "scheme-author" => scheme.fetch("author"),
        "scheme-variant" => scheme.fetch("variant"),
      }

      scheme.fetch("palette").each do |key, value|
        values["#{key}-hex"] = value.delete_prefix("#")
      end

      print File.read(template_path).gsub(/\{\{([^}]+)\}\}/) { values.fetch(Regexp.last_match(1)) }
      RUBY
    '';
in {
  stylix.targets = {
    bat.enable = true;
    ghostty.enable = true;
    opencode.enable = true;
    zed.enable = true;
  };

  home.file.".config/zed/themes/stylix-light.json".source =
    mkZedTheme ./vscode-light-modern.yaml;

  programs.zed-editor.userSettings.theme = lib.mkForce {
    mode = "system";
    light = "Base16 VS Code Light Modern";
    dark = "Base16 VS Code Dark Modern";
  };
}
