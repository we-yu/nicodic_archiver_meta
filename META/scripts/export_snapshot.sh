#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "${SCRIPT_DIR}/../.." && pwd)"
cd "$ROOT_DIR"

MAIN_OUT="project_snapshot.txt"
KNOWLEDGE_OUT="project_knowledge_snapshot.txt"
MODE="full"

usage() {
  cat <<'USAGE'
Usage:
  ./export_snapshot.sh [--meta-only]

Options:
  --meta-only   Export only root bootstrap/state/workspace files plus META
                workflow/review-memory files into project_snapshot.txt.

Purpose:
  Generate authoritative AI-readable snapshots for project restoration.

Outputs:
  - project_snapshot.txt
  - project_knowledge_snapshot.txt

Notes:
  - review-only generated files are excluded
  - META/review_log/*.md and META/TASK_CYCLE_CHECKLIST.md are included
  - runtime state / logs / generated artifacts are excluded
USAGE
}

if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
  usage
  exit 0
fi

if [[ "${1:-}" == "--meta-only" ]]; then
  MODE="meta-only"
elif [[ $# -gt 0 ]]; then
  echo "ERROR: unknown option: $1" >&2
  usage
  exit 2
fi

echo "* META INFO * Say to Advisor-AI [Read this file and understand the project.] with output file."

rm -f "$MAIN_OUT"
rm -f "$KNOWLEDGE_OUT"

: > "$MAIN_OUT"
: > "$KNOWLEDGE_OUT"

append_file() {
  local label="$1"
  local file="$2"

  if [[ -f "$file" ]]; then
    echo "===== ${label} =====" >> "$MAIN_OUT"
    cat "$file" >> "$MAIN_OUT"
    echo "" >> "$MAIN_OUT"
    echo "" >> "$MAIN_OUT"
  fi
}

append_snapshot_file() {
  local file="$1"

  if [[ -f "$file" ]]; then
    echo "" >> "$MAIN_OUT"
    echo "=============================" >> "$MAIN_OUT"
    echo "FILE: $file" >> "$MAIN_OUT"
    echo "=============================" >> "$MAIN_OUT"
    cat "$file" >> "$MAIN_OUT"
    echo "" >> "$MAIN_OUT"
  fi
}

is_full_snapshot_candidate() {
  local file="$1"

  case "$file" in
    */.git/*) return 1 ;;
    */__pycache__/*) return 1 ;;
    */.pytest_cache/*) return 1 ;;
    */.venv/*) return 1 ;;
    */venv/*) return 1 ;;
    */.mypy_cache/*) return 1 ;;
    */.ruff_cache/*) return 1 ;;
    */.cache/*) return 1 ;;
    */node_modules/*) return 1 ;;
    ./example_webpage/*) return 1 ;;
    ./META/out/*) return 1 ;;
    */data/*) return 1 ;;
    */runtime/data/*) return 1 ;;
    */runtime/logs/*) return 1 ;;
    */runtime/targets/*) return 1 ;;
    *.pyc) return 1 ;;
    *.log) return 1 ;;
    *.tar.gz) return 1 ;;
    *.sqlite) return 1 ;;
    *.db) return 1 ;;
    .DS_Store) return 1 ;;
    ./project_snapshot.txt) return 1 ;;
    ./project_knowledge_snapshot.txt) return 1 ;;
    ./review_snapshot.txt) return 1 ;;
    ./review_snapshot_*.txt) return 1 ;;
    ./git_snapshot.txt) return 1 ;;
    ./git_snapshot_*.txt) return 1 ;;
    ./project_summary.txt) return 1 ;;
    ./*TASK*_report.txt) return 1 ;;
    ./AI_BOOTSTRAP.md) return 1 ;;
    ./AI_CONTEXT.md) return 1 ;;
    ./_AI_EXECUTION_PROTOCOL.md) return 1 ;;
    ./_AI_RULES.md) return 1 ;;
    ./_AI_DEVELOPMENT_MODEL.md) return 1 ;;
    ./_AI_ORCHESTRATION_VISION.md) return 1 ;;
    ./PROJECT_STATE.md) return 1 ;;
    ./WORKSPACE.md) return 1 ;;
    ./META/TASK_CYCLE_CHECKLIST.md) return 1 ;;
    ./META/ARCHITECTURE.md) return 1 ;;
    ./META/review_log/*) return 1 ;;
  esac

  return 0
}

append_file "AI BOOTSTRAP" "AI_BOOTSTRAP.md"
append_file "AI CONTEXT" "AI_CONTEXT.md"
append_file "AI EXECUTION PROTOCOL" "_AI_EXECUTION_PROTOCOL.md"
append_file "AI RULES" "_AI_RULES.md"
append_file "AI DEVELOPMENT MODEL" "_AI_DEVELOPMENT_MODEL.md"
append_file "AI ORCHESTRATION VISION" "_AI_ORCHESTRATION_VISION.md"
append_file "PROJECT STATE" "PROJECT_STATE.md"
append_file "WORKSPACE" "WORKSPACE.md"

if [[ -f "META/TASK_CYCLE_CHECKLIST.md" ]]; then
  append_file "TASK CYCLE CHECKLIST" "META/TASK_CYCLE_CHECKLIST.md"
fi

if [[ -f "META/ARCHITECTURE.md" ]]; then
  append_file "ARCHITECTURE" "META/ARCHITECTURE.md"
fi

if find META/review_log -type f -name "*.md" >/dev/null 2>&1; then
  while IFS= read -r file; do
    append_file "REVIEW LOG: ${file}" "$file"
  done < <(find META/review_log -type f -name "*.md" | sort)
fi

echo "===== PROJECT SNAPSHOT =====" >> "$MAIN_OUT"
echo "generated: $(date)" >> "$MAIN_OUT"
echo "mode: ${MODE}" >> "$MAIN_OUT"
echo "" >> "$MAIN_OUT"

if [[ "$MODE" == "full" ]]; then
  while IFS= read -r file; do
    if is_full_snapshot_candidate "$file"; then
      append_snapshot_file "${file#./}"
    fi
  done < <(find . -type f | sort)
fi

if [[ "$MODE" == "meta-only" ]]; then
  find . -maxdepth 1 -type f \
    ! -name "project_snapshot.txt" \
    ! -name "project_knowledge_snapshot.txt" \
    ! -name "review_snapshot.txt" \
    ! -name "review_snapshot_*.txt" \
    ! -name "git_snapshot.txt" \
    ! -name "git_snapshot_*.txt" \
    ! -name "project_summary.txt" \
    ! -name "TASK*_report.txt" \
    ! -name "*.log" \
    ! -name "*.tar.gz" \
    ! -name "*.db" \
    ! -name "*.sqlite" \
    ! -name "AI_BOOTSTRAP.md" \
    ! -name "AI_CONTEXT.md" \
    ! -name "_AI_EXECUTION_PROTOCOL.md" \
    ! -name "_AI_RULES.md" \
    ! -name "_AI_DEVELOPMENT_MODEL.md" \
    ! -name "_AI_ORCHESTRATION_VISION.md" \
    ! -name "PROJECT_STATE.md" \
    ! -name "WORKSPACE.md" | sort | while IFS= read -r file
  do
    append_snapshot_file "${file#./}"
  done

  find META -type f \
    ! -path "META/out/*" \
    ! -path "META/review_log/*" \
    ! -name "review_snapshot.txt" \
    ! -name "review_snapshot_*.txt" \
    ! -name "git_snapshot.txt" \
    ! -name "git_snapshot_*.txt" | sort | while IFS= read -r file
  do
    case "$file" in
      META/TASK_CYCLE_CHECKLIST.md|META/ARCHITECTURE.md|META/scripts/*)
        append_snapshot_file "$file"
        ;;
    esac
  done
fi

echo "===== AI DEVELOPMENT MODEL =====" >> "$KNOWLEDGE_OUT"
cat _AI_DEVELOPMENT_MODEL.md >> "$KNOWLEDGE_OUT"
echo "" >> "$KNOWLEDGE_OUT"

echo "===== AI EXECUTION PROTOCOL =====" >> "$KNOWLEDGE_OUT"
cat _AI_EXECUTION_PROTOCOL.md >> "$KNOWLEDGE_OUT"
echo "" >> "$KNOWLEDGE_OUT"

echo "===== AI ORCHESTRATION VISION =====" >> "$KNOWLEDGE_OUT"
cat _AI_ORCHESTRATION_VISION.md >> "$KNOWLEDGE_OUT"
echo "" >> "$KNOWLEDGE_OUT"

echo "===== AI RULES =====" >> "$KNOWLEDGE_OUT"
cat _AI_RULES.md >> "$KNOWLEDGE_OUT"
echo "" >> "$KNOWLEDGE_OUT"

echo "Knowledge snapshot generated."

echo ""
echo "Generated files:"
echo "  $MAIN_OUT"
echo "  $KNOWLEDGE_OUT"
echo ""
