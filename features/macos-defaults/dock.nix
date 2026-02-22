{
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
    ];
  };

  system.defaults.CustomUserPreferences."com.apple.dock" = {
    autohide = true;
    "autohide-delay" = 0.0;
    "autohide-time-modifier" = 0.4000000059604645;
    "expose-group-apps" = true;
    largesize = 80.0;
    magnification = true;
    mineffect = "suck";
    "minimize-to-application" = false;
    "show-process-indicators" = true;
    "show-recents" = false;
  };
}
