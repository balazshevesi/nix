export const selectProfile = async (targetProfile: string) => {
  const home = process.env.HOME;

  if (!home) return;

  const configPath = `${home}/.config/karabiner/karabiner.json`;
  const configFile = Bun.file(configPath);

  if (!(await configFile.exists())) return;

  const raw = await configFile.text();
  const data = JSON.parse(raw) as {
    profiles?: Array<{ name?: string; selected?: boolean }>;
  };

  for (const profile of data.profiles ?? []) {
    profile.selected = profile.name === targetProfile;
  }

  await Bun.write(configFile, `${JSON.stringify(data, null, 2)}\n`);
};
