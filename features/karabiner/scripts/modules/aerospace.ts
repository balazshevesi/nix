import { map } from "karabiner.ts";
import { withKey } from "./utils/withKey.ts";
import { shell as sh } from "./shell";

const a = sh.aero.act;
const mpw = sh.aero.moveToWorkspace;

export const aerospaceBindings = [
  ...withKey("spacebar", [
    // focus windows - i/j/k/l
    map("j").to$(a("focus left")),
    map("k").to$(a("focus down")),
    map("i").to$(a("focus up")),
    map("l").to$(a("focus right")),

    // move windows - i/j/k/l
    map("s").to$(a("move left")),
    map("d").to$(a("move down")),
    map("f").to$(a("move right")),
    map("e").to$(a("move up")),

    // resize windows - n/h
    map("n").to$(a("resize smart -150")),
    map("h").to$(a("resize smart +150")),

    // move window to workspace
    map("1").to$(mpw("1")),
    map("2").to$(mpw("2")),
    map("3").to$(mpw("3")),
    map("4").to$(mpw("4")),
    map("5").to$(mpw("5")),

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
