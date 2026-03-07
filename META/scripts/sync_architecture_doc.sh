#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "${SCRIPT_DIR}/../.." && pwd)"
cd "$ROOT_DIR"

SOURCE_FILE="META/ARCHITECTURE.md"
TARGETS=(
  "copilot/docs/ARCHITECTURE.md"
  "cursor/docs/ARCHITECTURE.md"
)

usage() {
  cat <<'USAGE'
Usage:
  ./sync_architecture_doc.sh

Purpose:
  Synchronize the canonical META/ARCHITECTURE.md
  into repository-local copies:

  - copilot/docs/ARCHITECTURE.md
  - cursor/docs/ARCHITECTURE.md

Notes:
  - META/ARCHITECTURE.md is the source-of-truth.
  - This script overwrites target files.
USAGE
}

if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
  usage
  exit 0
fi

if [[ ! -f "$SOURCE_FILE" ]]; then
  echo "ERROR: source file not found: $SOURCE_FILE" >&2
  exit 2
fi

for target in "${TARGETS[@]}"; do
  target_dir="$(dirname "$target")"
  mkdir -p "$target_dir"
  cp -f "$SOURCE_FILE" "$target"
  echo "Synced: $SOURCE_FILE -> $target"
done

echo "Architecture document synchronization complete."

