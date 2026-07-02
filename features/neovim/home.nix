{ pkgs, ... }: {
  programs.neovim = {
    enable = true;
    package = pkgs.neovim;
    withPython3 = true;
    withRuby = true;
  };

  xdg.configFile."nvim" = {
    source = ./config;
    recursive = true;
    force = true;
  };
}
