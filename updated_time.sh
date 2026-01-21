#!/usr/bin/env bash
set -euo pipefail

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "Error: not inside a git repository."
  exit 1
fi

ym=$(git log -1 --date=format:'%Y-%m' --format=%cd 2>/dev/null || true)

if [[ -z "${ym}" ]]; then
  echo "Error: no git commits found."
  exit 1
fi

mkdir -p data
printf '{ "last_updated": "%s" }\n' "$ym" > data/last_updated.json
echo "Wrote data/last_updated.json: $ym"
