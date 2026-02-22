import { FromModifierParam, map, rule } from "karabiner.ts";
import { shell as sh } from "./shell";

const mod: FromModifierParam = ["right_shift"];

export const systemRules = rule("System rules").manipulators([
  map("escape", mod).to$(sh.apps.closeFocused),
  map("f1", mod).to$(sh.systemSettings.appearance.enableDarkMode),
  map("f2", mod).to$(sh.systemSettings.appearance.enableLightMode),
]);
