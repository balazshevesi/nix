import { map, rule, writeToProfile } from "karabiner.ts";
import { hyperLayer } from "./layers/hyperLayer";
import { systemLayer } from "./layers/systemLayer";
import { qwertyToColemak } from "./utils/colemak";
import { ensureProfiles } from "./utils/ensureProfiles";
import { selectProfile } from "./utils/selectProfile";

// ! Change '--dry-run' to your Karabiner-Elements Profile name.
// (--dry-run print the config json into console)
// + Create a new profile if needed.
// Supported alias: https://github.com/evan-liu/karabiner.ts/blob/main/src/utils/key-alias.ts

const QWERTY_PROFILE = "standard - qwerty";
export const DEFAULT_PROFILE = "standard - colemak";

await ensureProfiles([QWERTY_PROFILE, DEFAULT_PROFILE]);

writeToProfile(QWERTY_PROFILE, [
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
