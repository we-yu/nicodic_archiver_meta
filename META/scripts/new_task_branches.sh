#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage:
  ./new_task_branches.sh <task_number> <topic>

Example:
  ./new_task_branches.sh 006 storage-tests
  ./new_task_branches.sh 12 helix-workflow-scripts

Behavior:
  - Creates:
      copilot/taskNNN-topic-copilot
      cursor/taskNNN-topic-cursor
  - Stops if either branch already exists
  - Must be run from the workspace root wrapper or anywhere reachable by wrapper
EOF
}

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
COPILOT_DIR="${ROOT_DIR}/copilot"
CURSOR_DIR="${ROOT_DIR}/cursor"

if [[ "${1:-}" == "--help" || "${1:-}" == "-h" ]]; then
  usage
  exit 0
fi

if [[ $# -ne 2 ]]; then
  usage
  exit 1
fi

TASK_NUMBER_RAW="$1"
TOPIC="$2"

if [[ ! "$TASK_NUMBER_RAW" =~ ^[0-9]+$ ]]; then
  echo "ERROR: task_number must be numeric. Got: ${TASK_NUMBER_RAW}" >&2
  exit 1
fi

if [[ ! "$TOPIC" =~ ^[a-z0-9][a-z0-9-]*$ ]]; then
  echo "ERROR: topic must match ^[a-z0-9][a-z0-9-]*$ . Got: ${TOPIC}" >&2
  exit 1
fi

if [[ ! -d "${COPILOT_DIR}/.git" ]]; then
  echo "ERROR: copilot repo not found: ${COPILOT_DIR}" >&2
  exit 1
fi

if [[ ! -d "${CURSOR_DIR}/.git" ]]; then
  echo "ERROR: cursor repo not found: ${CURSOR_DIR}" >&2
  exit 1
fi

TASK_NUMBER_PADDED="$(printf "%03d" "${TASK_NUMBER_RAW}")"
COPILOT_BRANCH="task${TASK_NUMBER_PADDED}-${TOPIC}-copilot"
CURSOR_BRANCH="task${TASK_NUMBER_PADDED}-${TOPIC}-cursor"

branch_exists() {
  local repo_dir="$1"
  local branch_name="$2"
  git -C "${repo_dir}" show-ref --verify --quiet "refs/heads/${branch_name}"
}

ensure_clean_enough() {
  local repo_dir="$1"
  local repo_name="$2"

  if ! git -C "${repo_dir}" diff --quiet || ! git -C "${repo_dir}" diff --cached --quiet; then
    echo "ERROR: ${repo_name} has tracked changes. Commit/stash/restore before creating task branches." >&2
    exit 1
  fi
}

ensure_clean_enough "${COPILOT_DIR}" "copilot"
ensure_clean_enough "${CURSOR_DIR}" "cursor"

if branch_exists "${COPILOT_DIR}" "${COPILOT_BRANCH}"; then
  echo "ERROR: branch already exists in copilot: ${COPILOT_BRANCH}" >&2
  exit 1
fi

if branch_exists "${CURSOR_DIR}" "${CURSOR_BRANCH}"; then
  echo "ERROR: branch already exists in cursor: ${CURSOR_BRANCH}" >&2
  exit 1
fi

echo "== Create task branches =="
echo "  root   : ${ROOT_DIR}"
echo "  copilot: ${COPILOT_BRANCH}"
echo "  cursor : ${CURSOR_BRANCH}"
echo

git -C "${COPILOT_DIR}" switch -c "${COPILOT_BRANCH}"
git -C "${CURSOR_DIR}" switch -c "${CURSOR_BRANCH}"

echo
echo "Created branches successfully."
echo "  copilot current branch: $(git -C "${COPILOT_DIR}" branch --show-current)"
echo "  cursor  current branch: $(git -C "${CURSOR_DIR}" branch --show-current)"
