# TASK022 Adoption Log

## Task
TASK022

Prepare a bounded archive read / export interface seam so that the existing
CLI archive-read behavior remains intact while future read-facing interfaces
such as a separate runtime, Web UI, or API can reuse the read path more
cleanly, without introducing Web/API implementation, target-registry redesign,
storage redesign, or archive-write redesign.

## Decision
Adopted: **Copilot**

Alternative reviewed:
- Cursor implementation was retained as comparison evidence
- Hybrid was considered but not selected

## Final adopted shape
Changed files:
- `archive_read.py`
- `cli.py`
- `tests/test_cli.py`

The adopted result remained a bounded read/export seam-preparation task.

## What changed in the adopted result
The adopted result introduced a thin archive read seam by moving archive-facing
SQLite read responsibilities out of `cli.py` into a new helper module.

Key behavior added or clarified:
- `archive_read.py` now owns archive-facing read helpers
- `cli.py` remains responsible for CLI-facing formatting and stdout emission
- single-article export still supports existing `txt` / `md` behavior
- whole-archive listing and whole-archive export remain available
- the user-visible CLI behavior was preserved

The adopted result remained:
- pre-Web / pre-API
- read-only in scope
- bounded and explainable

The adopted result did not introduce:
- Web routes
- API handlers
- application framework adoption
- target-registry redesign
- storage schema redesign
- archive-write redesign
- runtime topology separation
- cross-layer frameworkization

## Why Copilot was adopted
Primary reasons:

1. It matched the TASK022 task center more directly.
   - The task was to prepare a thin archive read / export seam
   - Copilot moved archive-read responsibilities out of `cli.py`
     while keeping the task tightly centered on the CLI consumer path

2. It preserved boundedness more conservatively.
   - The file set remained small and task-direct
   - review stayed centered on `cli.py`, the new read seam, and focused CLI tests

3. It made responsibility split easier to review.
   - `archive_read.py` owns archive data retrieval
   - `cli.py` owns formatting and stdout behavior
   - this separation is clear without broad abstraction

4. It preserved CLI compatibility while avoiding unnecessary expansion.
   - no `main.py` redesign was required
   - no framework-like interface layer was introduced
   - no write-path or target-intake drift occurred

## Why Cursor was not adopted
Cursor implementation was valid and useful as comparison evidence.

Observed strengths:
- stronger direct test protection around the seam helpers
- clear helper naming and typing
- practical future-facing options such as optional DB path parameters

Reasons it was not selected:
- it was slightly broader than necessary for TASK022
- `tests/test_main.py` was also touched, widening the review surface
- the result leaned a little further toward future flexibility than the bounded
  seam-preparation task strictly required

## Why Hybrid was not selected
Hybrid was considered, but not selected because:
- Copilot already satisfied the bounded TASK022 intent well on its own
- borrowing Cursor elements would mainly increase flexibility or test breadth,
  but was not necessary to make the adopted result valid
- merge-for-the-sake-of-merge was unnecessary
- keeping the review memory simple is preferable

## Validation result
Validation was run with the established workflow:
- `./validate_helix.sh` passed for both child repositories
- after final convergence, post-adoption validation on `main` also passed for
  both child repositories

## Convergence result
- `./compare_helix.sh --all` passed after adoption and synchronization
- `copilot/` and `cursor/` matched on the adopted final state

## Repository outcome
- adopted implementation repository: `copilot/`
- comparison-evidence repository: `cursor/`
- adoption marker branch:
  - `adopted/task022-archive-read-seam`
- the adopted result was integrated into child-repo `main`
- both child repositories were then brought to the same adopted final state
  via `main` pull
- convergence was confirmed on `main`

## Notes for future AI sessions
Important interpretation:
- TASK022 is complete
- the project now has a bounded archive read / export seam
- archive-facing data retrieval is more clearly separated from CLI formatting
- the current CLI behavior remains the active interface
- the result is still pre-Web / pre-API
- this task does not implement a separate read-facing runtime or Web/API layer
- this task prepares a seam that later read-facing interfaces may reuse

## Meta note
This log is AI-readable review memory.
It is not authoritative current state by itself.

Authoritative context should still be restored from:
- `AI_CONTEXT.md`
- `PROJECT_STATE.md`
- `WORKSPACE.md`
- `project_snapshot.txt`


