import {
  FromKeyParam,
  ifVar,
  layer,
  map as map,
  ToEvent,
  ToKeyParam,
  toUnsetVar,
  withCondition,
} from "karabiner.ts";
import { withKey } from "../utils/withKey.ts";
import { shell } from "../utils/shell.ts";
import { repeatKey } from "../utils/repeatKey.ts";

const HOMEROW: FromKeyParam[] = ["a", "s", "d", "f", "g", "h", "j", "k", "l"];
const NUMBER_LAYER = "hyper_number_layer";
const a = shell.aerospace;
const ether = shell.ether;

const aerospaceBindings = [
  ...withKey("spacebar", [
    // focus windows - i/j/k/l
    map("j").to$(a("focus left")),
    map("k").to$(a("focus down")),
    map("i").to$(a("focus up")),
    map("l").to$(a("focus right")),

    // move windows - s/d/e/f
    map("s").to$(a("move left")),
    map("d").to$(a("move down")),
    map("f").to$(a("move right")),
    map("e").to$(a("move up")),

    // resize windows - n/h
    map("n").to$(a("resize smart -150")),
    map("h").to$(a("resize smart +150")),

    // move window to workspace
    map("1").to$(a("move-node-to-workspace 1", "workspace 1")),
    map("2").to$(a("move-node-to-workspace 2", "workspace 2")),
    map("3").to$(a("move-node-to-workspace 3", "workspace 3")),
    map("4").to$(a("move-node-to-workspace 4", "workspace 4")),
    map("5").to$(a("move-node-to-workspace 5", "workspace 5")),

    // fullscreen window
    map(";").to$(a("fullscreen")),

    // accordion - horizontal vertical
    map("comma").to$(a("layout accordion horizontal vertical")),

    // layout tiles - horizontal vertical
    map("period").to$(a("layout tiles horizontal vertical")),

    // float window
    map("m").to$(a("layout floating tiling")),

    // balance sizes
    map("q").to$(a("balance-sizes")),
    map("z").to$(a("flatten-workspace-tree")),
  ]),

  // switch workspaces
  map("1").to$(a("workspace 1")),
  map("2").to$(a("workspace 2")),
  map("3").to$(a("workspace 3")),
  map("4").to$(a("workspace 4")),
  map("5").to$(a("workspace 5")),
  map("tab").to$(a("workspace-back-and-forth")),
];

const etherBindings = [
  ...withKey("left_command", [
    // focus windows - i/j/k/l
    map("j").to$(ether("focus left")),
    map("k").to$(ether("focus down")),
    map("i").to$(ether("focus up")),
    map("l").to$(ether("focus right")),

    // move windows - s/d/e/f
    map("s").to$(ether("move left")),
    map("d").to$(ether("move down")),
    map("f").to$(ether("move right")),
    map("e").to$(ether("move up")),

    // resize windows - n/h
    map("n").to$(ether("resize smart -150")),
    map("h").to$(ether("resize smart +150")),

    // move window to workspace
    map("1").to$(ether("move-to-workspace 1", "workspace 1")),
    map("2").to$(ether("move-to-workspace 2", "workspace 2")),
    map("3").to$(ether("move-to-workspace 3", "workspace 3")),
    map("4").to$(ether("move-to-workspace 4", "workspace 4")),
    map("5").to$(ether("move-to-workspace 5", "workspace 5")),

    // fullscreen window
    map(";").to$(ether("toggle-fullscreen")),

    // tree toggles
    map("comma").to$(ether("toggle-nearest-direction")),
    map("period").to$(ether("toggle-nearest-type")),
    map("m").to$(ether("toggle-workspace-direction")),
  ]),

  // switch workspaces
  map("1").to$(ether("workspace 1")),
  map("2").to$(ether("workspace 2")),
  map("3").to$(ether("workspace 3")),
  map("4").to$(ether("workspace 4")),
  map("5").to$(ether("workspace 5")),
];

// const p = shell.paneru;
// const paneruResizeBackward = p(
//   ...Array.from({ length: 2 }, () => "window resize"),
// );

const symbols: Record<string, ToEvent> = {
  "(": { key_code: "8", modifiers: ["left_shift"] },
  ")": { key_code: "9", modifiers: ["left_shift"] },
  "[": { key_code: "8", modifiers: ["left_option"] },
  "]": { key_code: "9", modifiers: ["left_option"] },
  "{": { key_code: "8", modifiers: ["left_option", "left_shift"] },
  "}": { key_code: "9", modifiers: ["left_option", "left_shift"] },
  "<": { key_code: "non_us_backslash", repeat: false },
  ">": {
    key_code: "non_us_backslash",
    modifiers: ["left_shift"],
    repeat: false,
  },
  "=": { key_code: "0", modifiers: ["left_shift"] },
  "/": { key_code: "7", modifiers: ["left_shift"] },
};

export const hyperLayer = layer("⇪", "hyper")
  .modifiers("optionalAny")
  .configKey(
    (key) => key.toIfAlone("escape").toAfterKeyUp(toUnsetVar(NUMBER_LAYER)),
    true,
  )
  .manipulators([
    // ether-wm bindings under hyper + left_command
    // ...etherBindings,

    // aerospace bindings
    ...aerospaceBindings,

    ...withCondition(ifVar(NUMBER_LAYER))([
      ...HOMEROW.map((l, i) => map(l).to(String(i + 1) as ToKeyParam)),
      map(";").to("0"),
    ]),
    map("a").toVar(NUMBER_LAYER),

    // tab navigation
    map("w").to("tab", ["left_control", "left_shift"]),
    map("r").to("tab", ["control"]),
    map("e").to("w", ["command"]),
    map("t").to("t", ["command"]),

    // copy-paste
    map("c").to("c", ["command"]),
    map("v").to("b", ["command"]),

    // undo-redo
    // map("w").to("z", ["command"]),
    // map("e").to("z", ["command", "shift"]),

    // Brackets: specific modifier combos must come before the plain mapping.
    map("u", ["command"]).to(symbols["<"]),
    map("o", ["command"]).to(symbols[">"]),
    map("u", ["option"]).to(symbols["{"]),
    map("o", ["option"]).to(symbols["}"]),
    map("u", ["left_shift"]).to(symbols["["]),
    map("o", ["left_shift"]).to(symbols["]"]),
    map("u").to(symbols["("]),
    map("o").to(symbols[")"]),
    map("p").to(symbols["="]),
    map("y").to(symbols["/"]),

    // mods
    map("s").to("left_shift"),
    map("d").to("left_option"),
    map("f").to("left_command"),

    map("n", "shift").to("f2", "fn"),
    map("m").to("f18"),
    map("n").to("f19"),

    ...withKey("g", [
      map("i").to(repeatKey("↑", 5)),
      map("k").to(repeatKey("↓", 5)),
      map("j").to(repeatKey("↓", 15)),
      map("l").to(repeatKey("↑", 15)),
      // map("l").to(repeatKey("→", 5)),
    ]),

    // arrows
    map("i").to("↑"),
    map("j").to("←"),
    map("k").to("↓"),
    map("l").to("→"),

    // backspace and enter
    map("h").to("⌫"),
    map(";").to("⏎"),
  ]);
