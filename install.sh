#!/usr/bin/env sh
set -eu

src_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
target_dir="${HOME}/.local/bin"
target="${target_dir}/headroom-meter"

mkdir -p "$target_dir"
cp "${src_dir}/bin/headroom-meter" "$target"
chmod +x "$target"

printf 'Installed headroom-meter to %s\n' "$target"
printf 'Run: headroom-meter\n'
