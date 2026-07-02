{ pkgs, ... }: {
  home.packages = [ pkgs.git-lfs ];

  home.file.".gitignore_global".text = ''
    .DS_Store
    **/.claude/settings.local.json
  '';

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Balazs Hevesi";
        email = "bh222pv@student.lnu.se";
      };
      alias.ignore = "!gi() { curl -L -s https://www.gitignore.io/api/$@ ;}; gi";
      color.ui = "auto";
      core.excludesfile = "/Users/balazshevesi/.gitignore_global";
      init.defaultBranch = "main";
      pull.rebase = false;
      filter.lfs = {
        clean = "git-lfs clean -- %f";
        smudge = "git-lfs smudge -- %f";
        process = "git-lfs filter-process";
        required = true;
      };
    };
  };
}
