import {
  ifVar,
  map,
  rule,
  toUnsetVar,
  withCondition,
  // @ts-ignore - deno will resolve it
} from "karabiner.ts";
import { withKey } from "./utils.ts";

const AEROSPACE_BIN = "/opt/homebrew/bin/aerospace";

export const aerospace = (command: string) => `${AEROSPACE_BIN} ${command}`;
export const moveToWorkspace = (workspace: string) =>
  `${aerospace(`move-node-to-workspace ${workspace}`)}; ${aerospace(
    `workspace ${workspace}`,
  )}`;

export const aerospaceMainBindings = [
  map("j", ["left_command"]).to$(aerospace("focus left")),
  map("k", ["left_command"]).to$(aerospace("focus down")),
  map("i", ["left_command"]).to$(aerospace("focus up")),
  map("l", ["left_command"]).to$(aerospace("focus right")),

  // ...withKey("f", [
  map("a", ["left_command"]).to$(aerospace("move left")),
  map("s", ["left_command"]).to$(aerospace("move down")),
  map("d", ["left_command"]).to$(aerospace("move right")),
  map("w", ["left_command"]).to$(aerospace("move up")),
  // ]),

  map("u", ["left_command"]).to$(aerospace("resize smart -100")),
  map("o", ["left_command"]).to$(aerospace("resize smart +100")),

  map("1", ["left_command"]).to$(aerospace("workspace 1")),
  map("2", ["left_command"]).to$(aerospace("workspace 2")),
  map("3", ["left_command"]).to$(aerospace("workspace 3")),
  map("4", ["left_command"]).to$(aerospace("workspace 4")),
  map("5", ["left_command"]).to$(aerospace("workspace 5")),

  map("1", ["left_option", "left_shift"]).to$(moveToWorkspace("1")),
  map("2", ["left_option", "left_shift"]).to$(moveToWorkspace("2")),
  map("3", ["left_option", "left_shift"]).to$(moveToWorkspace("3")),
  map("4", ["left_option", "left_shift"]).to$(moveToWorkspace("4")),
  map("5", ["left_option", "left_shift"]).to$(moveToWorkspace("5")),

  map("f", ["left_option"]).to$(aerospace("fullscreen")),
  map("slash", ["left_option"]).to$(
    aerospace("layout tiles horizontal vertical"),
  ),
  map("comma", ["left_option"]).to$(
    aerospace("layout accordion horizontal vertical"),
  ),
  map("spacebar", ["left_option", "left_shift"]).to$(
    aerospace("layout floating tiling"),
  ),
  map("tab", ["left_option"]).to$(aerospace("workspace-back-and-forth")),
  map("semicolon", ["left_option"]).toVar("aerospace_service_mode"),
];

// export const aerospaceServiceBindings = rule(
//   "aerospace service mode",
// ).manipulators([
//   withCondition(ifVar("aerospace_service_mode"))([
//     map("escape")
//       .to$(aerospace("reload-config"))
//       .toAfterKeyUp(toUnsetVar("aerospace_service_mode")),
//     map("r")
//       .to$(aerospace("flatten-workspace-tree"))
//       .toAfterKeyUp(toUnsetVar("aerospace_service_mode")),
//     map("delete_or_backspace")
//       .to$(aerospace("close-all-windows-but-current"))
//       .toAfterKeyUp(toUnsetVar("aerospace_service_mode")),
//     map("j")
//       .to$(aerospace("join-with left"))
//       .toAfterKeyUp(toUnsetVar("aerospace_service_mode")),
//     map("k")
//       .to$(aerospace("join-with down"))
//       .toAfterKeyUp(toUnsetVar("aerospace_service_mode")),
//     map("i")
//       .to$(aerospace("join-with up"))
//       .toAfterKeyUp(toUnsetVar("aerospace_service_mode")),
//     map("l")
//       .to$(aerospace("join-with right"))
//       .toAfterKeyUp(toUnsetVar("aerospace_service_mode")),
//     map("semicolon")
//       .toNone()
//       .toAfterKeyUp(toUnsetVar("aerospace_service_mode")),
//   ]),
// ]);
