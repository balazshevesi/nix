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

const DEFAULT_PROFILE = "standard - colemak";

// ! Change '--dry-run' to your Karabiner-Elements Profile name.
// (--dry-run print the config json into console)
// + Create a new profile if needed.
// Supported alias: https://github.com/evan-liu/karabiner.ts/blob/main/src/utils/key-alias.ts

const superLayer = layer("⇪", "super")
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

const fromQwertyToColemak = [
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
    map("q", "shift").to("q", ["shift"]),
    map("w", "shift").to("w", ["shift"]),
    map("c", "shift").to("c", ["shift"]),
    map("v", "shift").to("d", ["shift"]),
    map("e", "shift").to("f", ["shift"]),
    map("m", "shift").to("h", ["shift"]),
    map("l", "shift").to("i", ["shift"]),
    map("y", "shift").to("j", ["shift"]),
    map("h", "shift").to("k", ["shift"]),
    map("u", "shift").to("l", ["shift"]),
    map("n", "shift").to("m", ["shift"]),
    map("j", "shift").to("n", ["shift"]),
    map(";", "shift").to("o", ["shift"]),
    map("r", "shift").to("p", ["shift"]),
    map("s", "shift").to("r", ["shift"]),
    map("d", "shift").to("s", ["shift"]),
    map("f", "shift").to("t", ["shift"]),
    map("i", "shift").to("u", ["shift"]),
    map("x", "shift").to("x", ["shift"]),
    map("o", "shift").to("y", ["shift"]),
    map("z", "shift").to("z", ["shift"]),
    map("p", "shift").to(";", ["shift"]),
    map("b", "shift").to("v", ["shift"]),
    map("t", "shift").to("b", ["shift"]),
    map("k", "shift").to("e", ["shift"]),
  ]),
];

// const systemLayer = layer("")

writeToProfile("standard - qwerty", [
  superLayer,
  rule("command tab navigation").manipulators([
    map("q", ["left_command"]).to("tab", ["left_control", "left_shift"]),
    map("e", ["left_command"]).to("tab", ["control"]),
  ]),
  layer("q", "disable cmd + q")
    .modifiers("left_command")
    .manipulators([map("q").toNone()]),
]);

writeToProfile(DEFAULT_PROFILE, [
  superLayer,
  rule("command tab navigation").manipulators([
    map("q", ["left_command"]).to("tab", ["left_control", "left_shift"]),
    map("e", ["left_command"]).to("tab", ["control"]),
  ]),
  layer("q", "disable cmd + q")
    .modifiers("left_command")
    .manipulators([map("q").toNone()]),
  ...fromQwertyToColemak,
]);

const home = Deno.env.get("HOME");

if (home) {
  const configPath = `${home}/.config/karabiner/karabiner.json`;

  try {
    const raw = await Deno.readTextFile(configPath);
    const data = JSON.parse(raw) as {
      profiles?: Array<{ name?: string; selected?: boolean }>;
    };

    for (const profile of data.profiles ?? []) {
      profile.selected = profile.name === DEFAULT_PROFILE;
    }

    await Deno.writeTextFile(configPath, `${JSON.stringify(data, null, 2)}\n`);
  } catch (error) {
    if (!(error instanceof Deno.errors.NotFound)) {
      throw error;
    }
  }
}
