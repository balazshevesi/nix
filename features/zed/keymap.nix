[
  {
    context = "Workspace";
    bindings = {
      "alt-cmd-b" = "workspace::ToggleLeftDock";
      "cmd-b" = "workspace::ToggleRightDock";
    };
  }
  {
    context = "Editor";
    bindings."cmd-/" = [
      "editor::ToggleComments"
      { advance_downwards = false; }
    ];
  }
  {
    context = "(Editor && mode == full)";
    bindings = {
      "cmd-r cmd-e" = [
        "buffer_search::Deploy"
        { focus = false; }
      ];
      "alt-e" = [
        "buffer_search::Deploy"
        { focus = false; }
      ];
      "escape escape" = [
        "buffer_search::Deploy"
        { focus = false; }
      ];
      "alt-e alt-e" = null;
      "cmd-e" = null;
    };
  }
  {
    bindings."cmd-r" = "workspace::ToggleZoom";
  }
  {
    context = "Terminal";
    bindings."cmd-f" = [
      "buffer_search::Deploy"
      { focus = true; }
    ];
  }
  {
    context = "Pane";
    bindings = {
      "ctrl-shift-tab" = "pane::ActivatePreviousItem";
      "ctrl-tab" = "pane::ActivateNextItem";
    };
  }
]
