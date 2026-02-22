import { map, rule, writeToProfile } from "karabiner.ts";

import { selectProfile } from "./modules/profile-selection.ts";
import { fromQwertyToColemak } from "./modules/colemak.ts";
import { superLayer } from "./modules/super-layer.ts";
import { systemRules } from "./modules/system-rules.ts";

// ! Change '--dry-run' to your Karabiner-Elements Profile name.
// (--dry-run print the config json into console)
// + Create a new profile if needed.
// Supported alias: https://github.com/evan-liu/karabiner.ts/blob/main/src/utils/key-alias.ts

export const DEFAULT_PROFILE = "standard - colemak";
export const AEROSPACE_BIN = "/opt/homebrew/bin/aerospace";

writeToProfile("standard - qwerty", [
  rule("disable cmd + q").manipulators([map("q", ["command"]).toNone()]),
  superLayer,
  systemRules,
]);

writeToProfile(DEFAULT_PROFILE, [
  rule("disable cmd + q").manipulators([map("q", ["command"]).toNone()]),
  superLayer,
  systemRules,
  ...fromQwertyToColemak,
]);

await selectProfile(DEFAULT_PROFILE);
