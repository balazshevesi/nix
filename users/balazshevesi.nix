{ config, ... }: {
  imports = [
    ../features/aerospace/home.nix
    ../features/paneru/home.nix
    ../features/ghostty/home.nix
    ../features/karabiner/home.nix
    ../features/node/home.nix
    ../features/ohmyposh/home.nix
    ../features/opencode/home.nix
    ../features/zed/home.nix
    ../features/zsh/home.nix
  ];

  home.username = "balazshevesi";
  home.homeDirectory = "/Users/balazshevesi";
  home.stateVersion = "24.11";

  programs.home-manager.enable = true;
}
