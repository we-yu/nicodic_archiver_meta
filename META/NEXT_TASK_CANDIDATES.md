# Next Task Candidates

This file is planning memory for near-term development.

It is not a fixed task order and does not replace PROJECT_STATE.md, WORKSPACE.md, or review logs.

## Recommended order

1. SubTask-meta-record-cleanup-after-ui-polish
2. MainTask-codex-adoption-planning
3. MainTask-workflow-tooling-independence
4. SubTask-compact-shot-heartbeat-log
5. SubTask-import-and-feeder-resilience
6. SubTask-download-export-lazy-cache
7. MainTask-scrape-run-identity-and-target-state
8. Later polish / maintenance tasks

## 1. SubTask-meta-record-cleanup-after-ui-polish

Type:

- SubTask / meta cleanup

Purpose:

- Repair malformed meta records after the Registered Articles UI polish closeout.
- Remove broken Markdown fenced-block artifacts, EOF remnants, and pasted command debris.
- Keep the authoritative state readable for the next AI session.

Method:

- Rewrite the affected review log into clean Markdown without fenced code blocks.
- Replace the UI polish section in PROJECT_STATE.md with a clean summary.
- Regenerate project snapshots.

Expected benefit:

- Future AI context restoration becomes safer.
- The next task starts from clean project memory.

## 2. MainTask-codex-adoption-planning

Type:

- MainTask / process

Purpose:

- Decide how Codex should be introduced without disrupting the current Human + Advisor + Copilot/Cursor + Mac Terminal workflow.
- Preserve the purpose of DHM while allowing tool substitution where useful.

Method:

- Define what Codex may and may not do.
- Draft AGENTS.md.
- Decide first safe trial surface:
  - Chrome / in-app browser
  - IDE extension
  - Cloud task
- Define how Codex can support or partially replace DHM.
- Keep runtime DB, cron, docker, long scrape decisions, and merge adoption judgment under Human + Advisor control for now.

Expected benefit:

- Reduces repeated prompt overhead.
- Makes future AI execution more consistent.
- Allows safe experimentation with Codex before product semantics are entrusted to it.

## 3. MainTask-workflow-tooling-independence

Type:

- MainTask / workflow tooling

Purpose:

- Make validation and review tooling more repository-local and editor-safe.
- Reduce cases where editor AIs try to create virtual environments or run inappropriate ad-hoc tests.
- Make SubTask-only work easier to validate without always running the full Double Helix path.

Method:

- Add child-repo-local helper scripts such as:
  - tools/validate_local.sh
  - tools/collect_local.sh
  - tools/editor_safe_check.sh
- Make root wrappers call those child-local helpers.
- Add options for copilot-only, cursor-only, or all-repo validation.
- Add short AI-facing reminders to frequently pasted helper output.

Expected benefit:

- Better tool independence.
- Lower Human monitoring load.
- Fewer editor-AI interruptions.
- Easier Codex adoption later.

Merged prior ideas:

- SubTask-tool-independent
- add editor-safe validation tool
- AI reminder output in collect/validation helpers

## 4. SubTask-compact-shot-heartbeat-log

Type:

- SubTask / product log polish

Purpose:

- Make batch and host cron logs easier to scan while preserving useful information.
- Keep long scrape shots readable without hiding failure detail.

Method:

- Add STEP START / STEP END style log blocks.
- Keep START / END index and total aligned.
- Use compact heartbeat groups for normal page success.
- Preserve WARN and ERROR detail.
- Do not change scrape behavior.
- Do not introduce a logging platform.

Desired shape:

- STEP START line at the beginning of each target.
- Indented heartbeat INFO lines during page progress.
- WARN / ERROR detail lines retained.
- STEP END line with status, title, saved response count, observed max response number, and duration.

Expected benefit:

- Easier runtime monitoring.
- Better debugging when a long shot partially fails.
- Safe first Codex product SubTask candidate.

## 5. SubTask-import-and-feeder-resilience

Type:

- SubTask / product resilience

Purpose:

- Prevent one transient resolution/fetch/registration failure from aborting a large import or feeder-like registration process.

Method:

- Keep per-candidate failures local.
- Continue processing later candidates.
- Report registered, skipped, failed, and retryable counts.
- Preserve enough failed-candidate information for later manual retry.

Expected benefit:

- Safer DB rebuild and target import workflows.
- Less operator babysitting.
- Better behavior when NicoNicoPedia returns transient 500 responses.

## 6. SubTask-download-export-lazy-cache

Type:

- SubTask / product performance

Purpose:

- Avoid re-reading and re-rendering very large saved articles on repeated TXT/MD/CSV downloads.

Method:

- Keep DB as source of truth.
- On first download, generate export from DB and write cache.
- On later download, compare lightweight DB summary with cache metadata.
- If response_count, max_res_no, latest scraped reference, and export version match, return cached file.
- If metadata differs, regenerate cache on demand.
- Do not make scrape/save flow responsible for cache deletion.

Expected benefit:

- Lower repeat-download load for huge articles.
- Keeps scrape path simpler.
- Avoids eager generation for rarely downloaded articles.

## 7. MainTask-scrape-run-identity-and-target-state

Type:

- MainTask / product semantics and schema

Purpose:

- Add a clear run identity / short run mark so operators can see which scrape shot updated which rows.
- Redesign Max Res No semantics so it can represent observed live board state rather than only locally saved response count.
- Add target state tracking for invalid or failing targets.

Method:

- Consider adding scrape run table or equivalent run record.
- Consider target state fields such as:
  - last_attempted_at
  - last_success_at
  - last_error_code
  - invalid_reason
  - observed_max_res_no
  - last_changed_run_uid
- Consider a short two-symbol run mark.
- Keep the mark human-facing and non-critical.
- Candidate run mark set:
  - zodiac animals: 🐭 🐮 🐯 🐰 🐲 🐍 🐴 🐑 🐵 🐔 🐶 🐷
  - five elements: 🌳 🔥 🪨 🥇 💧
  - 12 x 5 = 60 patterns

Expected benefit:

- Better runtime debugging.
- Easier visual grouping in Registered Articles.
- Corrects the deeper Max Res No meaning mismatch.
- Supports future invalid-target and retry policy work.

## Later candidates

### SubTask-target-denylist-externalization

Purpose:

- Move denylist policy from hardcoded Python seam toward a repo-managed policy file or similarly bounded operator-editable source.

Expected benefit:

- Easier maintenance of known excluded articles.

### SubTask-meta-snapshot-policy

Purpose:

- Decide how generated project_snapshot.txt and project_knowledge_snapshot.txt should be tracked, ignored, or regenerated.

Expected benefit:

- Reduces recurring AI confusion around generated snapshot diffs.

### Further Registered Articles UI polish

Purpose:

- Continue minor UI refinements only after semantic tasks settle.

Expected benefit:

- Avoids endless visual tweaking before core operational semantics are clear.

