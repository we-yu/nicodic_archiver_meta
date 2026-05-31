#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage:
  ./validate_helix.sh
  ./validate_helix.sh <copilot|cursor>

Behavior:
  - Runs flake8 and pytest in both:
      ./copilot
      ./cursor
  - With a target argument, validates only that repo
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
  local repo_validate_script="${repo_dir}/validate.sh"

  echo "============================================================"
  echo "VALIDATE: ${repo_name}"
  echo "repo   : ${repo_dir}"
  echo "branch : $(git -C "${repo_dir}" branch --show-current)"
  echo "============================================================"

  if [[ -x "${repo_validate_script}" ]]; then
    if (cd "${repo_dir}" && ./validate.sh); then
      echo
      echo "[${repo_name}] RESULT: PASS"
      status=0
    else
      echo
      echo "[${repo_name}] RESULT: FAIL"
      status=1
    fi
  elif (cd "${repo_dir}" && docker compose run --rm scraper sh -lc 'flake8 . && pytest'); then
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

SELECTED_TARGETS=()
if ! select_targets "${1:-all}"; then
  exit 1
fi

COPILOT_STATUS=0
CURSOR_STATUS=0

for target in "${SELECTED_TARGETS[@]}"; do
  case "${target}" in
    copilot)
      if ! run_validation "copilot" "${COPILOT_DIR}"; then
        COPILOT_STATUS=1
      fi
      ;;
    cursor)
      if ! run_validation "cursor" "${CURSOR_DIR}"; then
        CURSOR_STATUS=1
      fi
      ;;
  esac
done

echo "==================== SUMMARY ===================="
if [[ " ${SELECTED_TARGETS[*]} " == *" copilot "* ]]; then
  echo "copilot: $([[ ${COPILOT_STATUS} -eq 0 ]] && echo PASS || echo FAIL)"
fi
if [[ " ${SELECTED_TARGETS[*]} " == *" cursor "* ]]; then
  echo "cursor : $([[ ${CURSOR_STATUS} -eq 0 ]] && echo PASS || echo FAIL)"
fi
echo "================================================="

if [[ ${COPILOT_STATUS} -ne 0 || ${CURSOR_STATUS} -ne 0 ]]; then
  exit 1
fi

exit 0
