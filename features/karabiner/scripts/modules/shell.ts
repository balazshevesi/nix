const AEROSPACE_BIN = "/opt/homebrew/bin/aerospace";

const launchApp = (appName: string) => `open -a ${appName}`;

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

const aerospaceAction = (action: AerospaceSubcommand, args?: string) =>
  `${AEROSPACE_BIN} ${action}${args ? ` ${args}` : ""}`;

export const shell = {
  systemSettings: {
    appearance: {
      enableDarkMode: `osascript -e 'tell application "System Events" to tell appearance preferences to set dark mode to true'`,
      enableLightMode: `osascript -e 'tell application "System Events" to tell appearance preferences to set dark mode to false'`,
    },
  },
  apps: {
    closeFocused: `osascript -e \'tell application "System Events" to set frontProc to first application process whose frontmost is true\' -e \'tell application "System Events" to set frontApp to name of frontProc\' -e \'if frontApp is not "Finder" then tell application "System Events" to set visible of frontProc to false\' -e \'if frontApp is not "Finder" then do shell script "killall -9 " & quoted form of frontApp & " >/dev/null 2>&1 &"\'`,
    // launch: (appName: string) => `open -a ${appName}`,
  },
  aero: {
    act: (command: AerospaceCommand) => `${AEROSPACE_BIN} ${command}`,
    moveToWorkspace: (ws: string) =>
      `${aerospaceAction("move-node-to-workspace", ws)}; ${aerospaceAction("workspace", ws)}`,
  },
};
