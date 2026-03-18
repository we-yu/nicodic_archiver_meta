# TASK019 Adoption Log

## Task
TASK019

Add a bounded whole-archive read path that provides archive listing and
all-articles export from the CLI, while preserving the existing single-article
export path and avoiding Web/API or file-output expansion.

## Decision
Adopted: **Copilot**

Alternative reviewed:
- Cursor implementation was retained as comparison evidence
- Hybrid was considered but not selected

## Final adopted shape
Changed files:
- `cli.py`
- `main.py`
- `tests/test_main.py`
- `tests/test_cli.py`

Production code outside the CLI/archive-read path was not redesigned.

## What changed in the adopted result
The adopted result introduced a bounded whole-archive read path.

Key behavior added:
- `list-articles` CLI entrypoint
- `export-all-articles --format txt` CLI entrypoint
- archive listing remains human-readable and CLI-centered
- listing includes at least:
  - `article_id`
  - `article_type`
  - `title`
  - `created_at`
  - `response_count`
- all-articles export remains stdout-centered
- whole-archive export format is `txt` only in this task
- export output is article-by-article and sectioned
- each article section clearly includes at least:
  - article ID
  - title
  - article top URL
  - export timestamp
- existing single-article export path remains available
- empty DB remains a bounded success case with explicit no-data output
- unsupported format remains a bounded failure case

The adopted result remained CLI-centered and did not expand into:
- Web UI
- API
- file output
- whole-archive `md` / `csv` / `html` export
- parser / storage / http_client / orchestrator redesign
- storage schema redesign

## Why Copilot was adopted
Primary reasons:

1. It matched the fixed TASK019 shape more directly.
   - `archive listing` remained the core capability
   - `all-articles export` remained a paired bounded capability
   - the whole-archive read path was easier to explain

2. It preserved the existing archive-read boundary well.
   - changes remained centered in `cli.py`, `main.py`, and focused tests
   - existing single-article export was preserved cleanly
   - no neighboring module redesign was introduced

3. It made the adopted read/export shape easier to review.
   - listing and export-all responsibilities were clearer
   - sectioned whole-archive export output was explicit
   - CLI-focused behavior protection was stronger and easier to inspect

4. It passed validation cleanly after minor submission-quality cleanup.

## Why Cursor was not adopted
Cursor implementation was valid, bounded, and useful as comparison evidence.

Observed strengths:
- remained CLI-centered
- stayed within the intended TASK019 scope
- kept the file set smaller

Reasons it was not selected:
- the adopted Copilot result kept the whole-archive read path slightly more
  direct and reviewable
- listing/export-all responsibility separation was clearer in the adopted result
- CLI-focused protection was easier to preserve explicitly in the adopted shape

## Why Hybrid was not selected
Hybrid was considered, but not selected because:
- no narrow borrowed change clearly improved the adopted Copilot result enough
  to justify a hybrid
- Copilot already satisfied the intended TASK019 boundary well
- merge-for-the-sake-of-merge was unnecessary
- keeping the review memory simple is preferable

## Validation result
Validation was run with the established workflow:
- `./validate_helix.sh` passed for both child repositories after review cleanup
- post-adoption validation on converged `main` also passed for both child repositories

## Convergence result
- `./compare_helix.sh --all` passed after adoption and synchronization
- `copilot/` and `cursor/` matched on the adopted final state

## Repository outcome
- adopted implementation repository: `copilot/`
- comparison-evidence repository: `cursor/`
- optional adoption marker branch:
  - `adopted/task019-archive-listing`
- the adopted result was integrated into child-repo `main`
- both child repositories were then brought to the same adopted final state
- convergence was confirmed on `main`

## Notes for future AI sessions
Important interpretation:
- TASK019 is complete
- the project now has a bounded whole-archive archive-read path
- archive listing is available from the CLI
- whole-archive export is available in bounded stdout-centered `txt` form
- existing single-article export remains available
- no file-output expansion was introduced in this task
- no Web/API expansion was introduced in this task

## Meta note
This log is AI-readable review memory.
It is not authoritative current state by itself.

Authoritative context should still be restored from:
- `AI_CONTEXT.md`
- `PROJECT_STATE.md`
- `WORKSPACE.md`
- `project_snapshot.txt`

