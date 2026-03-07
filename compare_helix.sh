#!/usr/bin/env bash
set -euo pipefail

# Compare copilot/ and cursor/ repositories for "helix convergence".
# Default: compare files that affect runtime/reproducibility (not only *.py).
#
# Exit codes:
#   0 = match (converged)
#   1 = mismatch
#   2 = error (missing dirs, missing git, etc.)

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
COPILOT_DIR="${ROOT_DIR}/copilot"
CURSOR_DIR="${ROOT_DIR}/cursor"

usage() {
  cat <<'USAGE'
Usage:
  ./compare_helix.sh [--py-only] [--all] [--show-diff]

Options:
  --py-only    Compare only *.py files.
  --all        Compare all git-tracked files (excluding data/, caches).
  --show-diff  If mismatch, show unified diff for changed files (may be long).

Default:
  Compare "code + reproducibility" files:
    *.py, requirements*.txt, .flake8, Dockerfile, docker-compose.yml, Makefile,
    .github/workflows/*.yml, *.sh, README.md, docs/**/*.md

USAGE
}

MODE="default"
SHOW_DIFF="0"

for arg in "${@:-}"; do
  case "$arg" in
    --py-only) MODE="py" ;;
    --all) MODE="all" ;;
    --show-diff) SHOW_DIFF="1" ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown option: $arg" >&2; usage; exit 2 ;;
  esac
done

if [ ! -d "$COPILOT_DIR/.git" ] || [ ! -d "$CURSOR_DIR/.git" ]; then
  echo "ERROR: copilot/ or cursor/ is not a git repository." >&2
  echo "  COPILOT_DIR=$COPILOT_DIR" >&2
  echo "  CURSOR_DIR=$CURSOR_DIR" >&2
  exit 2
fi

need_cmd() { command -v "$1" >/dev/null 2>&1 || { echo "ERROR: missing command: $1" >&2; exit 2; }; }
need_cmd git
need_cmd sha256sum
need_cmd sort
need_cmd comm
need_cmd awk

# Create a filtered file list from git ls-files.
# Note: We always ignore data/ and caches even in --all mode.
make_file_list() {
  local repo_dir="$1"
  local mode="$2"

  git -C "$repo_dir" ls-files \
    | awk '
      BEGIN { }
      {
        # hard excludes
        if ($0 ~ /^data\//) next
        if ($0 ~ /\/__pycache__\//) next
        if ($0 ~ /\/\.pytest_cache\//) next
        if ($0 ~ /\.pyc$/) next
        if ($0 == "project_snapshot.txt") next
        if ($0 == "project_knowledge_snapshot.txt") next
        print
      }
    ' \
    | awk -v m="$mode" '
      function keep_default(p) {
        if (p ~ /\.py$/) return 1
        if (p ~ /^requirements.*\.txt$/) return 1
        if (p == ".flake8") return 1
        if (p == "Dockerfile") return 1
        if (p == "docker-compose.yml") return 1
        if (p == "Makefile") return 1
        if (p ~ /^\.github\/workflows\/.*\.ya?ml$/) return 1
        if (p ~ /\.sh$/) return 1
        if (p == "README.md") return 1
        if (p ~ /^docs\/.*\.md$/) return 1
        return 0
      }
      {
        if (m == "all") { print; next }
        if (m == "py")  { if ($0 ~ /\.py$/) print; next }
        if (m == "default") { if (keep_default($0)) print; next }
      }
    ' \
    | sort
}

TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

LIST_COPILOT="$TMP_DIR/list_copilot.txt"
LIST_CURSOR="$TMP_DIR/list_cursor.txt"
HASH_COPILOT="$TMP_DIR/hash_copilot.txt"
HASH_CURSOR="$TMP_DIR/hash_cursor.txt"

make_file_list "$COPILOT_DIR" "$MODE" > "$LIST_COPILOT"
make_file_list "$CURSOR_DIR" "$MODE" > "$LIST_CURSOR"

echo "== Helix Compare =="
echo "  mode: $MODE"
echo "  copilot: $COPILOT_DIR"
echo "  cursor : $CURSOR_DIR"
echo ""

# 1) Check file list differences
ONLY_IN_COPILOT="$TMP_DIR/only_in_copilot.txt"
ONLY_IN_CURSOR="$TMP_DIR/only_in_cursor.txt"

comm -23 "$LIST_COPILOT" "$LIST_CURSOR" > "$ONLY_IN_COPILOT" || true
comm -13 "$LIST_COPILOT" "$LIST_CURSOR" > "$ONLY_IN_CURSOR" || true

if [ -s "$ONLY_IN_COPILOT" ] || [ -s "$ONLY_IN_CURSOR" ]; then
  echo "MISMATCH: file list differs."
  if [ -s "$ONLY_IN_COPILOT" ]; then
    echo "--- Only in copilot ---"
    cat "$ONLY_IN_COPILOT"
    echo ""
  fi
  if [ -s "$ONLY_IN_CURSOR" ]; then
    echo "--- Only in cursor ---"
    cat "$ONLY_IN_CURSOR"
    echo ""
  fi
  exit 1
fi

# 2) Hash compare for file contents
# Produce lines: "<hash>  <path>"
while IFS= read -r p; do
  (cd "$COPILOT_DIR" && sha256sum "$p") >> "$HASH_COPILOT"
done < "$LIST_COPILOT"

while IFS= read -r p; do
  (cd "$CURSOR_DIR" && sha256sum "$p") >> "$HASH_CURSOR"
done < "$LIST_CURSOR"

# Convert to: "<path> <hash>" for easier join
awk '{print $2 " " $1}' "$HASH_COPILOT" | sort > "$HASH_COPILOT.sorted"
awk '{print $2 " " $1}' "$HASH_CURSOR" | sort > "$HASH_CURSOR.sorted"

# Diff hashes by path
CHANGED="$TMP_DIR/changed.txt"
join -a1 -a2 -e "MISSING" -o "0,1.2,2.2" "$HASH_COPILOT.sorted" "$HASH_CURSOR.sorted" \
  | awk '$2 != $3 {print $0}' > "$CHANGED" || true

if [ -s "$CHANGED" ]; then
  echo "MISMATCH: file contents differ."
  echo "Format: <path> <copilot_hash> <cursor_hash>"
  cat "$CHANGED"
  echo ""

  if [ "$SHOW_DIFF" = "1" ]; then
    echo "---- Unified diffs (copilot vs cursor) ----"
    while IFS= read -r line; do
      path="$(echo "$line" | awk '{print $1}')"
      echo "### DIFF: $path"
      diff -u "$COPILOT_DIR/$path" "$CURSOR_DIR/$path" || true
      echo ""
    done < "$CHANGED"
  else
    echo "Tip: run with --show-diff to see unified diffs."
    echo "  ./compare_helix.sh --show-diff"
    echo ""
  fi

  exit 1
fi

echo "OK: copilot/ and cursor/ match for selected files."
echo "=> Helix converged (lower-end merge point confirmed)."
exit 0

