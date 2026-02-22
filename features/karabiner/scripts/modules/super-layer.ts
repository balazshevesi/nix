import {
  layer,
  map,
  // @ts-ignore - deno will resolve it
} from "karabiner.ts";
import { aerospaceMainBindings } from "./aerospace.ts";
import { withKey } from "./utils.ts";

export const superLayer = layer("⇪", "super")
  .modifiers("optionalAny")
  .manipulators([
    ...aerospaceMainBindings,
    // ...withKey("left_command", aerospaceMainBindings),

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

    map("comma").to$(
      "osascript -e 'tell application \"System Events\" to tell appearance preferences to set dark mode to true'",
    ),
    map("period").to$(
      "osascript -e 'tell application \"System Events\" to tell appearance preferences to set dark mode to false'",
    ),
  ]);
