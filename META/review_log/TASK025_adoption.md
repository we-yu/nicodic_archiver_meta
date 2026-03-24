# TASK025 Adoption Log

## Task
TASK025

Archive-read / export reuse for non-CLI consumers.

## Decision
Adopted: **Cursor**

Alternative reviewed:
- Copilot implementation was retained as comparison evidence
- Hybrid was considered but not selected

## Final adopted shape
Changed files:
- `archive_read.py`
- `cli.py`
- `tests/test_archive_read.py`
- `tests/test_cli.py`

## What changed in the adopted result
The adopted result extended the existing archive-read seam for bounded non-CLI reuse.

Key behavior added:
- a bounded saved-article existence check was added for one article
- a bounded one-article TXT retrieval path was added for non-CLI callers
- missing article handling was exposed in a bounded non-CLI-friendly shape
- existing CLI txt export path was updated to reuse the new read-side seam
- existing CLI-visible behavior for export/list remained preserved

The adopted result remained:
- pre-Web
- pre-route
- pre-queue
- single-article TXT focused

The adopted result did not introduce:
- Web UI / routes
- queue persistence / drain
- multi-format expansion
- storage schema redesign
- archive-write redesign

## Why Cursor was adopted
Primary reasons:

1. It matched the bounded read-side reuse goal more directly.
   - the saved existence check used a bounded `SELECT 1 ... LIMIT 1`
   - existence checking did not require reading the whole archive payload

2. It treated non-CLI reuse as a real read-side interface.
   - one-article TXT retrieval returned a bounded result shape usable by later non-CLI callers
   - missing article state was represented explicitly and predictably

3. It preserved CLI behavior while keeping the task centered on reuse.
   - `cli.py` was adjusted only enough to reuse the new seam
   - list/export-all behavior remained unchanged

## Why Copilot was not adopted
Copilot implementation was valid and bounded, and it passed final validation.

Observed strengths:
- simple TXT retrieval
- preserved CLI-visible behavior
- focused task scope

Reasons it was not selected:
- `has_saved_article()` was implemented in a way that depended on reading the full article archive rather than using a more bounded existence check
- compared with Cursor, the adopted result was slightly weaker as a non-CLI read-side reuse seam

## Why Hybrid was not selected
Hybrid was considered, but not selected because:
- Cursor already satisfied the intended TASK025 boundary well on its own
- no narrow borrowed Copilot change clearly improved the adopted result enough to justify a hybrid
- merge-for-the-sake-of-merge was unnecessary

## Validation result
Validation was run with the established workflow:
- initial Copilot validation failed only due to missing trailing newline at EOF in a new test file
- that localized submission-quality issue was corrected immediately
- final `./validate_helix.sh` passed for both child repositories

## Convergence result
- `./compare_helix.sh --all` passed after adoption and synchronization
- `copilot/` and `cursor/` matched on the adopted final state

## Repository outcome
- adopted implementation repository: `cursor`
- comparison-evidence repository: `copilot`
- optional adoption marker branch:
  - `adopted/task025-archive-read-reuse`

## Notes for future AI sessions
Important interpretation:
- TASK025 is complete
- bounded archive-read reuse now exists for non-CLI consumers
- saved existence checks and one-article TXT retrieval are now easier to call outside CLI
- the task remains pre-Web / pre-queue / pre-route
- future work may build on this seam, but should not retroactively widen TASK025

## Meta note
This log is AI-readable review memory.
It is not authoritative current state by itself.

Authoritative context should still be restored from:
- `AI_CONTEXT.md`
- `PROJECT_STATE.md`
- `WORKSPACE.md`
- `project_snapshot.txt`


