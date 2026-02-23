const AEROSPACE_BIN = "/opt/homebrew/bin/aerospace";

type Apps = "Chrome" | "Finder";

const launchApp = (appName: Apps) => `open -a ${appName}`;

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

export const shell = {
  systemSettings: {
    appearance: {
      enableDarkMode: `osascript -e 'tell application "System Events" to tell appearance preferences to set dark mode to true'`,
      enableLightMode: `osascript -e 'tell application "System Events" to tell appearance preferences to set dark mode to false'`,
    },
  },
  apps: {
    closeFocused: `osascript -e \'tell application "System Events" to set frontProc to first application process whose frontmost is true\' -e \'tell application "System Events" to set frontApp to name of frontProc\' -e \'if frontApp is not "Finder" then tell application "System Events" to set visible of frontProc to false\' -e \'if frontApp is not "Finder" then do shell script "killall -9 " & quoted form of frontApp & " >/dev/null 2>&1 &"\'`,
    launch: (appName: string) => launchApp,
  },
  aerospace: (...commands: AerospaceCommand[]) =>
    commands.map((cmd) => `${AEROSPACE_BIN} ${cmd}`).join(" && "),
};
