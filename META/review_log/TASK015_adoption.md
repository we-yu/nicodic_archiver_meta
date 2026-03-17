# TASK015 Adoption Log

## Task
TASK015

Add minimal batch-run logging / status recording for the existing batch scrape
command, while preserving current batch semantics and avoiding heavy logging
framework expansion.

## Decision
Adopted: **Cursor**

Alternative reviewed:
- Copilot implementation was retained as comparison evidence
- Hybrid was considered but not selected

## Final adopted shape
Changed files:
- `main.py`
- `tests/test_main.py`

Production code outside the batch entry layer was not redesigned.

## What changed in the adopted result
The adopted result introduced bounded run-level logging for batch scrape runs.

Key behavior added:
- batch-only `.log` persistence
- one start marker per run
- one end summary per run
- failure-only detail persistence
- no per-target persistence for success cases
- final status recorded as:
  - `success`
  - `partial_failure`
  - `failure`

The adopted result remained CLI-centered and did not expand into a DB-backed
run table, scheduler behavior, overlap policy, or heavy observability design.

## Why Cursor was adopted
Primary reasons:

1. It matched the fixed TASK015 semantics directly.
   - start marker and end summary were both present
   - failure-only detail was preserved
   - success targets were not individually persisted
   - final status used the intended three-valued semantics

2. It stayed well bounded.
   - no parser / storage / http_client redesign
   - no scheduler expansion
   - no retry / backoff expansion
   - no DB run table
   - no full audit-log expansion

3. It remained small and reviewable.
   - implementation was centered in the batch entry path
   - tests made the intended logging semantics easy to inspect

4. It passed validation cleanly in the review workflow.

## Why Copilot was not adopted
Copilot implementation was substantively valid and useful as comparison evidence.

Observed strengths:
- clean helper-level separation for batch logging
- the intended run-log semantics were implemented in a clear structure

Reasons it was not selected:
- validation initially failed due to submission-quality issues in touched files
- even after separating those failures from implementation substance, Cursor
  still provided the more direct and lower-friction adopted result for this task

## Why Hybrid was not selected
Hybrid was considered, but not selected because:
- the practical difference was not a narrow one-line improvement
- Cursor already satisfied the intended TASK015 boundary well
- merge-for-the-sake-of-merge was unnecessary
- keeping the review memory simple is preferable

## Validation result
Validation was run with the established workflow:
- `./validate_helix.sh` was used during review
- adopted final state passed post-adoption validation on converged `main`

## Convergence result
- `./compare_helix.sh --all` passed after realignment
- `copilot/` and `cursor/` matched on the adopted final state

## Repository outcome
- adopted implementation repository: `cursor/`
- comparison-evidence repository: `copilot/`
- optional adoption marker branch:
  - `adopted/task015-run-logging`
- after integration, both child repositories were realigned to the same adopted
  final state

## Notes for future AI sessions
Important interpretation:
- TASK015 is complete
- the project now has minimal batch-run logging / status recording
- logging remains batch-only and text-log based
- success targets are not individually persisted in run logs
- failure-only detail is persisted
- final status is recorded as `success`, `partial_failure`, or `failure`
- no scheduler / overlap / DB-backed logging expansion was introduced

## Meta note
This log is AI-readable review memory.
It is not authoritative current state by itself.

Authoritative context should still be restored from:
- `AI_CONTEXT.md`
- `PROJECT_STATE.md`
- `WORKSPACE.md`
- `project_snapshot.txt`

