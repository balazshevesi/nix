{ config, pkgs, ... }: {
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
}
