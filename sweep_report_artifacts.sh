#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$ROOT_DIR"

APPLY=0
OLDER_THAN_DAYS=3
ARCHIVE_BASE="META/out/report_archive"

usage() {
  cat <<'USAGE'
Usage:
  ./sweep_report_artifacts.sh [--apply] [--older-than-days N] [--archive-dir PATH]

Purpose:
  Move old review/report-only artifacts out of root and child repo working
  areas into a gitignored local archive directory.

Default:
  Dry-run only.
  Targets files whose mtime is at least 3 days old.

Moved candidates:
  - root-level *report*.txt / *report*.md
  - copilot/*report*.txt / copilot/*report*.md
  - cursor/*report*.txt / cursor/*report*.md
  - META/out/review_snapshot*.txt

Safety:
  - tracked files are skipped
  - product/runtime data files such as requirements.txt, targets.txt, and
    scrape_targets.txt are not matched
  - project_snapshot.txt and project_knowledge_snapshot.txt are not matched
  - use --apply to actually move files

Examples:
  ./sweep_report_artifacts.sh
  ./sweep_report_artifacts.sh --apply
  ./sweep_report_artifacts.sh --older-than-days 0 --apply
USAGE
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --apply)
      APPLY=1
      shift
      ;;
    --older-than-days)
      if [[ $# -lt 2 ]]; then
        echo "error: --older-than-days requires a value" >&2
        exit 2
      fi
      OLDER_THAN_DAYS="$2"
      shift 2
      ;;
    --archive-dir)
      if [[ $# -lt 2 ]]; then
        echo "error: --archive-dir requires a value" >&2
        exit 2
      fi
      ARCHIVE_BASE="$2"
      shift 2
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "error: unknown option: $1" >&2
      usage >&2
      exit 2
      ;;
  esac
done

if ! [[ "$OLDER_THAN_DAYS" =~ ^[0-9]+$ ]]; then
  echo "error: --older-than-days must be a non-negative integer" >&2
  exit 2
fi

is_candidate_relpath() {
  local rel="$1"

  case "$rel" in
    copilot/*report*.txt|copilot/*report*.md)
      return 0
      ;;
    cursor/*report*.txt|cursor/*report*.md)
      return 0
      ;;
    META/out/review_snapshot*.txt)
      return 0
      ;;
  esac

  if [[ "$rel" != */* && ( "$rel" == *report*.txt || "$rel" == *report*.md ) ]]; then
    return 0
  fi

  return 1
}

is_tracked_file() {
  local rel="$1"

  if [[ "$rel" == copilot/* ]]; then
    git -C "$ROOT_DIR/copilot" ls-files --error-unmatch "${rel#copilot/}" >/dev/null 2>&1
    return $?
  fi

  if [[ "$rel" == cursor/* ]]; then
    git -C "$ROOT_DIR/cursor" ls-files --error-unmatch "${rel#cursor/}" >/dev/null 2>&1
    return $?
  fi

  git -C "$ROOT_DIR" ls-files --error-unmatch "$rel" >/dev/null 2>&1
}

archive_destination_for() {
  local rel="$1"
  local stamp="$2"
  local safe
  local dest
  local candidate
  local n

  safe="${rel//\//__}"
  dest="${ARCHIVE_BASE}/${stamp}/${safe}"
  candidate="$dest"
  n=1

  while [[ -e "$candidate" ]]; do
    candidate="${dest}.${n}"
    n=$((n + 1))
  done

  printf '%s\n' "$candidate"
}

now_epoch="$(date +%s)"
min_age_seconds=$((OLDER_THAN_DAYS * 86400))
archive_stamp="$(date -u +%Y%m%d)"

checked=0
candidates=0
young=0
tracked=0
moved=0
dry_moves=0

echo "[report-sweep] mode=$([[ "$APPLY" -eq 1 ]] && echo apply || echo dry-run) older_than_days=${OLDER_THAN_DAYS} archive_base=${ARCHIVE_BASE}"

while IFS= read -r -d '' path; do
  rel="${path#./}"
  checked=$((checked + 1))

  if ! is_candidate_relpath "$rel"; then
    continue
  fi

  candidates=$((candidates + 1))

  if is_tracked_file "$rel"; then
    tracked=$((tracked + 1))
    echo "[SKIP tracked] $rel"
    continue
  fi

  mtime_epoch="$(stat -c %Y "$path")"
  age_seconds=$((now_epoch - mtime_epoch))
  if (( age_seconds < min_age_seconds )); then
    young=$((young + 1))
    echo "[SKIP young] $rel age_seconds=${age_seconds}"
    continue
  fi

  dest="$(archive_destination_for "$rel" "$archive_stamp")"

  if [[ "$APPLY" -eq 1 ]]; then
    mkdir -p "$(dirname "$dest")"
    mv "$path" "$dest"
    moved=$((moved + 1))
    echo "[MOVE] $rel -> $dest"
  else
    dry_moves=$((dry_moves + 1))
    echo "[WOULD MOVE] $rel -> $dest"
  fi
done < <(find . \( -path './.git' -o -path './copilot/.git' -o -path './cursor/.git' -o -path './META/out/report_archive' \) -prune -o -type f -print0)

echo "[summary] checked=${checked} candidates=${candidates} moved=${moved} dry_run_moves=${dry_moves} skipped_young=${young} skipped_tracked=${tracked}"
