{ self, pkgs, ... }: {
  imports = [
    ../features/macos-defaults/darwin.nix
    ../features/secrets/darwin.nix
    ../features/stylix/darwin.nix
    ../features/wallpaper/darwin.nix
    ../features/homebrew/darwin.nix
    ../features/aerospace/darwin.nix
    ../features/chrome/darwin.nix
    ../features/node/darwin.nix
    ../features/zed/darwin.nix
    ../features/karabiner/darwin.nix
  ];

  environment.systemPackages = [
    pkgs.git
    pkgs.curl
    pkgs.vim
    pkgs.nixd
  ];
  programs.zsh.enable = true;

  networking = {
    computerName = "Balazs MacBook Air M2";
    hostName = "macbook-air-m2";
    localHostName = "macbook-air-m2";
  };

  nix.enable = false;
  nix.settings.experimental-features = "nix-command flakes";

  users.users.balazshevesi = {
    name = "balazshevesi";
    home = "/Users/balazshevesi";
  };

  system.primaryUser = "balazshevesi";
  system.configurationRevision = self.rev or self.dirtyRev or null;
  system.stateVersion = 5;

  nixpkgs.hostPlatform = "aarch64-darwin";
}
