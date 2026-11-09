## Fresh Mac Install

```sh
/bin/bash -c "$(curl --proto '=https' --tlsv1.2 -fsSL https://raw.githubusercontent.com/balazshevesi/nix/main/bootstrap.sh)"
```

## Rebuild

```sh
sudo -H darwin-rebuild switch --flake .#macbook-air-m2 --no-update-lock-file
```

New files imported by the flake must be staged with `git add` before rebuilding;
they do not need to be committed. Rebuild with network access so Nix can download
missing packages. Use `--offline` only when all required inputs and packages are
already cached locally.

Rebuilds install the declared Homebrew packages without uninstalling other apps
or tools installed manually.

## Rift window manager

Rift is installed through Homebrew and started by the Nix-managed user LaunchAgent
`org.nixos.rift`. Do not also install Rift's own service or start it with
`brew services`; Nix manages its startup.

For the first switch, quit AeroSpace, then run the rebuild command above. Grant
`/opt/homebrew/bin/rift` Accessibility access in System Settings → Privacy &
Security. Nix enables "Displays have separate Spaces"; log out and back in if
that setting changed. After granting permission, restart Rift with:

```sh
launchctl kickstart -k "gui/$(id -u)/org.nixos.rift"
rift-cli query displays
```

Edit `features/rift/config/config.toml` and rebuild to change settings. Home Manager
links it into `~/.config/rift/config.toml` as a read-only Nix store file, so make
changes here rather than through Rift's Settings window. If changes do not reload
automatically after a rebuild, run `rift-cli execute config reload`.

Karabiner retains the existing Hyper shortcuts and five workspaces named 1–5.
Hyper + Space + N/H resizes by roughly 5% per step. Hyper + Space + comma/period
selects stack/traditional layout; it no longer cycles orientation. Hyper + Space + Z
is unbound because Rift has no direct equivalent of AeroSpace's tree flattening.
Borders runs independently with the previous colors and width.

To switch back, comment out the Rift imports and uncomment the AeroSpace imports
in `hosts/macbook-air-m2.nix` and `users/balazshevesi.nix`. In
`features/karabiner/scripts/layers/hyperLayer.ts`, comment out `...riftBindings`
and uncomment `...aerospaceBindings`, then rebuild. The AeroSpace configuration
and bindings are preserved. Homebrew cleanup is disabled, so the AeroSpace app
remains installed during the trial.

## Rust

Nix manages Rustup through Homebrew, and Zsh adds it to PATH. On a fresh machine,
initialize the toolchain once after rebuilding and opening a new terminal:

```sh
rustup default stable
rustup component add --toolchain stable rustfmt clippy rust-src rust-analyzer
```

Rustup manages the toolchain under `~/.rustup`, separately from `flake.lock`.

Update the toolchain with `rustup update stable`. After rebuilding, open a new
terminal and try:

```sh
cargo new hello-rust
cd hello-rust
cargo run
cargo fmt
cargo clippy
```

## Codex

Home Manager manages `~/.codex/config.toml` and the global `~/.codex/AGENTS.md` from `features/codex/config/`. Edit those source files and rebuild to update Codex; start a new Codex session to load instruction changes. Project `AGENTS.md` files remain in their repositories.

Before the first switch, back up and move aside the existing unmanaged files so Home Manager can create its symlinks:

```sh
mv ~/.codex/config.toml ~/.codex/config.toml.before-nix
mv ~/.codex/AGENTS.md ~/.codex/AGENTS.md.before-nix
```

The installed files are read-only Nix store symlinks. Codex settings changes that write to `config.toml` must instead be made in this repository. The initial config preserves the existing settings, including app-managed MCP and plugin entries; update machine-specific paths and app-version paths when needed. Authentication remains managed separately through `sops-nix`.

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
