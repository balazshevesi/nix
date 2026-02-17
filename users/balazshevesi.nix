{ config, ... }: {
  imports = [
    ../features/node/home.nix
    ../features/opencode/home.nix
    ../features/zed/home.nix
  ];

  home.username = "balazshevesi";
  home.homeDirectory = "/Users/balazshevesi";
  home.stateVersion = "24.11";

  programs.home-manager.enable = true;
}
