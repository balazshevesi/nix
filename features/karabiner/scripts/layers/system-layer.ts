import { FromModifierParam, map, rule } from "karabiner.ts";
import { shell } from "../utils/shell";

const mod: FromModifierParam = ["right_shift"];

export const systemLayer = rule("System rules").manipulators([
  map("escape", mod).to$(shell.apps.closeFocused),
  map("f1", mod).to$(shell.systemSettings.appearance.enableDarkMode),
  map("f2", mod).to$(shell.systemSettings.appearance.enableLightMode),
]);
