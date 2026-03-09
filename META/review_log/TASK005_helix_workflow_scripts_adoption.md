# TASK005 helix-workflow-scripts adoption log

## Task
- Task ID: TASK005
- Title: helix-workflow-scripts

## Purpose
Double Helix task cycle の定型作業を小さく自動化し、
branch 作成・validate 実行・review 材料収集の手作業を減らす。

## Scope
- Primary target:
  - root helper scripts
  - `META/scripts/`
- Documentation target:
  - `WORKSPACE.md`
  - `META/README.md`

## Non-goals
- No child-repo product code changes
- No adoption-decision automation
- No child-repo main integration automation
- No destructive cleanup automation
- No authentication / credential workflow changes
- No changes to `copilot/` or `cursor/` source trees

## Adopted result
- Added root thin wrappers:
  - `./new_task_branches.sh`
  - `./validate_helix.sh`
  - `./collect_task_review.sh`
- Added helper implementations:
  - `./META/scripts/new_task_branches.sh`
  - `./META/scripts/validate_helix.sh`
  - `./META/scripts/collect_task_review.sh`
- Updated documentation:
  - `./WORKSPACE.md`
  - `./META/README.md`

## Why this result was selected
- Keeps the existing root-wrapper / `META/scripts/` structure
- Improves repetitive workflow steps without changing development philosophy
- Reduces manual branch-name drift and review-prep overhead
- Preserves human-centered adoption and decision making
- Aligns with project priority:
  1. stability
  2. correctness
  3. maintainability
  4. AI comparison

## Behavior added by TASK005

### `./new_task_branches.sh`
- creates matching task branches for `copilot/` and `cursor/`
- enforces task-number + topic naming structure
- stops if target branch already exists
- checks for tracked working-tree changes before branch creation

### `./validate_helix.sh`
- runs `flake8` and `pytest` in both child repositories
- continues across both repos even if one side fails
- prints per-repo pass/fail summary
- returns non-zero if either side fails

### `./collect_task_review.sh`
- prints review-friendly git information for both child repositories
- includes current branch
- includes `git status --short`
- includes staged / unstaged diff stat
- includes recent short log
- performs no modification

## Validation
### Help output checks
- `./new_task_branches.sh --help`
- `./validate_helix.sh --help`
- `./collect_task_review.sh --help`

### Functional checks
- `./collect_task_review.sh`
- `./validate_helix.sh`

### Validation result
- help output: passed
- review collection: passed
- validate helper:
  - `copilot`: PASS
  - `cursor`: PASS

## Repository / history note
- TASK005 was implemented in the workspace root repository
- the task branch was pushed successfully
- local `main` was later updated to the adopted state
- authoritative snapshots were regenerated after adoption

## Final repository state
- root `main` includes TASK005 helper scripts
- root `main` includes updated workflow documentation
- authoritative snapshot files were regenerated
- TASK005 is complete

## Next-task handoff
- TASK005 is complete
- TASK006 should focus on `storage.py` unit tests
- preferred direction:
  - preserve current production behavior
  - add focused tests around existing storage behavior
  - avoid cross-layer refactor
  - keep task scope within storage-layer tests unless a very small correction is required

## Conclusion
TASK005 is complete.

The workspace now includes small helper tooling for routine Double Helix operations, while preserving the human-centered review and adoption model.

