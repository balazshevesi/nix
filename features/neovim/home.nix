{ pkgs, ... }: {
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-unwrapped;
    withPython3 = true;
    withRuby = true;
  };

  xdg.configFile."nvim" = {
    source = ./config;
    recursive = true;
    force = true;
  };
}
