#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
COPILOT_DIR="${ROOT_DIR}/copilot"
CURSOR_DIR="${ROOT_DIR}/cursor"

MODE="default"
SHOW_DIFF="0"

usage() {
  cat <<'USAGE'
Usage:
  ./compare_helix.sh [--py-only] [--all] [--show-diff]

Options:
  --py-only    Compare only *.py files.
  --all        Compare all git-tracked files (excluding data/, caches).
  --show-diff  If mismatch, show unified diff for changed files (may be long).

Note:
  This script compares git-tracked files via git ls-files.
  Newly created files must be added with git add before they appear in comparison results.

Default:
  Compare "code + reproducibility" files:
    *.py, requirements*.txt, .flake8, Dockerfile, docker-compose.yml, Makefile,
    .github/workflows/*.yml, *.sh, README.md, docs/**/*.md

USAGE
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --py-only)
      MODE="py"
      shift
      ;;
    --all)
      MODE="all"
      shift
      ;;
    --show-diff)
      SHOW_DIFF="1"
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "ERROR: unknown option: $1" >&2
      usage
      exit 2
      ;;
  esac
done

need_cmd() {
  command -v "$1" >/dev/null 2>&1 || {
    echo "ERROR: missing command: $1" >&2
    exit 2
  }
}

need_cmd git
need_cmd diff
need_cmd sort
need_cmd comm
need_cmd sha256sum
need_cmd mktemp

if [[ ! -d "${COPILOT_DIR}/.git" ]]; then
  echo "ERROR: missing git repo: ${COPILOT_DIR}" >&2
  exit 2
fi

if [[ ! -d "${CURSOR_DIR}/.git" ]]; then
  echo "ERROR: missing git repo: ${CURSOR_DIR}" >&2
  exit 2
fi

tmp_copilot="$(mktemp)"
tmp_cursor="$(mktemp)"
tmp_only_copilot="$(mktemp)"
tmp_only_cursor="$(mktemp)"
tmp_common="$(mktemp)"
diff_list="$(mktemp)"

cleanup() {
  rm -f "$tmp_copilot" "$tmp_cursor" "$tmp_only_copilot" "$tmp_only_cursor" "$tmp_common" "$diff_list"
}
trap cleanup EXIT

collect_files() {
  local repo_dir="$1"

  if [[ "$MODE" == "py" ]]; then
    git -C "$repo_dir" ls-files | grep -E '\.py$' | sort -u || true
    return
  fi

  if [[ "$MODE" == "all" ]]; then
    git -C "$repo_dir" ls-files | sort -u
    return
  fi

  git -C "$repo_dir" ls-files | grep -E '(^|/)([^/]+\.py|requirements[^/]*\.txt|\.flake8|Dockerfile|docker-compose\.yml|Makefile|README\.md|[^/]+\.sh|docs/.*\.md|\.github/workflows/.*\.ya?ml)$' | sort -u || true
}

collect_files "${COPILOT_DIR}" > "$tmp_copilot"
collect_files "${CURSOR_DIR}" > "$tmp_cursor"

echo "== Helix Compare =="
echo "  mode: ${MODE}"
echo "  copilot: ${COPILOT_DIR}"
echo "  cursor : ${CURSOR_DIR}"
echo ""

comm -23 "$tmp_copilot" "$tmp_cursor" > "$tmp_only_copilot" || true
comm -13 "$tmp_copilot" "$tmp_cursor" > "$tmp_only_cursor" || true
comm -12 "$tmp_copilot" "$tmp_cursor" > "$tmp_common" || true

if [[ -s "$tmp_only_copilot" || -s "$tmp_only_cursor" ]]; then
  echo "MISMATCH: file list differs."

  if [[ -s "$tmp_only_copilot" ]]; then
    echo "--- Only in copilot ---"
    cat "$tmp_only_copilot"
    echo ""
  fi

  if [[ -s "$tmp_only_cursor" ]]; then
    echo "--- Only in cursor ---"
    cat "$tmp_only_cursor"
    echo ""
  fi

  exit 1
fi

mismatch_found="0"
: > "$diff_list"

while IFS= read -r rel_path; do
  [[ -z "$rel_path" ]] && continue

  copilot_hash="$(sha256sum "${COPILOT_DIR}/${rel_path}" | awk '{print $1}')"
  cursor_hash="$(sha256sum "${CURSOR_DIR}/${rel_path}" | awk '{print $1}')"

  if [[ "$copilot_hash" != "$cursor_hash" ]]; then
    if [[ "$mismatch_found" == "0" ]]; then
      echo "MISMATCH: file contents differ."
      echo "Format: <path> <copilot_hash> <cursor_hash>"
    fi
    mismatch_found="1"
    echo "${rel_path} ${copilot_hash} ${cursor_hash}"
    echo "$rel_path" >> "$diff_list"
  fi
done < "$tmp_common"

if [[ "$mismatch_found" == "1" ]]; then
  if [[ "$SHOW_DIFF" == "1" ]]; then
    echo ""
    echo "---- Unified diffs (copilot vs cursor) ----"
    while IFS= read -r rel_path; do
      [[ -z "$rel_path" ]] && continue
      echo "### DIFF: ${rel_path}"
      diff -u "${COPILOT_DIR}/${rel_path}" "${CURSOR_DIR}/${rel_path}" || true
      echo ""
    done < "$diff_list"
  fi
  exit 1
fi

echo "OK: copilot/ and cursor/ match for selected files."
echo "=> Helix converged (lower-end merge point confirmed)."



