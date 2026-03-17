#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage:
  ./prepare_task_evidence.sh <adopted_repo> <task_branch_topic> <adopted_commit_msg> <evidence_commit_msg> [--adopted-branch-name <name>]

Example:
  ./prepare_task_evidence.sh cursor task015-run-logging "TASK015: add batch run logging" "TASK015: batch run logging candidate" --adopted-branch-name adopted/task015-run-logging

Behavior:
  - adopted_repo must be: copilot or cursor
  - commits tracked changes in both child repos
  - creates an optional adopted marker branch in the adopted repo
  - does NOT push
  - does NOT merge into main
  - does NOT touch the root meta repository
EOF
}

if [[ "${1:-}" == "--help" || "${1:-}" == "-h" ]]; then
  usage
  exit 0
fi

if [[ $# -lt 4 ]]; then
  usage
  exit 1
fi

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
COPILOT_DIR="${ROOT_DIR}/copilot"
CURSOR_DIR="${ROOT_DIR}/cursor"

ADOPTED_REPO="$1"
TASK_BRANCH_TOPIC="$2"
ADOPTED_COMMIT_MSG="$3"
EVIDENCE_COMMIT_MSG="$4"
shift 4

ADOPTED_MARKER_BRANCH=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --adopted-branch-name)
      ADOPTED_MARKER_BRANCH="${2:-}"
      shift 2
      ;;
    *)
      echo "ERROR: unknown argument: $1" >&2
      usage
      exit 2
      ;;
  esac
done

if [[ "${ADOPTED_REPO}" != "copilot" && "${ADOPTED_REPO}" != "cursor" ]]; then
  echo "ERROR: adopted_repo must be 'copilot' or 'cursor'" >&2
  exit 2
fi

if [[ ! -d "${COPILOT_DIR}/.git" ]]; then
  echo "ERROR: missing repo: ${COPILOT_DIR}" >&2
  exit 2
fi

if [[ ! -d "${CURSOR_DIR}/.git" ]]; then
  echo "ERROR: missing repo: ${CURSOR_DIR}" >&2
  exit 2
fi

if [[ "${ADOPTED_REPO}" == "copilot" ]]; then
  ADOPTED_DIR="${COPILOT_DIR}"
  ADOPTED_NAME="copilot"
  EVIDENCE_DIR="${CURSOR_DIR}"
  EVIDENCE_NAME="cursor"
else
  ADOPTED_DIR="${CURSOR_DIR}"
  ADOPTED_NAME="cursor"
  EVIDENCE_DIR="${COPILOT_DIR}"
  EVIDENCE_NAME="copilot"
fi

need_clean_branch_name_match() {
  local repo_dir="$1"
  local repo_name="$2"
  local current_branch
  current_branch="$(git -C "${repo_dir}" branch --show-current)"
  if [[ "${current_branch}" != "${TASK_BRANCH_TOPIC}-${repo_name}" ]]; then
    echo "ERROR: unexpected branch in ${repo_name}: ${current_branch}" >&2
    echo "Expected: ${TASK_BRANCH_TOPIC}-${repo_name}" >&2
    exit 2
  fi
}

need_clean_branch_name_match "${COPILOT_DIR}" "copilot"
need_clean_branch_name_match "${CURSOR_DIR}" "cursor"

commit_repo_if_needed() {
  local repo_dir="$1"
  local repo_name="$2"
  local commit_msg="$3"

  if git -C "${repo_dir}" diff --quiet && git -C "${repo_dir}" diff --cached --quiet; then
    echo "[${repo_name}] No tracked changes to commit."
    return
  fi

  echo "[${repo_name}] Committing tracked changes..."
  git -C "${repo_dir}" status --short
  git -C "${repo_dir}" add -u
  git -C "${repo_dir}" commit -m "${commit_msg}"
}

echo "== Prepare task evidence =="
echo "root            : ${ROOT_DIR}"
echo "adopted repo    : ${ADOPTED_NAME}"
echo "evidence repo   : ${EVIDENCE_NAME}"
echo "expected branch : ${TASK_BRANCH_TOPIC}-{copilot|cursor}"
echo

commit_repo_if_needed "${ADOPTED_DIR}" "${ADOPTED_NAME}" "${ADOPTED_COMMIT_MSG}"
commit_repo_if_needed "${EVIDENCE_DIR}" "${EVIDENCE_NAME}" "${EVIDENCE_COMMIT_MSG}"

if [[ -n "${ADOPTED_MARKER_BRANCH}" ]]; then
  if git -C "${ADOPTED_DIR}" show-ref --verify --quiet "refs/heads/${ADOPTED_MARKER_BRANCH}"; then
    echo "[${ADOPTED_NAME}] adopted marker branch already exists: ${ADOPTED_MARKER_BRANCH}"
  else
    git -C "${ADOPTED_DIR}" branch "${ADOPTED_MARKER_BRANCH}"
    echo "[${ADOPTED_NAME}] created adopted marker branch: ${ADOPTED_MARKER_BRANCH}"
  fi
fi

echo
echo "Done."
echo "Next suggested manual steps:"
echo "  1. push adopted branch in ${ADOPTED_NAME}"
echo "  2. push evidence branch in ${EVIDENCE_NAME} if desired"
echo "  3. integrate adopted result into child-repo main using repository-compliant method"


