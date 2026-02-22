import {
  writeToProfile,
  // @ts-ignore - deno will resolve it
} from "karabiner.ts";

import { selectProfile } from "./profile-selection.ts";
import { commandTabNavigation, disableCmdQ } from "./modules/common.ts";
import { fromQwertyToColemak } from "./modules/colemak.ts";
import { superLayer } from "./modules/super-layer.ts";

// ! Change '--dry-run' to your Karabiner-Elements Profile name.
// (--dry-run print the config json into console)
// + Create a new profile if needed.
// Supported alias: https://github.com/evan-liu/karabiner.ts/blob/main/src/utils/key-alias.ts

export const DEFAULT_PROFILE = "standard - colemak";
export const AEROSPACE_BIN = "/opt/homebrew/bin/aerospace";

writeToProfile("standard - qwerty", [
  superLayer,
  commandTabNavigation,
  disableCmdQ,
]);

writeToProfile(DEFAULT_PROFILE, [
  superLayer,
  commandTabNavigation,
  disableCmdQ,
  ...fromQwertyToColemak,
]);

await selectProfile(DEFAULT_PROFILE);
