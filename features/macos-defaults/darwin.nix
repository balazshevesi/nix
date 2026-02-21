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
      "/System/Applications/Utilities/Activity Monitor.app"
    ];
  };

  system.defaults.CustomUserPreferences = {
    NSGlobalDomain = {
      AppleKeyboardUIMode = 0;
      AppleShowAllExtensions = true;
      NSAutomaticPeriodSubstitutionEnabled = true;
      AppleAccentColor = 6;
      AppleInterfaceStyle = "Dark";
      "com.apple.mouse.scaling" = "-1";
    };

    "com.apple.AppleMultitouchTrackpad" = {
      DragLock = 0;
      Dragging = false;
      FirstClickThreshold = 0;
      TrackpadThreeFingerDrag = false;
    };

    "com.apple.dock" = {
      autohide = true;
      "autohide-delay" = 0.0;
      "autohide-time-modifier" = 0.4;
      "expose-group-apps" = true;
      mineffect = "suck";
      "show-recents" = false;
    };

    "com.apple.finder" = {
      AppleShowAllFiles = true;
      CreateDesktop = false;
      FXDefaultSearchScope = "SCcf";
      FXPreferredViewStyle = "Nlsv";
      FXRemoveOldTrashItems = true;
      QuitMenuItem = true;
      ShowExternalHardDrivesOnDesktop = true;
      ShowHardDrivesOnDesktop = false;
      ShowPathbar = true;
      ShowRemovableMediaOnDesktop = true;
    };

    "com.apple.menuextra.clock" = {
      FlashDateSeparators = false;
    };

    "com.apple.universalaccess" = {
      showWindowTitlebarIcons = false;
    };
  };
}
