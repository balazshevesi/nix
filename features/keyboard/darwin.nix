{ lib, ... }: {
  system.activationScripts.preActivation.text = lib.mkAfter ''
    install -d -m 0755 "/Library/Keyboard Layouts"
    rm -rf "/Library/Keyboard Layouts/SwedishColemakDHk.bundle"
    cp -R ${./SwedishColemakDHk.bundle} "/Library/Keyboard Layouts/SwedishColemakDHk.bundle"
    chown -R root:wheel "/Library/Keyboard Layouts/SwedishColemakDHk.bundle"
    chmod -R go-w "/Library/Keyboard Layouts/SwedishColemakDHk.bundle"
  '';

  system.defaults.CustomUserPreferences."com.apple.HIToolbox" = {
    AppleEnabledInputSources = [
      {
        InputSourceKind = "Keyboard Layout";
        InputSourceID = "com.apple.keylayout.ABC";
      }
      {
        InputSourceKind = "Keyboard Layout";
        "KeyboardLayout ID" = -20197;
        "KeyboardLayout Name" = "Swedish Colemak DHk";
      }
      {
        InputSourceKind = "Non Keyboard Input Method";
        "Bundle ID" = "com.apple.PressAndHold";
      }
    ];

    AppleSelectedInputSources = [
      {
        InputSourceKind = "Keyboard Layout";
        "KeyboardLayout ID" = -20197;
        "KeyboardLayout Name" = "Swedish Colemak DHk";
      }
    ];
  };
}
