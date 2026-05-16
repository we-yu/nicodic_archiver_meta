# MetaTask-optimizing-metadata Report

## Summary

Added a conservative metadata index for the root meta repository.

The new index clarifies which files are authoritative, reference-only,
historical, draft, or generated, and it records when humans or AI agents
should read or edit them.

No product code, runtime files, docker files, cron settings, or database
artifacts were changed.

## Files inspected

- `AI_BOOTSTRAP.md`
- `AI_CONTEXT.md`
- `WORKSPACE.md`
- `PROJECT_STATE.md`
- `META/README.md`
- `META/AGENTS_DRAFT.md`
- `META/CODEX_ADOPTION_PLAN.md`
- `META/CODEX_TRIAL_CHECKLIST.md`
- `META/REPO_BOUNDARY_GUARDRAILS.md`
- `META/TASK_CYCLE_CHECKLIST.md`
- `META/review_log/` directory listing
- `.gitignore`
- tracked-file and line-count checks for `PROJECT_STATE.md`,
  `project_snapshot.txt`, and `project_knowledge_snapshot.txt`

## Files changed

- `META/METADATA_INDEX.md` added
- `MetaTask-optimizing-metadata_report.md` added

## Findings and recommendations

### `PROJECT_STATE.md`

- It remains useful as authoritative project state memory.
- It is also historically dense at roughly 2100 lines.
- Recommended follow-up: keep it authoritative, but split older detailed task
  history from current-state summary in a future bounded cleanup task.
- This task did not rewrite or slim it aggressively.

### `project_snapshot.txt`

- It is generated, large, and tracked.
- Existing bootstrap, rules, workflow, and helper documents repeatedly treat it
  as the restore snapshot of record.
- Recommendation for now: keep tracking as-is.
- Recommended future follow-up: review whether tracking, regeneration policy,
  or snapshot tiering should change after the restore model is simplified.
- This task did not change git history, ignore rules, or snapshot generation.

### `META/AGENTS_DRAFT.md`

- The draft is useful and directionally strong.
- It is not yet a strong enough activation case for immediate promotion to an
  active `AGENTS.md` file.
- Recommendation: remain draft for now.
- Revisit activation only after metadata roles, placement, and read-order are
  stable enough to avoid conflicting guidance.

## Explicit non-goals preserved

- No product code changes in `copilot/`
- No product code changes in `cursor/`
- No runtime checkout changes
- No DB, cron, docker, nginx, or scrape execution changes
- No deletion of review logs or historical memory
- No aggressive `PROJECT_STATE.md` rewrite
- No `AGENTS.md` activation
- No git history rewrite
- No helper-script behavior change

## Validation

Static inspection only.

Validation performed:

- inspected target metadata files and directory structure
- checked tracked status of snapshot files
- checked line counts for `PROJECT_STATE.md` and snapshot files
- reviewed scope to ensure no product/runtime instructions were introduced

Validation not performed:

- no Python validation
- no docker or runtime validation
- no snapshot regeneration

Static inspection was sufficient for this documentation-only meta task.

## Model and tools

- Editor AI model: GitHub Copilot Chat / GPT-5.4
- Tools used: directory listing, file reads, text search, git/tracked-file
  inspection, and patch-based file edits
