import {
  ifVar,
  layer,
  map,
  rule,
  toUnsetVar,
  withCondition,
  writeToProfile,
  // @ts-ignore - deno will resolve it
} from "karabiner.ts";

// ! Change '--dry-run' to your Karabiner-Elements Profile name.
// (--dry-run print the config json into console)
// + Create a new profile if needed.
// Supported alias: https://github.com/evan-liu/karabiner.ts/blob/main/src/utils/key-alias.ts

writeToProfile("karabiner.ts", [
  // rule("").manipulators([map("right_command").to("⌫")]),
  layer("⇪", "super_layer_is_active")
    .modifiers("optionalAny")
    // .notification("hint")
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
      //map("r").toPaste("testing"),

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
    ]),
  rule("command tab navigation").manipulators([
    map("q", ["left_command"]).to("tab", ["left_control", "left_shift"]),
    map("e", ["left_command"]).to("tab", ["control"]),
  ]),
  rule("colemak to qwerty when command held").manipulators([
    map("b", "command", "any").to("t", ["command"]),
    map("e", "command", "any").to("k", ["command"]),
    map("c", "command", "any").to("c", ["command"]),
    map("d", "command", "any").to("v", ["command"]),
    map("f", "command", "any").to("e", ["command"]),
    map("h", "command", "any").to("m", ["command"]),
    map("i", "command", "any").to("l", ["command"]),
    map("j", "command", "any").to("y", ["command"]),
    map("k", "command", "any").to("h", ["command"]),
    map("l", "command", "any").to("u", ["command"]),
    map("m", "command", "any").to("n", ["command"]),
    map("n", "command", "any").to("j", ["command"]),
    map("o", "command", "any").to(";", ["command"]),
    map("p", "command", "any").to("r", ["command"]),
    map("r", "command", "any").to("s", ["command"]),
    map("s", "command", "any").to("d", ["command"]),
    map("t", "command", "any").to("f", ["command"]),
    map("u", "command", "any").to("i", ["command"]),
    map("x", "command", "any").to("x", ["command"]),
    map("y", "command", "any").to("o", ["command"]),
    map("z", "command", "any").to("z", ["command"]), //
    map(";", "command", "any").to("p", ["command"]),
    map("v", "command", "any").to("b", ["command"]), //
  ]),
  layer("q", "disable cmd + q")
    .modifiers("left_command")
    .manipulators([map("q").toNone()]),
]);
