{
  imports = [
    ./taps.nix
    ./brews.nix
    ./casks.nix
  ];

  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = false;
      upgrade = false;
      cleanup = "none";
    };
  };

  launchd.user.agents.jankyborders = {
    serviceConfig = {
      # ProgramArguments = [ "/opt/homebrew/bin/borders" ];
      ProgramArguments = [
        "/opt/homebrew/bin/borders"
        "style=round"
        "width=5.0"
        "active_color=0xffe1e3e4"
        "inactive_color=0xff494d64"
      ];
      RunAtLoad = true;
      KeepAlive = true;
    };
  };
}
