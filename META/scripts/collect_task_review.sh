#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage:
  ./collect_task_review.sh
  ./collect_task_review.sh <copilot|cursor>

Behavior:
  - Prints review-friendly git information for:
      ./copilot
      ./cursor
  - With a target argument, collects only that repo
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

select_targets() {
  case "${1:-all}" in
    all)
      SELECTED_TARGETS=("copilot" "cursor")
      ;;
    copilot|c)
      SELECTED_TARGETS=("copilot")
      ;;
    cursor)
      SELECTED_TARGETS=("cursor")
      ;;
    *)
      echo "ERROR: unknown target: ${1}" >&2
      echo >&2
      usage >&2
      return 1
      ;;
  esac
}

print_ai_hints() {
  if [[ "${NO_AI_HINT:-0}" == "1" ]]; then
    return 0
  fi

  echo "AI-HINT: after merge/adoption, sync both child repos, then run compare_helix.sh --all and validate_helix.sh"
  echo "AI-HINT: if project state changed, update META/review_log and PROJECT_STATE.md, then run export_snapshot.sh"
  echo "AI-HINT: before runtime reflection, confirm no periodic lock and no scrape-like process"
  echo
}

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
  local repo_collect_script="${repo_dir}/collect_repo_review.sh"

  if [[ -x "${repo_collect_script}" ]]; then
    (cd "${repo_dir}" && ./collect_repo_review.sh)
    return 0
  fi

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

SELECTED_TARGETS=()
if ! select_targets "${1:-all}"; then
  exit 1
fi

print_ai_hints

for target in "${SELECTED_TARGETS[@]}"; do
  case "${target}" in
    copilot)
      print_section "copilot" "${COPILOT_DIR}"
      ;;
    cursor)
      print_section "cursor" "${CURSOR_DIR}"
      ;;
  esac
done
