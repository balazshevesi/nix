{ ... }: {
  system.defaults.CustomUserPreferences."com.apple.HIToolbox" = {
    AppleEnabledInputSources = [
      {
        InputSourceKind = "Keyboard Layout";
        InputSourceID = "com.apple.keylayout.ABC";
      }
      {
        InputSourceKind = "Keyboard Layout";
        InputSourceID = "com.apple.keylayout.Swedish";
      }
      {
        InputSourceKind = "Non Keyboard Input Method";
        "Bundle ID" = "com.apple.PressAndHold";
      }
    ];

    AppleSelectedInputSources = [
      {
        InputSourceKind = "Keyboard Layout";
        InputSourceID = "com.apple.keylayout.Swedish";
      }
    ];
  };
}
