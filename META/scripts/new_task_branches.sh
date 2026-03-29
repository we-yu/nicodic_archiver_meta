#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage:
  ./new_task_branches.sh <task_label> <topic>

Examples:
  ./new_task_branches.sh 006 storage-tests
  ./new_task_branches.sh 12 helix-workflow-scripts
  ./new_task_branches.sh 031b append-telemetry

Behavior:
  - Creates:
      copilot/task<label>-topic-copilot
      cursor/task<label>-topic-cursor
  - Numeric-only labels are zero-padded to 3 digits:
      6   -> task006-...
      12  -> task012-...
      031 -> task031-...
  - Alphanumeric labels with a trailing lowercase suffix are preserved
    after numeric padding:
      31b   -> task031b-...
      031b  -> task031b-...
      7x    -> task007x-...
  - Stops if either branch already exists
  - Refuses to proceed if either child repo has tracked changes
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

TASK_LABEL_RAW="$1"
TOPIC="$2"

if [[ ! "$TASK_LABEL_RAW" =~ ^([0-9]+)([a-z]?)$ ]]; then
  echo "ERROR: task_label must match ^([0-9]+)([a-z]?)$ . Got: ${TASK_LABEL_RAW}" >&2
  exit 1
fi

TASK_NUMBER_RAW="${BASH_REMATCH[1]}"
TASK_SUFFIX="${BASH_REMATCH[2]}"

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

TASK_NUMBER_NORMALIZED="${TASK_NUMBER_RAW#0}"
if [[ -z "${TASK_NUMBER_NORMALIZED}" ]]; then
  TASK_NUMBER_NORMALIZED="0"
fi

TASK_NUMBER_PADDED="$(printf "%03d" "$((10#${TASK_NUMBER_NORMALIZED}))")"
TASK_LABEL_NORMALIZED="${TASK_NUMBER_PADDED}${TASK_SUFFIX}"

COPILOT_BRANCH="task${TASK_LABEL_NORMALIZED}-${TOPIC}-copilot"
CURSOR_BRANCH="task${TASK_LABEL_NORMALIZED}-${TOPIC}-cursor"

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
echo "  label  : ${TASK_LABEL_NORMALIZED}"
echo "  copilot: ${COPILOT_BRANCH}"
echo "  cursor : ${CURSOR_BRANCH}"
echo

git -C "${COPILOT_DIR}" switch -c "${COPILOT_BRANCH}"
git -C "${CURSOR_DIR}" switch -c "${CURSOR_BRANCH}"

echo
echo "Done."
echo "Next:"
echo "  ./collect_task_review.sh"


