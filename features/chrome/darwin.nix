{ lib, pkgs, ... }:
let
  normalInstalledExtensionIds = [
    "hdokiejnpimakedhajhdlcegeplioahd" # Lastpass
    "ddkjiahejlhfcafbddmgiahcphecmpfh" # uBlock Origin Lite
    "gppongmhjkpfnbhagpmjfkannfbllamg" # Wappalyzer
    "fdpohaocaechififmbbbbbknoalclacl" # GoFullPage - Full Page Screen Capture
    "iobmefdldoplhmonnnkchglfdeepnfhd" # Google Search Keyboard Shortcuts
    "nkbihfbeogaeaoehlefnkodbefgpgknn" # Metamask
    "fmkadmapgofadopljbjfkapdkoienihi" # React Developer Tools
    "jabopobgcpjmedljpbcaablpmlmfcogm" # WhatFont
    "eimadpbcbfnmbkopoojfekhnkhdbieeh" # Dark Reader
    "khncfooichmfjbepaaaebmommgaepoid" # Unhook - Remove YouTube Recommended
  ];

  chromeUpdateUrl = "https://clients2.google.com/service/update2/crx";
  heliumUpdateUrl = "https://clients2.9oo91e.qjz9zk/service/update2/crx";

  mkForcelist = updateUrl: extensionIds:
    lib.concatStrings [
      "<key>ExtensionInstallForcelist</key>\n"
      "<array>\n"
      (lib.concatMapStrings (id:
        "  <string>${id};${updateUrl}</string>\n") extensionIds)
      "</array>\n"
    ];

  mkExtensionSettings = updateUrl: extensionIds:
    lib.concatStrings [
      "<key>ExtensionSettings</key>\n"
      "<dict>\n"
      (lib.concatMapStrings (id: ''
        <key>${id}</key>
        <dict>
          <key>installation_mode</key>
          <string>normal_installed</string>
          <key>update_url</key>
          <string>${updateUrl}</string>
        </dict>
      '') extensionIds)
      "</dict>\n"
    ];

  chromeExtensionSettings = mkExtensionSettings chromeUpdateUrl normalInstalledExtensionIds;
  heliumExtensionSettings = mkExtensionSettings heliumUpdateUrl normalInstalledExtensionIds;

  chromeManagedPlist = pkgs.writeText "com.google.Chrome.plist" ''
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
      <dict>
        ${chromeForcelist}
        ${chromeExtensionSettings}
      </dict>
    </plist>
  '';

  heliumManagedPlist = pkgs.writeText "net.imput.helium.plist" ''
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
      <dict>
        ${heliumForcelist}
        ${heliumExtensionSettings}
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
