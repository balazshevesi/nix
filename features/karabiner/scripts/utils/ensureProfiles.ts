import { mkdir } from "node:fs/promises";

type KarabinerProfile = {
  name?: string;
  selected?: boolean;
  complex_modifications?: {
    rules?: unknown[];
  };
  [key: string]: unknown;
};

type KarabinerConfig = {
  profiles?: KarabinerProfile[];
  [key: string]: unknown;
};

const clone = <T>(value: T): T => JSON.parse(JSON.stringify(value)) as T;

const buildProfile = (
  profileName: string,
  template?: KarabinerProfile,
): KarabinerProfile => {
  if (!template) {
    return {
      name: profileName,
      selected: false,
      complex_modifications: { rules: [] },
    };
  }

  const nextProfile = clone(template);
  delete nextProfile.name;
  delete nextProfile.selected;
  delete nextProfile.complex_modifications;

  return {
    ...nextProfile,
    name: profileName,
    selected: false,
    complex_modifications: { rules: [] },
  };
};

export const ensureProfiles = async (profileNames: string[]) => {
  const home = process.env.HOME;

  if (!home) return;

  const configDir = `${home}/.config/karabiner`;
  const configPath = `${configDir}/karabiner.json`;
  const configFile = Bun.file(configPath);

  let data: KarabinerConfig = { profiles: [] };

  if (await configFile.exists()) {
    const raw = await configFile.text();
    if (raw.trim()) {
      data = JSON.parse(raw) as KarabinerConfig;
    }
  }

  if (!Array.isArray(data.profiles)) {
    data.profiles = [];
  }

  const profiles = data.profiles;
  const profileNamesSet = new Set(
    profiles
      .map((profile) => profile.name)
      .filter((name): name is string => typeof name === "string"),
  );
  const templateProfile =
    profiles.find((profile) => profile.selected) ?? profiles[0];

  let updated = false;

  for (const profileName of profileNames) {
    if (profileNamesSet.has(profileName)) {
      continue;
    }

    profiles.push(buildProfile(profileName, templateProfile));
    profileNamesSet.add(profileName);
    updated = true;
  }

  if (!updated) return;

  await mkdir(configDir, { recursive: true });
  await Bun.write(configFile, `${JSON.stringify(data, null, 2)}\n`);
};
