{ lib, ... }: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    shellAliases = {
      cat = "bat";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "";
    };

    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    initContent = lib.mkMerge [
      (lib.mkOrder 1000 ''
        if [ -x /opt/homebrew/bin/brew ]; then
          eval "$(/opt/homebrew/bin/brew shellenv)"
        elif [ -x /usr/local/bin/brew ]; then
          eval "$(/usr/local/bin/brew shellenv)"
        fi

        export NVM_DIR="$HOME/.nvm"
        [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
        [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"

        [ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

        export BUN_INSTALL="$HOME/.bun"
        export PATH="$BUN_INSTALL/bin:$PATH"

        if command -v brew >/dev/null 2>&1 && OPENJDK21_PREFIX="$(brew --prefix openjdk@21 2>/dev/null)"; then
          export JAVA_HOME="$OPENJDK21_PREFIX/libexec/openjdk.jdk/Contents/Home"
        elif JAVA_HOME_FROM_MAC=$(/usr/libexec/java_home 2>/dev/null); then
          export JAVA_HOME="$JAVA_HOME_FROM_MAC"
        elif command -v brew >/dev/null 2>&1 && OPENJDK_PREFIX="$(brew --prefix openjdk 2>/dev/null)"; then
          export JAVA_HOME="$OPENJDK_PREFIX/libexec/openjdk.jdk/Contents/Home"
        fi

        if [ -n "$JAVA_HOME" ]; then
          export PATH="$JAVA_HOME/bin:$PATH"
        fi

        export PATH="$HOME/.antigravity/antigravity/bin:$PATH"
      '')

      (lib.mkOrder 1300 ''
        if command -v oh-my-posh >/dev/null 2>&1; then
          eval "$(oh-my-posh init zsh --config ~/.config/ohmyposh/config.omp.json)"
        fi
      '')
    ];
  };

  programs.bat = {
    enable = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  home.sessionVariables = {
    FZF_COMPLETION_TRIGGER = ",,";
  };

  programs.pay-respects = {
    enable = true;
    enableZshIntegration = true;
    options = [
      "--alias"
      "f"
      "--nocnf"
    ];
  };
}
