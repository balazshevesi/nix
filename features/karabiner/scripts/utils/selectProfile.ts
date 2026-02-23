export const selectProfile = async (targetProfile: string) => {
  const home = process.env.HOME;

  if (!home) return;

  const configPath = `${home}/.config/karabiner/karabiner.json`;
  const configFile = Bun.file(configPath);

  if (!(await configFile.exists())) return;

  let data:
    | {
        profiles?: Array<{ name?: string; selected?: boolean }>;
      }
    | undefined;
  let parseError: Error | undefined;

  for (let attempt = 0; attempt < 20; attempt += 1) {
    const raw = await configFile.text();

    if (!raw.trim()) {
      await Bun.sleep(50);
      continue;
    }

    try {
      data = JSON.parse(raw) as {
        profiles?: Array<{ name?: string; selected?: boolean }>;
      };
      break;
    } catch (error) {
      if (error instanceof Error) {
        parseError = error;
      }
      await Bun.sleep(50);
    }
  }

  if (!data) {
    if (parseError) throw parseError;
    return;
  }

  const profiles = data.profiles ?? [];
  const hasTargetProfile = profiles.some(
    (profile) => profile.name === targetProfile,
  );

  if (!hasTargetProfile) return;

  for (const profile of profiles) {
    profile.selected = profile.name === targetProfile;
  }

  await Bun.write(configFile, `${JSON.stringify(data, null, 2)}\n`);
};
