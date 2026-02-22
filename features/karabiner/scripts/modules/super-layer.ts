import { layer, map } from "karabiner.ts";
import { aerospaceMainBindings } from "./aerospace.ts";

export const superLayer = layer("⇪", "super")
  .modifiers("optionalAny")
  .manipulators([
    ...aerospaceMainBindings,

    map("w").to("tab", ["left_control", "left_shift"]),
    map("r").to("tab", ["control"]),
    map("e").to("w", ["command"]),
    map("t").to("t", ["command"]),

    map("c").to("c", ["command"]),
    map("v").to("b", ["command"]),

    map("w").to("z", ["command"]),
    map("e").to("z", ["command", "shift"]),

    map("a").to("escape"),
    map("s").to("left_shift"),
    map("d").to("left_option"),
    map("f").to("left_command"),

    map("i").to("↑"),
    map("j").to("←"),
    map("k").to("↓"),
    map("l").to("→"),

    map("h").to("⌫"),
    map(";").to("⏎"),
  ]);
