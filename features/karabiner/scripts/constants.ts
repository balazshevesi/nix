export const DEFAULT_PROFILE = "standard - colemak";
export const AEROSPACE_BIN = "/opt/homebrew/bin/aerospace";

export const aerospace = (command: string) => `${AEROSPACE_BIN} ${command}`;

export const moveToWorkspace = (workspace: string) =>
  `${aerospace(`move-node-to-workspace ${workspace}`)}; ${aerospace(
    `workspace ${workspace}`,
  )}`;
