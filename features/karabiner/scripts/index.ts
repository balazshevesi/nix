import { map, rule, writeToProfile } from "karabiner.ts";
import { hyperLayer } from "./layers/hyper-layer";
import { systemLayer } from "./layers/system-layer";
import { qwertyToColemak } from "./utils/colemak";
import { selectProfile } from "./utils/selectProfile";

// ! Change '--dry-run' to your Karabiner-Elements Profile name.
// (--dry-run print the config json into console)
// + Create a new profile if needed.
// Supported alias: https://github.com/evan-liu/karabiner.ts/blob/main/src/utils/key-alias.ts

export const DEFAULT_PROFILE = "standard - colemak";

writeToProfile("standard - qwerty", [
  rule("disable cmd + q").manipulators([map("q", ["command"]).toNone()]),
  hyperLayer,
  systemLayer,
]);

writeToProfile(DEFAULT_PROFILE, [
  rule("disable cmd + q").manipulators([map("q", ["command"]).toNone()]),
  hyperLayer,
  systemLayer,
  ...qwertyToColemak,
]);

await selectProfile(DEFAULT_PROFILE);
