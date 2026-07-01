{
  homebrew.casks = [
    {
      name = "nikitabobko/tap/aerospace";
      postinstall = ''
        if /usr/bin/pgrep -x AeroSpace >/dev/null; then
          /usr/bin/osascript -e 'tell application "AeroSpace" to quit' || true
          /bin/sleep 1
          /usr/bin/open -a AeroSpace || true
        fi
      '';
    }
  ];
}
