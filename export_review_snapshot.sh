#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
COPILOT_DIR="${ROOT_DIR}/copilot"
CURSOR_DIR="${ROOT_DIR}/cursor"

OUT_FILE="${1:-review_snapshot.txt}"

usage() {
  cat <<'USAGE'
Usage:
  ./export_review_snapshot.sh [output_file]

Purpose:
  Export a review-oriented snapshot for comparing copilot/ and cursor/
  during a task implementation review.

Default output:
  review_snapshot.txt

What it includes:
  - repo branch / HEAD / recent commits
  - git status --short --branch
  - git diff --stat / git diff
  - git diff --cached --stat / git diff --cached
  - untracked files
  - synthetic unified diffs for untracked review-target files
  - file contents for changed / staged / untracked review-relevant files

Notes:
  - This is NOT the authoritative project snapshot.
  - Use project_snapshot.txt for source-of-truth restoration.
  - This file is meant for AI/human review during comparison.
  - This script does NOT run git add or modify repository state.

USAGE
}

if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
  usage
  exit 0
fi

need_cmd() {
  command -v "$1" >/dev/null 2>&1 || {
    echo "ERROR: missing command: $1" >&2
    exit 2
  }
}

need_cmd git
need_cmd sort
need_cmd uniq
need_cmd sed
need_cmd awk
need_cmd mktemp

if [[ ! -d "${COPILOT_DIR}/.git" ]]; then
  echo "ERROR: missing git repo: ${COPILOT_DIR}" >&2
  exit 2
fi

if [[ ! -d "${CURSOR_DIR}/.git" ]]; then
  echo "ERROR: missing git repo: ${CURSOR_DIR}" >&2
  exit 2
fi

: > "${OUT_FILE}"

append_line() {
  echo "$1" >> "${OUT_FILE}"
}

append_block_title() {
  append_line ""
  append_line "=================================================="
  append_line "$1"
  append_line "=================================================="
}

append_file_if_exists() {
  local repo_dir="$1"
  local rel_path="$2"

  if [[ -f "${repo_dir}/${rel_path}" ]]; then
    append_line ""
    append_line "------------------------------"
    append_line "FILE: ${rel_path}"
    append_line "------------------------------"
    cat "${repo_dir}/${rel_path}" >> "${OUT_FILE}"
    append_line ""
  fi
}

is_review_target_file() {
  local path="$1"

  case "$path" in
    *.py|*.md|*.sh|Dockerfile|docker-compose.yml|Makefile|.flake8|requirements*.txt|.github/workflows/*.yml|.github/workflows/*.yaml)
      return 0
      ;;
    *)
      return 1
      ;;
  esac
}

collect_candidate_files() {
  local repo_dir="$1"
  local tmp_file="$2"

  {
    git -C "${repo_dir}" diff --name-only
    git -C "${repo_dir}" diff --cached --name-only
    git -C "${repo_dir}" ls-files --others --exclude-standard
  } | awk 'NF' | sort -u > "${tmp_file}"
}

append_untracked_diffs() {
  local repo_dir="$1"
  local found="0"

  append_line "--- UNTRACKED FILE DIFFS (synthetic unified diffs) ---"

  while IFS= read -r rel_path; do
    [[ -z "${rel_path}" ]] && continue

    if is_review_target_file "${rel_path}" && [[ -f "${repo_dir}/${rel_path}" ]]; then
      found="1"
      append_line ""
      append_line "------------------------------"
      append_line "UNTRACKED DIFF: ${rel_path}"
      append_line "------------------------------"
      git -C "${repo_dir}" diff --no-index -- /dev/null "${rel_path}" >> "${OUT_FILE}" || true
      append_line ""
    fi
  done < <(git -C "${repo_dir}" ls-files --others --exclude-standard)

  if [[ "${found}" == "0" ]]; then
    append_line "(no untracked review-target files)"
    append_line ""
  fi
}

append_repo_section() {
  local repo_name="$1"
  local repo_dir="$2"

  local tmp_candidates
  tmp_candidates="$(mktemp)"

  append_block_title "REPO: ${repo_name}"

  append_line "PATH: ${repo_dir}"
  append_line "BRANCH: $(git -C "${repo_dir}" branch --show-current)"
  append_line "HEAD: $(git -C "${repo_dir}" rev-parse HEAD)"
  append_line ""

  append_line "--- RECENT COMMITS (git log --oneline -n 5) ---"
  git -C "${repo_dir}" log --oneline -n 5 >> "${OUT_FILE}" || true
  append_line ""

  append_line "--- STATUS (git status --short --branch) ---"
  git -C "${repo_dir}" status --short --branch >> "${OUT_FILE}" || true
  append_line ""

  append_line "--- DIFF STAT (git diff --stat) ---"
  git -C "${repo_dir}" diff --stat >> "${OUT_FILE}" || true
  append_line ""

  append_line "--- DIFF (git diff) ---"
  git -C "${repo_dir}" diff >> "${OUT_FILE}" || true
  append_line ""

  append_line "--- CACHED DIFF STAT (git diff --cached --stat) ---"
  git -C "${repo_dir}" diff --cached --stat >> "${OUT_FILE}" || true
  append_line ""

  append_line "--- CACHED DIFF (git diff --cached) ---"
  git -C "${repo_dir}" diff --cached >> "${OUT_FILE}" || true
  append_line ""

  append_line "--- UNTRACKED FILES (git ls-files --others --exclude-standard) ---"
  git -C "${repo_dir}" ls-files --others --exclude-standard >> "${OUT_FILE}" || true
  append_line ""

  append_untracked_diffs "${repo_dir}"

  collect_candidate_files "${repo_dir}" "${tmp_candidates}"

  append_line "--- REVIEW TARGET FILE CONTENTS ---"

  if [[ ! -s "${tmp_candidates}" ]]; then
    append_line "(no changed/staged/untracked files)"
    append_line ""
    rm -f "${tmp_candidates}"
    return
  fi

  while IFS= read -r rel_path; do
    [[ -z "${rel_path}" ]] && continue

    if is_review_target_file "${rel_path}"; then
      append_file_if_exists "${repo_dir}" "${rel_path}"
    fi
  done < "${tmp_candidates}"

  rm -f "${tmp_candidates}"
}

append_block_title "REVIEW SNAPSHOT"
append_line "generated: $(date)"
append_line "root: ${ROOT_DIR}"
append_line "output: ${OUT_FILE}"
append_line ""
append_line "This file is review-oriented and may include uncommitted changes."
append_line "Use project_snapshot.txt as the authoritative source-of-truth snapshot."

append_repo_section "copilot" "${COPILOT_DIR}"
append_repo_section "cursor" "${CURSOR_DIR}"

append_block_title "END"
append_line "Review snapshot generated successfully."

echo "Generated review snapshot: ${OUT_FILE}"

