#!/usr/bin/env bash
set -euo pipefail

# 固定リポジトリ
REPO="we-yu/nicodic_archiver_meta"

# 引数1があればそれを出力ファイルに、なければデフォルト
OUTFILE="${1:-Issues.txt}"

LIMIT="${LIMIT:-1000}"

{
  echo "# Open Issues Export"
  echo "# Repository: $REPO"
  echo "# Generated at: $(date '+%Y-%m-%d %H:%M:%S %Z')"
  echo
} > "$OUTFILE"

gh issue list --repo "$REPO" --state open --limit "$LIMIT" --json number --jq '.[].number' |
while IFS= read -r num; do
  gh issue view "$num" --repo "$REPO" --json number,title,body,url \
    --jq '"## Issue #\(.number): \(.title)\nURL: \(.url)\n\n" + ((.body // "") | if . == "" then "(本文なし)" else . end) + "\n\n---\n"'
done >> "$OUTFILE"

echo "Done: $OUTFILE"
