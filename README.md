## Fresh Mac Install

```sh
/bin/bash -c "$(curl --proto '=https' --tlsv1.2 -fsSL https://raw.githubusercontent.com/balazshevesi/nix/main/bootstrap.sh)"
```

## Rebuild

```sh
sudo nix run nix-darwin -- switch --flake .#macbook-air-m2
```

```sh
sudo nix run nix-darwin -- switch --flake .#macbook-air-m2 --no-update-lock-file --offline
```

## Secrets

This repo uses `sops-nix` with age encryption. Encrypted secret files live under `secrets/` and are safe to commit. The private age key is not safe to commit.

Private age key path:

```sh
$HOME/.config/nix/.sops/age/keys.txt
``

That private key decrypts every file in `secrets/`. The `.sops/` directory is gitignored, but back it up somewhere secure before reinstalling macOS. On a fresh machine, restore it to the same path before running the nix-darwin switch.

The matching public recipient is stored in `.sops.yaml`. The public recipient can be committed; only the private key must stay secret.

Decrypt a secret to stdout:

```sh
sops --decrypt --input-type binary --output-type binary secrets/ssh/id_ed25519
```

Write a decrypted secret to a temporary file:

```sh
sops --decrypt --input-type binary --output-type binary secrets/npm/npmrc > /tmp/npmrc
```

Edit an encrypted secret in place:

```sh
SOPS_AGE_KEY_FILE="$HOME/.config/nix/.sops/age/keys.txt" sops secrets/npm/npmrc
```

Re-encrypt a local file into this repo:

```sh
sops --encrypt --filename-override secrets/npm/npmrc --input-type binary --output-type binary "$HOME/.npmrc" > secrets/npm/npmrc
```

Currently restored by `sops-nix`:

- `~/.ssh/id_ed25519`
- `~/.ssh/id_rsa`
- `~/.aws/credentials`
- `~/.npmrc`
- `~/.config/gh/hosts.yml`
- `~/.config/gcloud/application_default_credentials.json`
- `~/.config/gcloud/legacy_credentials/huogyxd@gmail.com/adc.json`
- `~/.config/gcloud/legacy_credentials/huogyxd@gmail.com/.boto`
- `~/.codex/auth.json`
- `~/.config/opencode/antigravity-accounts.json`
- `~/.config/github-copilot/apps.json`

Intentionally not included: Google Cloud token databases, GitHub Copilot auth databases, Docker auth state, and other binary/session state.

## Manual Post-Install Steps

- macOS privacy permissions cannot be fully reproduced declaratively. After the first switch, open the apps once and approve required prompts.

- Check Accessibility/Input Monitoring for Karabiner-Elements, Hammerspoon, AeroSpace, Ghostty, and any editor or terminal that needs automation.

- Check Screen Recording and Full Disk Access for OBS, terminal/editor tools, and other apps that request them.

- Sign into iCloud, App Store, browsers, GitHub, password manager, Slack, Discord, WhatsApp, Spotify, Obsidian sync, Docker, Ledger, and game launchers as needed.

- Restore or sync non-declarative user data separately: GPG keys, browser profiles, Obsidian vaults, Docker volumes, local databases, wallet data, and project checkouts.

## Other 

Install nix
```sh
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

# to do

- [ ] look into how i could maybe use the lastpass cli and maybe gh cli
- [ ] audit codebase
- [ ] Fix the themes for dark-mode Zed and light-mode opencode
