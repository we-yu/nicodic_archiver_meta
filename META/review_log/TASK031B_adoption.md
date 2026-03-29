# TASK031B Adoption Log

## Task
TASK031B

Add a bounded append-only run telemetry layer that records per-run per-article
saved response observations into SQLite and provides read-only CSV export for
human inspection of progress / stall / skip patterns.

## Decision
Adopted: **Cursor**

Alternative reviewed:
- Copilot implementation was retained as comparison evidence
- Hybrid was considered but not selected

## Final adopted shape
Changed files in the adopted product result:
- `main.py`
- `orchestrator.py`
- `storage.py`
- `target_list.py`
- `tests/test_main.py`
- `tests/test_orchestrator.py`
- `tests/test_storage.py`

## What changed in the adopted result
The adopted result introduced a bounded append-only telemetry layer for
single-operator batch / periodic inspection.

Key behavior added:
- a new SQLite-backed append-only telemetry table:
  `scrape_run_observation`
- one per-run per-article observation row is appended for bounded batch /
  periodic scrape activity
- telemetry rows record:
  - `run_id`
  - `run_started_at`
  - `run_kind`
  - `skipped`
  - `article_id`
  - `article_type`
  - `canonical_article_url`
  - `saved_response_count_after_run`
  - `latest_total_response_count_ref`
  - `scrape_ok`
  - `scrape_outcome`
  - `observed_at`
- CSV export is available as a read-only derived artifact
- export shape is a practical wide CSV for human inspection
- current text batch log baseline remains available
- target-registry behavior remains unchanged
- archive / queue / Web main-flow semantics remain unchanged

## Why Cursor was adopted
Primary reasons:

1. It preserved boundedness better.
   - the task remained centered on append-only telemetry plus read-only CSV
     export
   - it did not widen the task into a larger logging or observability platform

2. It preserved existing public and test-facing behavior more carefully.
   - validate passed fully after the fix-only pass
   - the periodic/batch public call surface was restored to the prior expected
     form after an intermediate mismatch

3. It fit the task center more conservatively.
   - telemetry was added without reopening target source-of-truth migration
   - current text-log baseline was kept as a complement, not a replacement

## Why Copilot was not adopted
Copilot implementation showed a plausible telemetry direction, but was not
selected for this task.

Observed strengths:
- telemetry intent was meaningful
- DB-backed observation plus CSV export direction was reasonable
- richer outcome-oriented observation semantics were attempted

Reasons it was not selected:
- it widened the effective public / near-public call surface more than this
  bounded insertion task could comfortably absorb
- it bypassed existing `run_scrape` patch expectations through a more invasive
  detailed-return flow
- it introduced DB access on skip/no-write paths in ways that broke existing
  bounded expectations
- validate remained failing at review time

Interpretation:
- the Copilot direction was not inherently wrong
- however, it was too invasive for this specific bounded task

## Why Hybrid was not selected
Hybrid was considered, but not selected because:
- Cursor already delivered a passing bounded result
- no small Copilot-only improvement clearly justified additional merge risk
- keeping the review memory simple is preferable

## Validation result
Validation was run with the established workflow:
- `./validate_helix.sh` result at review time:
  - copilot: FAIL
  - cursor: PASS
- adopted final state must also pass post-adoption validation on converged `main`

## Convergence result
To be confirmed at final close-out after adoption into `main`:
- `./compare_helix.sh --all`
- `./validate_helix.sh`

## Repository outcome
- adopted implementation repository: `cursor/`
- comparison-evidence repository: `copilot/`
- the adopted result should be integrated into child-repo `main`
- both child repositories should then be brought to the same adopted final state
  via `main` pull
- convergence should then be confirmed

## Notes for future AI sessions
Important interpretation:
- TASK031B is the bounded append-only telemetry insertion
- DB remains the telemetry source
- CSV remains a read-only derived artifact for humans
- current text logs remain part of the baseline
- this task does not replace logging
- this task does not redesign archive / queue / target registry
- TASK032 should still be treated as the bounded operator-facing target /
  archive management seam

## Meta note
This log is AI-readable review memory.
It is not authoritative current state by itself.

Authoritative context should still be restored from:
- `AI_CONTEXT.md`
- `PROJECT_STATE.md`
- `WORKSPACE.md`
- `project_snapshot.txt`


