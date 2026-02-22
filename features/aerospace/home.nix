{ ... }: {
  home.file.".aerospace.toml" = {
    source = ./config/aerospace.toml;
    force = true;
  };
}
