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
  - in full mode, project files are included after priority meta files
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
  fi
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
find . -type f ! -path "*/.git/*" ! -path "*/example_webpage/*" ! -path "*/data/*" ! -path "*/__pycache__/*" ! -path "*/.pytest_cache/*" ! -path "*/.venv/*" ! -path "*/venv/*" ! -path "*/.mypy_cache/*" ! -path "*/.ruff_cache/*" ! -path "*/.cache/*" ! -path "*/node_modules/*" ! -name "*.pyc" ! -name ".DS_Store" ! -name "project_snapshot.txt" ! -name "project_knowledge_snapshot.txt" ! -name "review_snapshot.txt" ! -name "review_snapshot_*.txt" ! -name "git_snapshot.txt" ! -name "git_snapshot_*.txt" ! -name "project_summary.txt" ! -name "TASK*_report.txt" ! -path "./META/out/*" ! -name "AI_BOOTSTRAP.md" ! -name "AI_CONTEXT.md" ! -name "_AI_EXECUTION_PROTOCOL.md" ! -name "_AI_RULES.md" ! -name "_AI_DEVELOPMENT_MODEL.md" ! -name "_AI_ORCHESTRATION_VISION.md" ! -name "PROJECT_STATE.md" ! -name "WORKSPACE.md" ! -path "./META/TASK_CYCLE_CHECKLIST.md" ! -path "./META/ARCHITECTURE.md" ! -path "./META/review_log/*" | sort | while IFS= read -r file
  do
    append_snapshot_file "$file"
  done
fi

if [[ "$MODE" == "meta-only" ]]; then
find . -maxdepth 1 -type f ! -name "project_snapshot.txt" ! -name "project_knowledge_snapshot.txt" ! -name "review_snapshot.txt" ! -name "review_snapshot_*.txt" ! -name "git_snapshot.txt" ! -name "git_snapshot_*.txt" ! -name "project_summary.txt" ! -name "TASK*_report.txt" ! -name "AI_BOOTSTRAP.md" ! -name "AI_CONTEXT.md" ! -name "_AI_EXECUTION_PROTOCOL.md" ! -name "_AI_RULES.md" ! -name "_AI_DEVELOPMENT_MODEL.md" ! -name "_AI_ORCHESTRATION_VISION.md" ! -name "PROJECT_STATE.md" ! -name "WORKSPACE.md" | sort | while IFS= read -r file
  do
    append_snapshot_file "${file#./}"
  done

  find META -type f ! -path "META/out/*" ! -path "META/review_log/*" ! -name "review_snapshot.txt" ! -name "review_snapshot_*.txt" ! -name "git_snapshot.txt" ! -name "git_snapshot_*.txt" | sort | while IFS= read -r file
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

