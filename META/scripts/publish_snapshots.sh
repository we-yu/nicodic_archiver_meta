#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/../.." && pwd)"
cd "$ROOT_DIR"

ALLOWED_FILES=(
  "project_snapshot.txt"
  "project_knowledge_snapshot.txt"
)

DEFAULT_COMMIT_MSG="meta: refresh snapshot files"

die() {
  echo "ERROR: $*" >&2
  exit 1
}

require_file() {
  local path="$1"
  [[ -e "$path" ]] || die "required file not found: $path"
}

# --- basic sanity checks -----------------------------------------------------

require_file ".git"
require_file "AI_CONTEXT.md"
require_file "PROJECT_STATE.md"
require_file "META"
require_file "export_snapshot.sh"

current_branch="$(git branch --show-current)"
if [[ "$current_branch" != "main" ]]; then
  die "this script must be run on main. current branch: $current_branch"
fi

if ! git diff --quiet || ! git diff --cached --quiet; then
  die "working tree is not clean before snapshot export. commit/stash unrelated changes first."
fi

# untracked files are also unsafe unless they are the allowed snapshot files
mapfile -t pre_untracked < <(git ls-files --others --exclude-standard)
if [[ "${#pre_untracked[@]}" -gt 0 ]]; then
  die "untracked files exist before snapshot export. clean them first."
fi

# --- export snapshots --------------------------------------------------------

./export_snapshot.sh

# --- inspect changed files ---------------------------------------------------

mapfile -t changed_files < <(git status --porcelain | awk '{print $2}')

if [[ "${#changed_files[@]}" -eq 0 ]]; then
  echo "No changes detected after snapshot export."
  exit 0
fi

unexpected=()
allowed_changed=()

for f in "${changed_files[@]}"; do
  case "$f" in
    "project_snapshot.txt"|"project_knowledge_snapshot.txt")
      allowed_changed+=("$f")
      ;;
    *)
      unexpected+=("$f")
      ;;
  esac
done

if [[ "${#unexpected[@]}" -gt 0 ]]; then
  echo "Unexpected changed files detected:"
  printf '  %s\n' "${unexpected[@]}"
  die "aborting because only snapshot files may be committed by this script."
fi

if [[ "${#allowed_changed[@]}" -eq 0 ]]; then
  echo "Only non-allowed changes were detected, nothing to do."
  exit 1
fi

# --- commit and push ---------------------------------------------------------

git add -- "${allowed_changed[@]}"

if git diff --cached --quiet; then
  echo "Snapshot files were regenerated but no staged diff remains."
  exit 0
fi

commit_msg="${1:-$DEFAULT_COMMIT_MSG}"
git commit -m "$commit_msg"
git push

echo
echo "Snapshot publish completed."
echo "Committed files:"
printf '  %s\n' "${allowed_changed[@]}"

