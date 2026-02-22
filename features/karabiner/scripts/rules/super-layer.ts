import {
  ifVar,
  layer,
  map,
  toUnsetVar,
  withCondition,
  // @ts-ignore - deno will resolve it
} from "karabiner.ts";

export const superLayer = layer("⇪", "super")
  .modifiers("optionalAny")
  .manipulators([
    map("left_command").toNone(),
    map("spacebar")
      .toVar("spacebar_is_down")
      .toAfterKeyUp(toUnsetVar("spacebar_is_down")),
    withCondition(ifVar("spacebar_is_down"))([
      // could be nice to have the space bar function as a 5x speed for i and k
      //map("d").to("z", ["command"]),
      // map("s").to("z", ["command", "shift"]),
    ]),
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
