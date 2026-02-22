import {
  layer,
  map,
  rule,
  // @ts-ignore - deno will resolve it
} from "karabiner.ts";

export const commandTabNavigation = rule("command tab navigation").manipulators([
  map("q", ["left_command"]).to("tab", ["left_control", "left_shift"]),
  map("e", ["left_command"]).to("tab", ["control"]),
]);

export const disableCmdQ = layer("q", "disable cmd + q")
  .modifiers("left_command")
  .manipulators([map("q").toNone()]);
