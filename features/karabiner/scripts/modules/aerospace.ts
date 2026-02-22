import { map } from "karabiner.ts";
import { withKey } from "./utils.ts";
const AEROSPACE_BIN = "/opt/homebrew/bin/aerospace";

export const a = (command: string) => `${AEROSPACE_BIN} ${command}`;
export const moveToWorkspace = (workspace: string) =>
  `${a(`move-node-to-workspace ${workspace}`)}; ${a(`workspace ${workspace}`)}`;

export const aerospaceMainBindings = [
  ...withKey("spacebar", [
    map("j").to$(a("focus left")),
    map("k").to$(a("focus down")),
    map("i").to$(a("focus up")),
    map("l").to$(a("focus right")),

    map("s").to$(a("move left")),
    map("d").to$(a("move down")),
    map("f").to$(a("move right")),
    map("e").to$(a("move up")),

    map("n").to$(a("resize smart -150")),
    map("h").to$(a("resize smart +150")),

    map("1").to$(moveToWorkspace("1")),
    map("2").to$(moveToWorkspace("2")),
    map("3").to$(moveToWorkspace("3")),
    map("4").to$(moveToWorkspace("4")),
    map("5").to$(moveToWorkspace("5")),

    map(";").to$(a("fullscreen")),

    map("comma").to$(a("layout accordion horizontal vertical")),
    map("period").to$(a("layout tiles horizontal vertical")),
    map("m").to$(a("layout floating tiling")),
    map("q").to$(a("balance-sizes")),
    map("z").to$(a("flatten-workspace-tree")),
  ]),
  map("1").to$(a("workspace 1")),
  map("2").to$(a("workspace 2")),
  map("3").to$(a("workspace 3")),
  map("4").to$(a("workspace 4")),
  map("5").to$(a("workspace 5")),

  map("tab").to$(a("workspace-back-and-forth")),
];
