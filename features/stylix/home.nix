{ pkgs, lib, config, inputs, ... }:
let
  zedTemplate = "${inputs.stylix.inputs.tinted-zed}/templates/base16.mustache";
  schemes = {
    dark = ./vscode-dark-modern.yaml;
    light = ./vscode-light-modern.yaml;
  };
  mkGhosttyTheme = colors: {
    background = colors.base00;
    foreground = colors.base05;
    cursor-color = colors.base05;
    selection-background = colors.base02;
    selection-foreground = colors.base05;

    palette = with colors.withHashtag; [
      "0=${base00}"
      "1=${base08}"
      "2=${base0B}"
      "3=${base0A}"
      "4=${base0D}"
      "5=${base0E}"
      "6=${base0C}"
      "7=${base05}"
      "8=${base03}"
      "9=${base08}"
      "10=${base0B}"
      "11=${base0A}"
      "12=${base0D}"
      "13=${base0E}"
      "14=${base0C}"
      "15=${base07}"
    ];
  };
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

  programs.ghostty = {
    settings.theme = lib.mkForce "light:stylix-light,dark:stylix-dark";
    themes = {
      stylix-light = mkGhosttyTheme
        (config.stylix.base16.mkSchemeAttrs schemes.light);
      stylix-dark = mkGhosttyTheme
        (config.stylix.base16.mkSchemeAttrs schemes.dark);
    };
  };

  home.file.".config/zed/themes/stylix-light.json".source = mkZedTheme schemes.light;

  programs.zed-editor.userSettings.theme = lib.mkForce {
    mode = "system";
    light = "Base16 VS Code Light Modern";
    dark = "Base16 VS Code Dark Modern";
  };
}
