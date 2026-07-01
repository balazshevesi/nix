{
  homebrew.casks = [
    {
      name = "nikitabobko/tap/aerospace";
      postinstall = ''
        if /usr/bin/pgrep -x AeroSpace >/dev/null; then
          /usr/bin/pkill -x AeroSpace || true
          /bin/sleep 1
          /usr/bin/open -a AeroSpace || true
        fi
      '';
    }
  ];

  launchd.user.agents.aerospace-autostart = {
    serviceConfig = {
      ProgramArguments = [ "/usr/bin/open" "-a" "AeroSpace" ];
      RunAtLoad = true;
      KeepAlive = false;
    };
  };
}
