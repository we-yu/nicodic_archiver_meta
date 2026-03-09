#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage:
  ./collect_task_review.sh

Behavior:
  - Prints review-friendly git information for:
      ./copilot
      ./cursor
  - Includes:
      current branch
      git status --short
      staged diff stat
      unstaged diff stat
      recent short log
  - Does not modify anything
EOF
}

if [[ "${1:-}" == "--help" || "${1:-}" == "-h" ]]; then
  usage
  exit 0
fi

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
COPILOT_DIR="${ROOT_DIR}/copilot"
CURSOR_DIR="${ROOT_DIR}/cursor"

if [[ ! -d "${COPILOT_DIR}/.git" ]]; then
  echo "ERROR: copilot repo not found: ${COPILOT_DIR}" >&2
  exit 1
fi

if [[ ! -d "${CURSOR_DIR}/.git" ]]; then
  echo "ERROR: cursor repo not found: ${CURSOR_DIR}" >&2
  exit 1
fi

print_section() {
  local repo_name="$1"
  local repo_dir="$2"

  echo "============================================================"
  echo "REVIEW SNAPSHOT: ${repo_name}"
  echo "repo   : ${repo_dir}"
  echo "branch : $(git -C "${repo_dir}" branch --show-current)"
  echo "============================================================"
  echo
  echo "-- git status --short"
  git -C "${repo_dir}" status --short || true
  echo
  echo "-- staged diff stat"
  git -C "${repo_dir}" diff --cached --stat || true
  echo
  echo "-- unstaged diff stat"
  git -C "${repo_dir}" diff --stat || true
  echo
  echo "-- recent log"
  git -C "${repo_dir}" log --oneline --decorate --graph -5 || true
  echo
}

print_section "copilot" "${COPILOT_DIR}"
print_section "cursor" "${CURSOR_DIR}"
