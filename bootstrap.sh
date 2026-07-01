#!/usr/bin/env bash
set -euo pipefail

repo_url="https://github.com/balazshevesi/nix"
config_dir="$HOME/.config/nix"
flake_host="macbook-air-m2"

if ! command -v nix >/dev/null 2>&1; then
  curl --proto "=https" --tlsv1.2 -sSf -L https://install.determinate.systems/nix \
    | sh -s -- install --determinate --no-confirm
fi

if [ -f /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]; then
  # shellcheck disable=SC1091
  . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
fi

mkdir -p "$(dirname "$config_dir")"

if [ -d "$config_dir/.git" ]; then
  nix shell nixpkgs#git --command git -C "$config_dir" pull --ff-only
else
  rm -rf "$config_dir"
  nix shell nixpkgs#git --command git clone "$repo_url" "$config_dir"
fi

nix run nix-darwin -- switch --flake "$config_dir#$flake_host"
