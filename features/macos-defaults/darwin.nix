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
      AppleAccentColor = 6;
      AppleInterfaceStyle = "Dark";
      AppleKeyboardUIMode = 0;
      AppleScrollerPagingBehavior = true;
      AppleShowAllExtensions = true;
      AppleShowScrollBars = "WhenScrolling";
      NSAutomaticPeriodSubstitutionEnabled = true;
      "com.apple.mouse.scaling" = "-1";
      "com.apple.swipescrolldirection" = true;
      "com.apple.trackpad.forceClick" = true;
      "com.apple.trackpad.scaling" = 0.6875;
    };

    "com.apple.AppleMultitouchMouse" = {
      MouseButtonDivision = 55;
      MouseButtonMode = "OneButton";
      MouseHorizontalScroll = true;
      MouseMomentumScroll = true;
      MouseOneFingerDoubleTapGesture = 0;
      MouseTwoFingerDoubleTapGesture = 3;
      MouseTwoFingerHorizSwipeGesture = 2;
      MouseVerticalScroll = true;
      UserPreferences = true;
    };

    "com.apple.AppleMultitouchTrackpad" = {
      ActuateDetents = 1;
      Clicking = true;
      DragLock = 0;
      Dragging = false;
      FirstClickThreshold = 0;
      ForceSuppressed = false;
      SecondClickThreshold = 0;
      TrackpadCornerSecondaryClick = 0;
      TrackpadFiveFingerPinchGesture = 2;
      TrackpadFourFingerHorizSwipeGesture = 2;
      TrackpadFourFingerPinchGesture = 2;
      TrackpadFourFingerVertSwipeGesture = 2;
      TrackpadHandResting = true;
      TrackpadHorizScroll = true;
      TrackpadMomentumScroll = true;
      TrackpadPinch = true;
      TrackpadRightClick = true;
      TrackpadRotate = 1;
      TrackpadScroll = true;
      TrackpadThreeFingerDrag = false;
      TrackpadThreeFingerHorizSwipeGesture = 2;
      TrackpadThreeFingerTapGesture = 0;
      TrackpadThreeFingerVertSwipeGesture = 2;
      TrackpadTwoFingerDoubleTapGesture = 1;
      TrackpadTwoFingerFromRightEdgeSwipeGesture = 3;
      USBMouseStopsTrackpad = 0;
      UserPreferences = true;
    };

    "com.apple.HIToolbox" = {
      AppleCurrentKeyboardLayoutInputSourceID = "com.apple.keylayout.Swedish-Pro";
      AppleDefaultAsciiInputSource = {
              InputSourceID = "com.apple.keylayout.Swedish";
              InputSourceKind = "Keyboard Layout";
            };
      AppleEnabledInputSources = [
              {
                        InputSourceKind = "Keyboard Layout";
                        "KeyboardLayout ID" = 7;
                        "KeyboardLayout Name" = "Swedish - Pro";
                      }
              {
                        "Bundle ID" = "com.apple.CharacterPaletteIM";
                        InputSourceKind = "Non Keyboard Input Method";
                      }
            ];
      AppleFnUsageType = 0;
      AppleInputSourceHistory = [
              {
                        InputSourceID = "com.apple.keylayout.Swedish";
                        InputSourceKind = "Keyboard Layout";
                      }
            ];
      AppleSelectedInputSources = [
              {
                        InputSourceKind = "Keyboard Layout";
                        "KeyboardLayout ID" = 7;
                        "KeyboardLayout Name" = "Swedish - Pro";
                      }
            ];
    };

    "com.apple.WindowManager" = {
      AppWindowGroupingBehavior = 1;
      AutoHide = false;
      EnableStandardClickToShowDesktop = false;
      GloballyEnabled = false;
      HideDesktop = true;
      StageManagerHideWidgets = false;
      StandardHideDesktopIcons = true;
      StandardHideWidgets = false;
    };

    "com.apple.controlcenter" = {
      "NSStatusItem Visible AudioVideoModule" = true;
      "NSStatusItem Visible Battery" = true;
      "NSStatusItem Visible BentoBox" = true;
      "NSStatusItem Visible Bluetooth" = true;
      "NSStatusItem Visible Clock" = true;
      "NSStatusItem Visible Display" = false;
      "NSStatusItem Visible FaceTime" = false;
      "NSStatusItem Visible FocusModes" = false;
      "NSStatusItem Visible Item-0" = false;
      "NSStatusItem Visible Item-1" = false;
      "NSStatusItem Visible Item-10" = false;
      "NSStatusItem Visible Item-11" = false;
      "NSStatusItem Visible Item-12" = false;
      "NSStatusItem Visible Item-2" = false;
      "NSStatusItem Visible Item-3" = false;
      "NSStatusItem Visible Item-4" = false;
      "NSStatusItem Visible Item-5" = false;
      "NSStatusItem Visible Item-6" = false;
      "NSStatusItem Visible Item-7" = false;
      "NSStatusItem Visible Item-8" = false;
      "NSStatusItem Visible Item-9" = false;
      "NSStatusItem Visible KeyboardBrightness" = true;
      "NSStatusItem Visible NowPlaying" = true;
      "NSStatusItem Visible Shortcuts" = false;
      "NSStatusItem Visible Sound" = true;
      "NSStatusItem Visible Timer" = false;
      "NSStatusItem Visible WiFi" = true;
    };

    "com.apple.dock" = {
      autohide = true;
      "autohide-delay" = 0.0;
      "autohide-time-modifier" = 0.4;
      "expose-group-apps" = true;
      largesize = 80.0;
      magnification = true;
      mineffect = "suck";
      "minimize-to-application" = false;
      "show-process-indicators" = true;
      "show-recents" = false;
    };

    "com.apple.driver.AppleBluetoothMultitouch.mouse" = {
      MouseButtonDivision = 55;
      MouseButtonMode = "OneButton";
      MouseHorizontalScroll = true;
      MouseMomentumScroll = true;
      MouseOneFingerDoubleTapGesture = 0;
      MouseTwoFingerDoubleTapGesture = 3;
      MouseTwoFingerHorizSwipeGesture = 2;
      MouseVerticalScroll = true;
      UserPreferences = true;
    };

    "com.apple.driver.AppleBluetoothMultitouch.trackpad" = {
      Clicking = true;
      DragLock = false;
      Dragging = false;
      TrackpadCornerSecondaryClick = 0;
      TrackpadFiveFingerPinchGesture = 2;
      TrackpadFourFingerHorizSwipeGesture = 2;
      TrackpadFourFingerPinchGesture = 2;
      TrackpadFourFingerVertSwipeGesture = 2;
      TrackpadHandResting = true;
      TrackpadHorizScroll = 1;
      TrackpadMomentumScroll = true;
      TrackpadPinch = true;
      TrackpadRightClick = true;
      TrackpadRotate = 1;
      TrackpadScroll = true;
      TrackpadThreeFingerDrag = false;
      TrackpadThreeFingerHorizSwipeGesture = 2;
      TrackpadThreeFingerTapGesture = 0;
      TrackpadThreeFingerVertSwipeGesture = 2;
      TrackpadTwoFingerDoubleTapGesture = 1;
      TrackpadTwoFingerFromRightEdgeSwipeGesture = 3;
      USBMouseStopsTrackpad = 0;
      UserPreferences = true;
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

    "com.apple.iphonesimulator" = {
      ScreenShotSaveLocation = "~/Pictures/Screenshots";
    };

    "com.apple.menuextra.clock" = {
      FlashDateSeparators = false;
    };

    "com.apple.screencapture" = {
      location = "~/Desktop";
    };

    "com.apple.universalaccess" = {
      showWindowTitlebarIcons = false;
    };
  };
}
