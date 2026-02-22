import { DEFAULT_PROFILE } from "./constants.ts";

export const selectDefaultProfile = async () => {
  const home = Deno.env.get("HOME");

  if (!home) {
    return;
  }

  const configPath = `${home}/.config/karabiner/karabiner.json`;

  try {
    const raw = await Deno.readTextFile(configPath);
    const data = JSON.parse(raw) as {
      profiles?: Array<{ name?: string; selected?: boolean }>;
    };

    for (const profile of data.profiles ?? []) {
      profile.selected = profile.name === DEFAULT_PROFILE;
    }

    await Deno.writeTextFile(configPath, `${JSON.stringify(data, null, 2)}\n`);
  } catch (error) {
    if (!(error instanceof Deno.errors.NotFound)) {
      throw error;
    }
  }
};
