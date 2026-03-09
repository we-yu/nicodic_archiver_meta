#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage:
  ./validate_helix.sh

Behavior:
  - Runs flake8 and pytest in both:
      ./copilot
      ./cursor
  - Continues even if one side fails
  - Prints per-repo summary
  - Returns non-zero if either repo fails
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

run_validation() {
  local repo_name="$1"
  local repo_dir="$2"
  local status=0

  echo "============================================================"
  echo "VALIDATE: ${repo_name}"
  echo "repo   : ${repo_dir}"
  echo "branch : $(git -C "${repo_dir}" branch --show-current)"
  echo "============================================================"

  if (cd "${repo_dir}" && docker compose run --rm scraper sh -lc 'flake8 . && pytest'); then
    echo
    echo "[${repo_name}] RESULT: PASS"
    status=0
  else
    echo
    echo "[${repo_name}] RESULT: FAIL"
    status=1
  fi

  echo
  return "${status}"
}

COPILOT_STATUS=0
CURSOR_STATUS=0

if ! run_validation "copilot" "${COPILOT_DIR}"; then
  COPILOT_STATUS=1
fi

if ! run_validation "cursor" "${CURSOR_DIR}"; then
  CURSOR_STATUS=1
fi

echo "==================== SUMMARY ===================="
echo "copilot: $([[ ${COPILOT_STATUS} -eq 0 ]] && echo PASS || echo FAIL)"
echo "cursor : $([[ ${CURSOR_STATUS} -eq 0 ]] && echo PASS || echo FAIL)"
echo "================================================="

if [[ ${COPILOT_STATUS} -ne 0 || ${CURSOR_STATUS} -ne 0 ]]; then
  exit 1
fi

exit 0
