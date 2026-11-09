{
  homebrew.taps = [
    {
      name = "acsandmann/tap";
      trusted = true;
    }
  ];
  homebrew.brews = [ "acsandmann/tap/rift" ];

  # Rift requires "Displays have separate Spaces".
  system.defaults.spaces.spans-displays = false;

  launchd.user.agents.rift = {
    serviceConfig = {
      ProgramArguments = [ "/opt/homebrew/bin/rift" ];
      RunAtLoad = true;
      KeepAlive = true;
      ProcessType = "Interactive";
      EnvironmentVariables = {
        PATH = "/opt/homebrew/bin:/usr/bin:/bin:/usr/sbin:/sbin";
        LANG = "en_US.UTF-8";
      };
      StandardOutPath = "/tmp/rift.out.log";
      StandardErrorPath = "/tmp/rift.err.log";
    };
  };
}
