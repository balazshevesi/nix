{ pkgs, ... }:
let
  schemes = {
    dark = ./vscode-dark-modern.yaml;
    light = ./vscode-light-modern.yaml;
  };
in {
  assertions = [{
    assertion = builtins.all builtins.pathExists (builtins.attrValues schemes);
    message = "All configured Stylix color schemes must exist.";
  }];

  stylix = {
    enable = true;
    autoEnable = false;
    polarity = "dark";
    base16Scheme = schemes.dark;

    fonts = {
      monospace = {
        package = pkgs.meslo-lgs-nf;
        name = "MesloLGS Nerd Font Mono";
      };
      sansSerif = {
        package = pkgs.inter;
        name = "Inter";
      };
      serif = {
        package = pkgs.inter;
        name = "Inter";
      };
      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };

      sizes = {
        applications = 12;
        desktop = 12;
        popups = 12;
        terminal = 11;
      };
    };
  };
}
