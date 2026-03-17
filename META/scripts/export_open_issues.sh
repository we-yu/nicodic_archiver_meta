#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage:
  ./export_open_issues.sh [output_file]

Purpose:
  Export open GitHub issues from the meta repository into a local text file.

Default output:
  Issues.txt

Environment:
  LIMIT   Optional. Max number of open issues to export. Default: 1000

Notes:
  - Requires GitHub CLI (`gh`) to be installed and authenticated
  - This is a workflow/reference helper, not an authoritative state file
EOF
}

if [[ "${1:-}" == "--help" || "${1:-}" == "-h" ]]; then
  usage
  exit 0
fi

need_cmd() {
  command -v "$1" >/dev/null 2>&1 || {
    echo "ERROR: missing command: $1" >&2
    exit 2
  }
}

need_cmd gh
need_cmd date

REPO="we-yu/nicodic_archiver_meta"
OUTFILE="${1:-Issues.txt}"
LIMIT="${LIMIT:-1000}"

{
  echo "# Open Issues Export"
  echo "# Repository: ${REPO}"
  echo "# Generated at: $(date '+%Y-%m-%d %H:%M:%S %Z')"
  echo
} > "${OUTFILE}"

gh issue list --repo "${REPO}" --state open --limit "${LIMIT}" --json number --jq '.[].number' |
while IFS= read -r num; do
  gh issue view "${num}" --repo "${REPO}" --json number,title,body,url \
    --jq '"## Issue #\(.number): \(.title)\nURL: \(.url)\n\n" + ((.body // "") | if . == "" then "(本文なし)" else . end) + "\n\n---\n"'
done >> "${OUTFILE}"

echo "Done: ${OUTFILE}"


