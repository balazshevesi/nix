{ ... }: {
  home.file.".config/ohmyposh/config.omp.json" = {
    source = ./config/settings.json;
    force = true;
  };
}
