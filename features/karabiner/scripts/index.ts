import { map, rule, writeToProfile } from "karabiner.ts";
import { qwertyToColemak } from "./modules/colemak.ts";
import { superLayer } from "./modules/hyper-layer.ts";
import { systemRules } from "./modules/system-rules.ts";
import { selectProfile } from "./modules/utils/selectProfile.ts";

// ! Change '--dry-run' to your Karabiner-Elements Profile name.
// (--dry-run print the config json into console)
// + Create a new profile if needed.
// Supported alias: https://github.com/evan-liu/karabiner.ts/blob/main/src/utils/key-alias.ts

export const DEFAULT_PROFILE = "standard - colemak";

writeToProfile("standard - qwerty", [
  rule("disable cmd + q").manipulators([map("q", ["command"]).toNone()]),
  superLayer,
  systemRules,
]);

writeToProfile(DEFAULT_PROFILE, [
  rule("disable cmd + q").manipulators([map("q", ["command"]).toNone()]),
  superLayer,
  systemRules,
  ...qwertyToColemak,
]);

await selectProfile(DEFAULT_PROFILE);
