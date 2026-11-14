#!/usr/bin/env bash
# One-time setup: ./setup.sh <github-username-or-org>
# Writes your GitHub owner into the files that need it.
set -euo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")"

OWNER="${1:-}"
if [ -z "$OWNER" ]; then
  echo "usage: ./setup.sh <github-username-or-org>" >&2
  exit 1
fi
OWNER_LC="$(printf '%s' "$OWNER" | tr '[:upper:]' '[:lower:]')"

sed -i "s|^REPO_ORGANIZATION=.*|REPO_ORGANIZATION=\"$OWNER\"|" image-template.env
sed -i "s|CHANGE-ME|$OWNER|g" image-template.env
sed -i "s|ghcr.io/[^/]*/sanad:latest|ghcr.io/$OWNER_LC/sanad:latest|" disk_config/iso.toml

echo "Done. Owner: $OWNER"
echo "Next: create a GitHub repo named 'sanad', push this folder, then run the workflows (see README.ar.md)."
