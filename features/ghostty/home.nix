{ config, ... }: {
  programs.ghostty = {
    enable = true;
    package = null; # installed through homebrew, so here it is set to null
    enableZshIntegration = true;

    settings = {
      command = "/bin/zsh";
      keybind = [ "shift+enter=text:\\x1b\\r" ];
    };
  };

  xdg.configFile."ghostty/config".force = true;

  home.file."Library/Application Support/com.mitchellh.ghostty/config" = {
    source = config.xdg.configFile."ghostty/config".source;
    force = true;
  };
}
