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
  rule("qwerty to colemak dhk").manipulators([
    map("q").to("q"),
    map("w").to("w"),
    map("c").to("c"),
    map("v").to("d"),
    map("e").to("f"),
    map("m").to("h"),
    map("l").to("i"),
    map("y").to("j"),
    map("h").to("k"),
    map("u").to("l"),
    map("n").to("m"),
    map("j").to("n"),
    map(";").to("o"),
    map("r").to("p"),
    map("s").to("r"),
    map("d").to("s"),
    map("f").to("t"),
    map("i").to("u"),
    map("x").to("x"),
    map("o").to("y"),
    map("z").to("z"),
    map("p").to(";"),
    map("b").to("v"),
    map("t").to("b"),
    map("k").to("e"),
  ]),
  rule("qwerty to colemak dhk with shift").manipulators([
    map("q", "shift", "any").to("q", ["shift"]),
    map("w", "shift", "any").to("w", ["shift"]),
    map("c", "shift", "any").to("c", ["shift"]),
    map("v", "shift", "any").to("d", ["shift"]),
    map("e", "shift", "any").to("f", ["shift"]),
    map("m", "shift", "any").to("h", ["shift"]),
    map("l", "shift", "any").to("i", ["shift"]),
    map("y", "shift", "any").to("j", ["shift"]),
    map("h", "shift", "any").to("k", ["shift"]),
    map("u", "shift", "any").to("l", ["shift"]),
    map("n", "shift", "any").to("m", ["shift"]),
    map("j", "shift", "any").to("n", ["shift"]),
    map(";", "shift", "any").to("o", ["shift"]),
    map("r", "shift", "any").to("p", ["shift"]),
    map("s", "shift", "any").to("r", ["shift"]),
    map("d", "shift", "any").to("s", ["shift"]),
    map("f", "shift", "any").to("t", ["shift"]),
    map("i", "shift", "any").to("u", ["shift"]),
    map("x", "shift", "any").to("x", ["shift"]),
    map("o", "shift", "any").to("y", ["shift"]),
    map("z", "shift", "any").to("z", ["shift"]),
    map("p", "shift", "any").to(";", ["shift"]),
    map("b", "shift", "any").to("v", ["shift"]),
    map("t", "shift", "any").to("b", ["shift"]),
    map("k", "shift", "any").to("e", ["shift"]),
  ]),
  layer("q", "disable cmd + q")
    .modifiers("left_command")
    .manipulators([map("q").toNone()]),
]);
