#!/usr/bin/env bash
set -euo pipefail

repo_url="https://github.com/balazshevesi/nix"
config_dir="$HOME/.config/nix"
flake_host="macbook-air-m2"
sops_age_key_file="$HOME/.config/nix/.sops/age/keys.txt"

if ! sudo -v; then
  echo "Administrator privileges are required to switch the nix-darwin system." >&2
  exit 1
fi

while true; do
  sudo -n true
  sleep 60
done 2>/dev/null &
sudo_keepalive_pid="$!"
trap 'kill "$sudo_keepalive_pid" 2>/dev/null || true' EXIT

if ! xcode-select -p >/dev/null 2>&1; then
  echo "Installing Xcode Command Line Tools. Complete the Apple installer, then rerun this script." >&2
  xcode-select --install 2>/dev/null || true
  exit 1
fi

if [ "$(/usr/bin/uname -m)" = "arm64" ] && ! /usr/bin/pgrep oahd >/dev/null 2>&1; then
  sudo /usr/sbin/softwareupdate --install-rosetta --agree-to-license
fi

if ! command -v nix >/dev/null 2>&1; then
  curl --proto "=https" --tlsv1.2 -sSf -L https://install.determinate.systems/nix \
    | sh -s -- install --determinate --no-confirm
fi

if [ -f /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]; then
  # shellcheck disable=SC1091
  . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
fi

if ! command -v brew >/dev/null 2>&1; then
  NONINTERACTIVE=1 /bin/bash -c "$(curl --proto '=https' --tlsv1.2 -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -x /usr/local/bin/brew ]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

mkdir -p "$(dirname "$config_dir")"

if [ -d "$config_dir/.git" ]; then
  nix shell nixpkgs#git --command git -C "$config_dir" pull --ff-only
else
  rm -rf "$config_dir"
  nix shell nixpkgs#git --command git clone "$repo_url" "$config_dir"
fi

if [ -d "$config_dir/secrets" ] && [ ! -f "$sops_age_key_file" ]; then
  echo "Missing SOPS age key: $sops_age_key_file" >&2
  echo "Restore that private key, then rerun this script." >&2
  exit 1
fi

sudo nix run nix-darwin -- switch --flake "$config_dir#$flake_host"
