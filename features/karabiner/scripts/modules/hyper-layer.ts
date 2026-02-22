import { layer, map } from "karabiner.ts";
import { aerospaceBindings } from "./aerospace.ts";

export const superLayer = layer("⇪", "hyper")
  .modifiers("optionalAny")
  .manipulators([
    ...aerospaceBindings,

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
