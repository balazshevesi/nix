{
  imports = [
    ./taps.nix
    ./brews.nix
    ./casks.nix
  ];

  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "uninstall";
    };
  };

  launchd.user.agents.jankyborders = {
    serviceConfig = {
      ProgramArguments = [ "/opt/homebrew/bin/borders" ];
      RunAtLoad = true;
      KeepAlive = true;
    };
  };
}
