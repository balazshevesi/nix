{
  system.defaults.CustomUserPreferences = {
    # - -1 graphite
    # - 0 red
    # - 1 orange
    # - 2 yellow
    # - 3 green
    # - 4 blue
    # - 5 purple
    # - 6 pink
    NSGlobalDomain = {
      AppleAccentColor = 6;
      AppleInterfaceStyle = "Dark";
    };
  };

  system.defaults.dock = {
    orientation = "right";
    tilesize = 49;

    persistent-apps = [
      "/System/Applications/System Settings.app"
      "/System/Applications/Calculator.app"
      "/System/Applications/Mail.app"
      "/Applications/Spotify.app"
      "/Applications/Google Chrome.app"
      "/Applications/Ghostty.app"
      "/System/Applications/Utilities/Activity Monitor.app"
    ];
  };
}
