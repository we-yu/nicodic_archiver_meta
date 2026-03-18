# TASK016 Adoption Log

## Task
TASK016

Add a bounded periodic execution entrypoint that reuses the existing batch
scrape command and existing batch run logging, while preserving CLI-centered
operation and avoiding scheduler-framework expansion.

## Decision
Adopted: **Copilot**

Alternative reviewed:
- Cursor implementation was retained as comparison evidence
- Hybrid was considered but not selected

## Final adopted shape
Changed files:
- `main.py`
- `tests/test_main.py`

Production code outside the CLI / batch-entry layer was not redesigned.

## What changed in the adopted result
The adopted result introduced a bounded periodic execution entrypoint centered
on the CLI/application entry layer.

Key behavior added:
- `periodic` CLI entrypoint
- interval specified by CLI argument
- optional `--max-runs`
- one periodic cycle = process the full target list once
- per-article continue-on-error preserved within each cycle
- existing batch scrape command reused as the per-cycle execution unit
- existing batch run logging reused without introducing a new periodic-only
  log format
- safe exit on `Ctrl+C`
- periodic loop continues to the next cycle even when a cycle result is
  `partial_failure` or `failure`

The adopted result remained CLI-centered and did not expand into scheduler
framework design, overlap policy, fairness policy, retry/backoff expansion,
deployment architecture work, or DB-backed job management.

## Why Copilot was adopted
Primary reasons:

1. It matched the fixed TASK016 semantics more directly.
   - one cycle = full target list processed once
   - existing batch scrape flow was reused clearly
   - existing batch run logging was reused clearly
   - periodic-specific logging was not added

2. It stayed well bounded.
   - changes remained in `main.py` and focused `tests/test_main.py`
   - no parser / storage / http_client redesign
   - no scheduler-framework expansion
   - no overlap / fairness / rotating-start policy expansion

3. It made the intended periodic semantics easier to review.
   - cycle boundaries were explicit
   - continuation after `partial_failure` / `failure` was visible
   - safe `Ctrl+C` exit behavior was explicitly protected in tests

4. It passed validation cleanly after submission-quality cleanup.

## Why Cursor was not adopted
Cursor implementation was valid, bounded, and useful as comparison evidence.

Observed strengths:
- remained CLI-centered
- reused the existing batch execution/logging path
- stayed within the intended task boundary

Reasons it was not selected:
- the adopted Copilot result made the fixed TASK016 semantics slightly more
  explicit and easier to review, especially around:
  - cycle-as-a-unit behavior
  - continuation across non-success cycle results
  - `Ctrl+C` handling visibility in tests

## Why Hybrid was not selected
Hybrid was considered, but not selected because:
- no narrow borrowed change clearly improved the adopted Copilot result enough
  to justify a hybrid
- Copilot already satisfied the intended TASK016 boundary well
- merge-for-the-sake-of-merge was unnecessary
- keeping the review memory simple is preferable

## Validation result
Validation was run with the established workflow:
- `./validate_helix.sh` passed for both child repositories
- post-adoption validation on converged `main` also passed

## Convergence result
- `./compare_helix.sh --all` passed after realignment
- `copilot/` and `cursor/` matched on the adopted final state

## Repository outcome
- adopted implementation repository: `copilot/`
- comparison-evidence repository: `cursor/`
- optional adoption marker branch:
  - `adopted/task016-periodic-entrypoint`
- after product-repo integration, both child repositories were realigned to the
  same adopted final state

## Notes for future AI sessions
Important interpretation:
- TASK016 is complete
- the project now has a bounded periodic execution entrypoint
- periodic execution remains CLI-centered
- one cycle processes the full target list once
- existing batch scrape behavior is reused per cycle
- existing batch run logging is reused as-is
- periodic-specific logging format was not added
- no scheduler / overlap / fairness / retry-backoff / deployment expansion was
  introduced

## Meta note
This log is AI-readable review memory.
It is not authoritative current state by itself.

Authoritative context should still be restored from:
- `AI_CONTEXT.md`
- `PROJECT_STATE.md`
- `WORKSPACE.md`
- `project_snapshot.txt`

