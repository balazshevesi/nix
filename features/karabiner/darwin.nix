{
  homebrew.casks = [
    "karabiner-elements"
  ];

  launchd.user.agents.karabiner-autostart = {
    serviceConfig = {
      ProgramArguments = [ "/usr/bin/open" "-a" "Karabiner-Elements" ];
      RunAtLoad = true;
      KeepAlive = false;
    };
  };
}
