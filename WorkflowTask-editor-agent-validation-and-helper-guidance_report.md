# WorkflowTask-editor-agent-validation-and-helper-guidance

## Summary

- Added target selection to root validation and review helpers while preserving
  existing no-argument behavior.
- Added repo-local validation and review helper entrypoints under copilot only.
- Added short AI-HINT reminders to root review collection output with
  NO_AI_HINT=1 suppression.

## Root/meta files changed

- META/scripts/validate_helix.sh
- META/scripts/collect_task_review.sh

## Copilot files added

- copilot/validate.sh
- copilot/collect_repo_review.sh

## Cursor files intentionally untouched

- No files under cursor/ were modified.
- Root helpers retain fallback behavior for cursor because cursor does not yet
  have repo-local helper scripts.

## Existing no-argument behavior preservation

- ./validate_helix.sh still validates both copilot and cursor when no target is
  provided.
- ./collect_task_review.sh still collects review output for both copilot and
  cursor when no target is provided.

## New target-argument behavior

- ./validate_helix.sh copilot validates only copilot.
- ./validate_helix.sh cursor validates only cursor.
- ./collect_task_review.sh copilot collects only copilot review output.
- ./collect_task_review.sh cursor collects only cursor review output.
- Unknown targets fail with usage text.

## Child-local helper behavior

- copilot/validate.sh is executable, runs from within copilot, prints repo path
  and scope, reminds editor AIs to prefer the container-oriented workflow, and
  runs flake8 plus pytest through docker compose in the current repo only.
- copilot/collect_repo_review.sh is executable, runs from within copilot, and
  prints repo-local branch, status, diff stats, and recent log only.
- Root helpers delegate to repo-local scripts when present and otherwise use the
  existing root-side behavior.

## AI-HINT behavior and suppression

- Root collect output now prints short AI-HINT lines once per invocation.
- Setting NO_AI_HINT=1 suppresses those lines.
- Child-local collect output does not print the root AI-HINT lines.

## Safety boundaries preserved

- No edits were made under cursor/.
- No runtime checkout files were touched.
- No scraping, Docker restart, DB modification, crontab modification, or runtime
  reflection was performed.
- No virtual environments or dependency installation steps were added.

## Validation or syntax checks performed

- Ran bash -n META/scripts/validate_helix.sh META/scripts/collect_task_review.sh
- Additional shell syntax and helper behavior checks were run after file
  creation.

## Known limitations

- copilot/validate.sh still depends on docker compose availability in the local
  environment because the established validation path is container-oriented.
- The root validation fallback for cursor remains the existing root-side docker
  compose invocation until cursor adopts matching repo-local helpers.

## Recommended next steps

- Add matching repo-local helper scripts to cursor after product-main adoption.
- Optionally align help text or docs in child repos if these helper entrypoints
  should be operator-visible.