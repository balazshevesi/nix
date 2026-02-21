{
  show_edit_predictions = false;
  lsp.vtsls = {
    settings = {
      typescript.updateImportsOnFileMove.enabled = "always";
      javascript.updateImportsOnFileMove.enabled = "always";
    };
    enable_lsp_tasks = true;
  };
  cursor_blink = false;
  vertical_scroll_margin = 0.0;
  auto_update = true;
  context_servers."mcp-server-context7" = {
    enabled = true;
    settings = {};
  };
  text_rendering_mode = "subpixel";
  max_tabs = 99;
  gutter = {
    line_numbers = true;
    runnables = false;
    breakpoints = false;
    folds = true;
    min_line_number_digits = 4;
  };
  current_line_highlight = "all";
  edit_predictions = {
    provider = "zed";
    mode = "eager";
  };
  diagnostics = {
    button = true;
    include_warnings = true;
    inline = {
      enabled = true;
      update_debounce_ms = 150;
      padding = 4;
      min_column = 0;
      max_severity = null;
    };
  };
  colorize_brackets = true;
  agent = {
    dock = "left";
    always_allow_tool_actions = true;
    default_profile = "write";
    profiles = {
      debug-and-fix = {
        name = "Debug and fix";
        tools = {};
        enable_all_context_servers = false;
        context_servers = {};
      };
      testing = {
        name = "Codex + Context7";
        tools = {};
        enable_all_context_servers = false;
        context_servers."mcp-server-context7".tools = {
          resolve-library-id = true;
          get-library-docs = true;
        };
      };
    };
    default_model = {
      provider = "copilot_chat";
      model = "gpt-5-mini";
    };
    model_parameters = [];
  };
  buffer_font_family = "Mishafi";
  autosave.after_delay.milliseconds = 20000;
  tabs.file_icons = true;
  languages = {
    TypeScript = {
      format_on_save = "on";
      formatter.external = {
        command = "/Users/balazshevesi/.bun/bin/prettier";
        arguments = ["--stdin-filepath" "{buffer_path}"];
      };
    };
    JavaScript = {
      format_on_save = "on";
      formatter.external = {
        command = "/Users/balazshevesi/.bun/bin/prettier";
        arguments = ["--stdin-filepath" "{buffer_path}"];
      };
    };
    TSX = {
      format_on_save = "on";
      formatter.external = {
        command = "/Users/balazshevesi/.bun/bin/prettier";
        arguments = ["--stdin-filepath" "{buffer_path}"];
      };
    };
    CSS = {
      format_on_save = "on";
      formatter.external = {
        command = "/Users/balazshevesi/.bun/bin/prettier";
        arguments = ["--stdin-filepath" "{buffer_path}"];
      };
    };
    HTML = {
      format_on_save = "on";
      formatter.external = {
        command = "/Users/balazshevesi/.bun/bin/prettier";
        arguments = ["--stdin-filepath" "{buffer_path}"];
      };
    };
    JSON = {
      format_on_save = "on";
      formatter.external = {
        command = "/Users/balazshevesi/.bun/bin/prettier";
        arguments = ["--stdin-filepath" "{buffer_path}"];
      };
    };
    JSONC = {
      format_on_save = "on";
      formatter.external = {
        command = "/Users/balazshevesi/.bun/bin/prettier";
        arguments = ["--stdin-filepath" "{buffer_path}"];
      };
    };
  };
  base_keymap = "VSCode";
  helix_mode = false;
  outline_panel = {
    folder_icons = true;
    file_icons = true;
  };
  project_panel = {
    dock = "right";
    auto_fold_dirs = false;
  };
  telemetry = {
    diagnostics = false;
    metrics = false;
  };
  vim_mode = false;
  icon_theme = {
    mode = "system";
    light = "Zed (Default)";
    dark = "VSCode Icons for Zed (Dark)";
  };
  ui_font_size = 16;
  buffer_font_size = 15;
  theme = {
    mode = "system";
    light = "VSCode Light+";
    dark = "VSCode Dark Modern";
  };
  auto_install_extensions = {
    # languages
    "html" = true;
    "csv" = true;
    "nix" = true;
    "java" = true;
    "vue" = true;
    "xml" = true;
    "astro" = true;
    "toml" = true;
    "dockerfile" = true;
    "mermaid" = true;
    "git-firefly" = true;
    "codebook" = true; # spellcheck
    # other
    "0x96f" = true;
    "bearded-icon-theme" = true;
    "colored-zed-icons-theme" = true;
    "colorizer" = true;
    "dracula" = true;
    "emmet" = true;
    "jetbrains-new-ui-icons" = true;
    "macos-classic" = true;
    "mcp-server-context7" = true;
    "opencode" = true;
    "react-typescript-snippets" = true;
    "vscode-icons" = true;
  };
}
