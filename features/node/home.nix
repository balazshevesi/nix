{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    nodePackages.typescript
    nodePackages.typescript-language-server
    nodePackages.eslint
    nodePackages.prettier
    nodePackages.kill-port
  ];

  home.sessionPath = [
    "${config.home.homeDirectory}/.bun/bin"
  ];
}
