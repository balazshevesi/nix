import { layer, map } from "karabiner.ts";
import { withKey } from "../utils/withKey.ts";
import { shell } from "../utils/shell.ts";

const a = shell.aerospace;

const aerospaceBindings = [
  ...withKey("spacebar", [
    // focus windows - i/j/k/l
    map("j").to$(a("focus left")),
    map("k").to$(a("focus down")),
    map("i").to$(a("focus up")),
    map("l").to$(a("focus right")),

    // move windows - s/d/e/f
    map("s").to$(a("move left")),
    map("d").to$(a("move down")),
    map("f").to$(a("move right")),
    map("e").to$(a("move up")),

    // resize windows - n/h
    map("n").to$(a("resize smart -150")),
    map("h").to$(a("resize smart +150")),

    // move window to workspace
    map("1").to$(a("move-node-to-workspace 1", "workspace 1")),
    map("2").to$(a("move-node-to-workspace 2", "workspace 2")),
    map("3").to$(a("move-node-to-workspace 3", "workspace 3")),
    map("4").to$(a("move-node-to-workspace 4", "workspace 4")),
    map("5").to$(a("move-node-to-workspace 5", "workspace 5")),

    // fullscreen window
    map(";").to$(a("fullscreen")),

    // accordion - horizontal vertical
    map("comma").to$(a("layout accordion horizontal vertical")),

    // layout tiles - horizontal vertical
    map("period").to$(a("layout tiles horizontal vertical")),

    // float window
    map("m").to$(a("layout floating tiling")),

    // balance sizes
    map("q").to$(a("balance-sizes")),
    map("z").to$(a("flatten-workspace-tree")),
  ]),

  // switch workspaces
  map("1").to$(a("workspace 1")),
  map("2").to$(a("workspace 2")),
  map("3").to$(a("workspace 3")),
  map("4").to$(a("workspace 4")),
  map("5").to$(a("workspace 5")),
  map("tab").to$(a("workspace-back-and-forth")),
];

/*
Paneru bindings kept for reference:

const p = shell.paneru;
const paneruResizeBackward = p(...Array.from({ length: 2 }, () => "window resize"));

const paneruBindings = [
  ...withKey("spacebar", [
    // focus windows - i/j/k/l
    map("j").to$(p("window focus west")),
    map("k").to$(p("window focus south")),
    map("i").to$(p("window focus north")),
    map("l").to$(p("window focus east")),

    // swap windows - s/d/e/f
    map("s").to$(p("window swap west")),
    map("d").to$(p("window swap south")),
    map("e").to$(p("window swap north")),
    map("f").to$(p("window swap east")),

    // resize/full-width
    map("n").to$(p("window resize")),
    map("h").to$(p("window fullwidth")),
    map(";").to$(p("window center")),
    // edge/display actions
    map("1").to$(p("window focus first")),
    map("2").to$(p("window swap first")),
    map("3").to$(p("window nextdisplay")),
    map("4").to$(p("window swap last")),
    map("5").to$(p("window focus last")),

    // stack/unstack columns
    map("comma").to$(p("window stack")),
    map("period").to$(p("window unstack")),

    // manage/equalize/center
    map("m").to$(p("window manage")),
    map("q").to$(p("window equalize")),
    map("z").to$(p("mouse nextdisplay")),
  ]),

  // switch macOS workspaces
  map("1").to$(shell.systemSettings.workspace.switchTo(1)),
  map("2").to$(shell.systemSettings.workspace.switchTo(2)),
  map("3").to$(shell.systemSettings.workspace.switchTo(3)),
  map("4").to$(shell.systemSettings.workspace.switchTo(4)),
  map("5").to$(shell.systemSettings.workspace.switchTo(5)),
  map("tab").to$(shell.systemSettings.workspace.next),
];
*/

//
export const hyperLayer = layer("⇪", "hyper")
  .modifiers("optionalAny")
  .manipulators([
    // aerospace bindings
    ...aerospaceBindings,

    // paneru bindings (disabled)
    // ...paneruBindings,

    // tab navigation
    map("w").to("tab", ["left_control", "left_shift"]),
    map("r").to("tab", ["control"]),
    map("e").to("w", ["command"]),
    map("t").to("t", ["command"]),

    // copy-paste
    map("c").to("c", ["command"]),
    map("v").to("b", ["command"]),

    // undo-redo
    map("w").to("z", ["command"]),
    map("e").to("z", ["command", "shift"]),

    // mods
    map("a").to("escape"),
    map("s").to("left_shift"),
    map("d").to("left_option"),
    map("f").to("left_command"),

    // arrows
    map("i").to("↑"),
    map("j").to("←"),
    map("k").to("↓"),
    map("l").to("→"),

    // backspace and enter
    map("h").to("⌫"),
    map(";").to("⏎"),
  ]);
