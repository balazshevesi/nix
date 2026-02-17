{ pkgs, ... }:
let
  extensionForcelist = ''
    <key>ExtensionInstallForcelist</key>
    <array>
      <string>ddkjiahejlhfcafbddmgiahcphecmpfh;https://clients2.google.com/service/update2/crx</string>
      <string>gppongmhjkpfnbhagpmjfkannfbllamg;https://clients2.google.com/service/update2/crx</string>
    </array>
  '';

  chromeManagedPlist = pkgs.writeText "com.google.Chrome.plist" ''
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
      <dict>
        ${extensionForcelist}
      </dict>
    </plist>
  '';

  heliumManagedPlist = pkgs.writeText "net.imput.helium.plist" ''
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
      <dict>
        ${extensionForcelist}
      </dict>
    </plist>
  '';
in {
  system.activationScripts.chromeManagedPolicies.text = ''
    install -d -m 0755 "/Library/Managed Preferences"
    install -m 0644 ${chromeManagedPlist} "/Library/Managed Preferences/com.google.Chrome.plist"
    install -m 0644 ${heliumManagedPlist} "/Library/Managed Preferences/net.imput.helium.plist"
  '';
}
