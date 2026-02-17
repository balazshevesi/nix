{ self, pkgs, ... }: {
  imports = [
    ../features/homebrew/darwin.nix
    ../features/node/darwin.nix
    ../features/zed/darwin.nix
    ../features/karabiner/darwin.nix
  ];

  environment.systemPackages = [
    pkgs.git
    pkgs.curl
    pkgs.vim
  ];

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
