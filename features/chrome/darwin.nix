{ lib, pkgs, ... }:
let
  extensionIds = [
    "ddkjiahejlhfcafbddmgiahcphecmpfh"
    "gppongmhjkpfnbhagpmjfkannfbllamg"
    "hdokiejnpimakedhajhdlcegeplioahd"
  ];

  mkForcelist = updateUrl:
    lib.concatStrings [
      "<key>ExtensionInstallForcelist</key>\n"
      "<array>\n"
      (lib.concatMapStrings (id:
        "  <string>${id};${updateUrl}</string>\n") extensionIds)
      "</array>\n"
    ];

  chromeForcelist = mkForcelist "https://clients2.google.com/service/update2/crx";
  heliumForcelist = mkForcelist "https://clients2.9oo91e.qjz9zk/service/update2/crx";

  chromeManagedPlist = pkgs.writeText "com.google.Chrome.plist" ''
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
      <dict>
        ${chromeForcelist}
      </dict>
    </plist>
  '';

  heliumManagedPlist = pkgs.writeText "net.imput.helium.plist" ''
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
      <dict>
        ${heliumForcelist}
      </dict>
    </plist>
  '';
in {
  system.activationScripts.preActivation.text = lib.mkAfter ''
    install -d -m 0755 "/Library/Managed Preferences"
    install -m 0644 ${chromeManagedPlist} "/Library/Managed Preferences/com.google.Chrome.plist"
    install -m 0644 ${heliumManagedPlist} "/Library/Managed Preferences/net.imput.helium.plist"
  '';
}
