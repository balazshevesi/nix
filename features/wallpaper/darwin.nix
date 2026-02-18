{ config, lib, ... }:
let
  primaryUser = config.system.primaryUser;
  wallpaperPath = "/Users/balazshevesi/Library/Application Support/com.apple.mobileAssetDesktop/Catalina.heic";
in {
  system.activationScripts.postActivation.text = lib.mkAfter ''
    if [ -f "${wallpaperPath}" ]; then
      uid="$(id -u ${primaryUser})"
      launchctl asuser "$uid" sudo -u ${primaryUser} --set-home \
        /usr/bin/osascript -e 'tell application "System Events" to tell every desktop to set picture to POSIX file "${wallpaperPath}"'
    else
      echo "Wallpaper file not found: ${wallpaperPath}" >&2
    fi
  '';
}
