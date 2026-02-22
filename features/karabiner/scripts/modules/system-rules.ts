import { layer, map, rule } from "karabiner.ts";
import { aerospaceMainBindings } from "./aerospace.ts";

export const systemRules = rule("System rules").manipulators([
  map("escape", ["right_shift"]).to$(
    'osascript -e \'tell application "System Events" to set frontApp to name of first application process whose frontmost is true\' -e \'if frontApp is not "Finder" then do shell script "killall -9 " & quoted form of frontApp\'',
  ),
  map("f1", ["right_shift"]).to$(
    "osascript -e 'tell application \"System Events\" to tell appearance preferences to set dark mode to true'",
  ),
  map("f2", ["right_shift"]).to$(
    "osascript -e 'tell application \"System Events\" to tell appearance preferences to set dark mode to false'",
  ),
]);
