#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage:
  ./prepare_task_evidence.sh <adopted_repo> <task_branch_topic> <adopted_commit_msg> <evidence_commit_msg> [--adopted-branch-name <name>] [--include-file <repo:path>]...

Example:
  ./prepare_task_evidence.sh cursor task015-run-logging "TASK015: add batch run logging" "TASK015: batch run logging candidate" --adopted-branch-name adopted/task015-run-logging --include-file cursor:tests/test_new_case.py --include-file copilot:tests/test_other_case.py

Behavior:
  - adopted_repo must be: copilot or cursor
  - commits tracked changes in both child repos
  - stages explicitly included untracked files via --include-file
  - fails if any non-ignored untracked files remain that were not explicitly included
  - creates an optional adopted marker branch in the adopted repo
  - does NOT push
  - does NOT merge into main
  - does NOT touch the root meta repository

Notes:
  - use repo:path form for --include-file
  - repo must be: copilot or cursor
  - path is relative to that child repo root
  - include only newly created child-repo product files that must be committed
  - do NOT include child-repo report files such as TASKNNN_report.txt by default
  - do NOT include root/meta review artifacts such as META/out/review_snapshot*.txt
  - review/report artifacts are comparison material by default, not evidence-commit targets
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
INCLUDE_FILES=()

while [[ $# -gt 0 ]]; do
  case "$1" in
    --adopted-branch-name)
      ADOPTED_MARKER_BRANCH="${2:-}"
      shift 2
      ;;
    --include-file)
      INCLUDE_FILES+=("${2:-}")
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

parse_include_file() {
  local spec="$1"
  local repo_part path_part

  if [[ "$spec" != *:* ]]; then
    echo "ERROR: --include-file must be in repo:path form. Got: ${spec}" >&2
    exit 2
  fi

  repo_part="${spec%%:*}"
  path_part="${spec#*:}"

  if [[ "$repo_part" != "copilot" && "$repo_part" != "cursor" ]]; then
    echo "ERROR: --include-file repo must be copilot or cursor. Got: ${repo_part}" >&2
    exit 2
  fi

  if [[ -z "$path_part" ]]; then
    echo "ERROR: --include-file path must not be empty. Got: ${spec}" >&2
    exit 2
  fi

  printf '%s\n%s\n' "$repo_part" "$path_part"
}

stage_explicit_untracked_for_repo() {
  local repo_dir="$1"
  local repo_name="$2"
  local spec parsed_repo parsed_path

  for spec in "${INCLUDE_FILES[@]}"; do
    mapfile -t _parsed < <(parse_include_file "$spec")
    parsed_repo="${_parsed[0]}"
    parsed_path="${_parsed[1]}"

    if [[ "$parsed_repo" != "$repo_name" ]]; then
      continue
    fi

    if [[ ! -e "${repo_dir}/${parsed_path}" ]]; then
      echo "ERROR: included file not found in ${repo_name}: ${parsed_path}" >&2
      exit 2
    fi

    git -C "${repo_dir}" add -- "${parsed_path}"
  done
}

fail_on_remaining_untracked() {
  local repo_dir="$1"
  local repo_name="$2"
  mapfile -t _remaining < <(git -C "${repo_dir}" ls-files --others --exclude-standard)

  if [[ "${#_remaining[@]}" -gt 0 ]]; then
    echo "ERROR: ${repo_name} still has untracked files not explicitly included:" >&2
    printf '  %s\n' "${_remaining[@]}" >&2
    echo "Use --include-file ${repo_name}:<path> only for required new product files (for example focused tests), or clean them first." >&2
    echo "Do not include report-only or review-only artifacts by default." >&2  
    exit 2
  fi
}

commit_repo_if_needed() {
  local repo_dir="$1"
  local repo_name="$2"
  local commit_msg="$3"

  stage_explicit_untracked_for_repo "${repo_dir}" "${repo_name}"
  fail_on_remaining_untracked "${repo_dir}" "${repo_name}"

  if git -C "${repo_dir}" diff --quiet && git -C "${repo_dir}" diff --cached --quiet; then
    echo "[${repo_name}] No changes to commit."
    return
  fi

  echo "[${repo_name}] Committing prepared changes..."
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
if [[ -n "${ADOPTED_MARKER_BRANCH}" ]]; then
  echo "  3. push adopted marker branch in ${ADOPTED_NAME}: ${ADOPTED_MARKER_BRANCH}"
  echo "  4. integrate the adopted result into child-repo main using the repository-compliant method"
  echo "  5. in both child repos, checkout main and pull"
else
  echo "  3. integrate the adopted result into child-repo main using the repository-compliant method"
  echo "  4. in both child repos, checkout main and pull"
fi
