import {
  writeToProfile,
  // @ts-ignore - deno will resolve it
} from "karabiner.ts";

import { DEFAULT_PROFILE } from "./constants.ts";
import { selectDefaultProfile } from "./profile-selection.ts";
import {
  aerospaceMainBindings,
  aerospaceServiceBindings,
} from "./rules/aerospace.ts";
import { commandTabNavigation, disableCmdQ } from "./rules/common.ts";
import { fromQwertyToColemak } from "./rules/colemak.ts";
import { superLayer } from "./rules/super-layer.ts";

// ! Change '--dry-run' to your Karabiner-Elements Profile name.
// (--dry-run print the config json into console)
// + Create a new profile if needed.
// Supported alias: https://github.com/evan-liu/karabiner.ts/blob/main/src/utils/key-alias.ts

writeToProfile("standard - qwerty", [
  superLayer,
  aerospaceMainBindings,
  aerospaceServiceBindings,
  commandTabNavigation,
  disableCmdQ,
]);

writeToProfile(DEFAULT_PROFILE, [
  superLayer,
  aerospaceMainBindings,
  aerospaceServiceBindings,
  commandTabNavigation,
  disableCmdQ,
  ...fromQwertyToColemak,
]);

await selectDefaultProfile();
