# Next Task Candidates

This file tracks current unfinished task candidates.

It is planning memory, not authoritative product state.
When a candidate is completed and recorded in `PROJECT_STATE.md` plus
`META/review_log/`, remove it from this list.

## Current completed-and-removed context

The following previously listed candidates are now completed and should not
remain as active candidates here:

- `RuntimeOps-build-dev-sample-db`
- `SubTask-BugFix-observation-db-lock-tolerance`
- `RuntimeOps-target-order-cron-policy-reenable`

Current completion records include:

- `META/review_log/RuntimeOps_build_dev_sample_db_20260523.md`
- `META/review_log/SubTask_BugFix_observation_db_lock_tolerance_20260527.md`
- `META/review_log/SubTask_improve_periodic_once_host_cron_log_guidance_20260527.md`
- `META/review_log/Runtime_periodic_recovery_20260527.md`

## Priority A: near-term operational candidates

### Runtime reflection for periodic-once host-log guidance

Purpose:
- Reflect the already-adopted periodic-once host-log guidance change into the
  sibling runtime checkout.

Method:
- Wait until no active scrape-like runtime process is running.
- Use the established runtime reflection safety flow.
- Do not interrupt an active periodic run just for this guidance-only change.

Expected benefit:
- Manual `periodic_once.sh` runs will clearly tell the operator that detailed
  progress is written to `host_cron.log`.

Status:
- Product change is already merged.
- Runtime reflection is deferred until a safe maintenance point.

### RuntimeOps-clean-runtime-data-artifacts

Purpose:
- Reduce confusion from old runtime DB backups, temporary files, and historic
  task artifacts under runtime data directories.

Method:
- First inventory runtime data artifacts.
- Do not delete immediately.
- Prefer quarantine such as `_quarantine_YYYYMMDD/`.
- Preserve active runtime files such as `nicodic.db`, `web_action.log`, and
  current feeder state unless explicitly reviewed.

Expected benefit:
- Future DB, runtime, and smoke work is less likely to accidentally inspect or
  use stale artifacts.

Status:
- Not started.
- Should be done only when runtime state is quiet enough to inspect safely.

### Dev Web smoke DB sync improvement

Purpose:
- Make child-repo development Web smoke checks use realistic lightweight data
  instead of stale or mismatched DB state.

Method:
- Build on `RuntimeOps-build-dev-sample-db`.
- Document or helperize the expected sample DB refresh path for Copilot/Cursor
  development Web checks.

Expected benefit:
- Web UI review and DB-facing BugFix checks become more reliable and cheaper.

Status:
- Not started.
- Now unblocked by the completed Dev sample DB helper.

## Priority B: stability / observability candidates

### MainTask-sqlite-access-hardening

Purpose:
- Review and harden SQLite connection timeout, busy timeout, read/write access,
  and transaction boundaries across runtime-like operation.

Method:
- Treat as a DHM MainTask or carefully scoped architecture/stability task.
- Review at least storage, archive read, Web, target registry, periodic flow,
  and Delete Feeder access patterns.
- Avoid broad behavior redesign unless explicitly scoped.

Expected benefit:
- Better long-running scrape plus Web UI coexistence.
- Fewer unexpected SQLite lock or timeout failures.

Status:
- Not started.
- Better after some runtime observation under the recovered cron policy.

### SubTask-BugFix-periodic-lock-cleanup-hardening

Purpose:
- Confirm periodic lock cleanup behavior remains robust after abnormal exits,
  soft terminate, and duration-limit exits.

Method:
- Review wrapper trap / cleanup behavior and process lifecycle.
- Keep this narrow if separated from broader SQLite hardening.

Expected benefit:
- Fewer stale `periodic_once.lock` incidents and easier recovery.

Status:
- Not started as a standalone task.
- May be folded into another runtime hardening task if evidence warrants it.

### Delete Feeder progress logging

Purpose:
- Reduce silent periods during Delete Feeder scanning and handoff.

Method:
- Add bounded, grep-friendly progress or phase logs.
- Avoid verbose per-candidate output in normal runtime operation.

Expected benefit:
- It becomes easier to tell whether periodic startup is making progress before
  target scraping begins.

Status:
- Not started.
- Not an immediate blocker after current runtime recovery.

## Priority C: later product semantics candidates

### scrape_id / run mark

Purpose:
- Give scrape runs a short visual identifier for logs and Web readout.

Method:
- Design alongside scrape-run observation and Web registered-list semantics.

Expected benefit:
- Easier to see which rows were touched by a recent run.

Status:
- Not started.

### Max Res No semantic redesign

Purpose:
- Clarify the difference between saved max response number and observed board
  max response number.

Method:
- Design together with observed max response number and target state tracking.

Expected benefit:
- Registered Articles columns become less ambiguous.

Status:
- Not started.

### Observed max response number

Purpose:
- Persist board-side observed maximum response number separately from saved
  response count and saved max response number.

Method:
- Likely schema / telemetry / Web readout work.
- Consider zero-response, unavailable-board, deleted-response, and partial
  scrape cases.

Expected benefit:
- Better distinction between archive completeness and board state.

Status:
- Not started.

### Target state tracking

Purpose:
- Make target state explicit instead of inferring from response count and last
  scraped timestamp.

Possible states:
- pending
- scraped
- invalid
- denied
- unavailable

Expected benefit:
- Registered Articles and operator tooling become easier to reason about.

Status:
- Not started.

### Invalid target state

Purpose:
- Avoid repeatedly treating permanently invalid or unresolvable targets as
  ordinary pending targets.

Method:
- Consider as part of target state tracking.
- Do not introduce fuzzy search or automatic title correction.

Expected benefit:
- Cleaner runtime traversal and clearer user/operator feedback.

Status:
- Not started.

## Priority D: meta / workflow candidates

### PROJECT_STATE slimming

Purpose:
- Separate current state from long historical memory.

Method:
- Use `META/METADATA_INDEX.md` as guidance.
- Prefer bounded reorganization over destructive deletion.
- Keep authoritative restore behavior intact.

Expected benefit:
- Faster context recovery and less duplicated state memory.

Status:
- Not started.

### AGENTS_DRAFT promotion

Purpose:
- Decide whether `META/AGENTS_DRAFT.md` is ready to become active `AGENTS.md`.

Method:
- Promote only after more Codex / editor-agent trial evidence.
- Preserve runtime DB, cron, Docker, and merge authority guardrails.

Expected benefit:
- Clearer default behavior for Codex-style agents.

Status:
- Deferred.

### Codex trial continuation

Purpose:
- Continue evaluating Codex/Copilot-style assistant usage for bounded review,
  small BugFixes, and Web smoke support.

Method:
- Keep Human + Advisor as final judgment.
- Do not grant runtime DB, cron, Docker, or merge/adoption authority.
- Prefer established project helpers over ad-hoc host Python or venv workflows.

Expected benefit:
- Lower prompt/review overhead without weakening safety boundaries.

Status:
- Ongoing background practice, not a standalone implementation task.

