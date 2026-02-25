const SPACE_KEYCODES = {
  1: 18,
  2: 19,
  3: 20,
  4: 21,
  5: 23,
} as const;

const AEROSPACE_BIN = "/opt/homebrew/bin/aerospace";

type SpaceNumber = keyof typeof SPACE_KEYCODES;

const switchSpace = (space: SpaceNumber) =>
  `osascript -e 'tell application "System Events" to key code ${SPACE_KEYCODES[space]} using control down'`;

const nextSpace = `osascript -e 'tell application "System Events" to key code 124 using control down'`;

type AerospaceSubcommand =
  | "balance-sizes"
  | "close"
  | "close-all-windows-but-current"
  | "config"
  | "debug-windows"
  | "enable"
  | "flatten-workspace-tree"
  | "focus"
  | "focus-back-and-forth"
  | "focus-monitor"
  | "fullscreen"
  | "join-with"
  | "layout"
  | "list-apps"
  | "list-exec-env-vars"
  | "list-modes"
  | "list-monitors"
  | "list-windows"
  | "list-workspaces"
  | "macos-native-fullscreen"
  | "macos-native-minimize"
  | "mode"
  | "move"
  | "move-mouse"
  | "move-node-to-monitor"
  | "move-node-to-workspace"
  | "move-workspace-to-monitor"
  | "reload-config"
  | "resize"
  | "split"
  | "summon-workspace"
  | "swap"
  | "trigger-binding"
  | "volume"
  | "workspace"
  | "workspace-back-and-forth";

type AerospaceCommand = `${AerospaceSubcommand}${"" | ` ${string}`}`;

type PaneruDirection = "north" | "south" | "west" | "east" | "first" | "last";

type PaneruWindowAction =
  | `focus ${PaneruDirection}`
  | `swap ${PaneruDirection}`
  | "center"
  | "resize"
  | "fullwidth"
  | "manage"
  | "equalize"
  | "stack"
  | "unstack"
  | "nextdisplay";

type PaneruMouseAction = "nextdisplay";

export type PaneruCommand =
  | "printstate"
  | "quit"
  | `window ${PaneruWindowAction}`
  | `mouse ${PaneruMouseAction}`;

const runPaneru = (command: PaneruCommand) =>
  `PANERU_BIN="$HOME/.nix-profile/bin/paneru"; if [ ! -x "$PANERU_BIN" ]; then PANERU_BIN="/etc/profiles/per-user/$USER/bin/paneru"; fi; if [ ! -x "$PANERU_BIN" ]; then PANERU_BIN="$HOME/.cargo/bin/paneru"; fi; if [ ! -x "$PANERU_BIN" ]; then PANERU_BIN="/opt/homebrew/bin/paneru"; fi; if [ ! -x "$PANERU_BIN" ]; then PANERU_BIN="$(command -v paneru 2>/dev/null)"; fi; [ -x "$PANERU_BIN" ] && "$PANERU_BIN" send-cmd ${command}`;

type Apps = "Chrome" | "Finder";

const launchApp = (appName: Apps) => `open -a ${appName}`;

export const shell = {
  paneru: (...commands: PaneruCommand[]) =>
    commands.map((command) => runPaneru(command)).join(" && "),

  aerospace: (...commands: AerospaceCommand[]) =>
    commands.map((cmd) => `${AEROSPACE_BIN} ${cmd}`).join(" && "),

  systemSettings: {
    workspace: {
      switchTo: (space: SpaceNumber) => switchSpace(space),
      next: nextSpace,
    },
    appearance: {
      enableDarkMode: `osascript -e 'tell application "System Events" to tell appearance preferences to set dark mode to true'`,
      enableLightMode: `osascript -e 'tell application "System Events" to tell appearance preferences to set dark mode to false'`,
    },
  },
  apps: {
    closeFocused: `osascript -e \'tell application "System Events" to set frontProc to first application process whose frontmost is true\' -e \'tell application "System Events" to set frontApp to name of frontProc\' -e \'if frontApp is not "Finder" then tell application "System Events" to set visible of frontProc to false\' -e \'if frontApp is not "Finder" then do shell script "killall -9 " & quoted form of frontApp & " >/dev/null 2>&1 &"\'`,
    launch: (appName: string) => launchApp,
  },
};
