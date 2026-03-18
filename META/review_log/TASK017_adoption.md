# TASK017 Adoption Log

## Task
TASK017

Add a bounded archive export / readout command that allows a saved article
archive to be exported from the CLI in practical text-based formats, while
remaining stdout-centered and avoiding Web/API expansion.

## Decision
Adopted: **Copilot**

Alternative reviewed:
- Cursor implementation was retained as comparison evidence
- Hybrid was considered but not selected

## Final adopted shape
Changed files:
- `.gitignore`
- `cli.py`
- `main.py`
- `tests/test_main.py`
- `tests/test_cli.py`

Production code outside the CLI/readout path was not redesigned.

## What changed in the adopted result
The adopted result introduced a bounded export/readout command for saved
article archives.

Key behavior added:
- `export` CLI entrypoint
- target specified by `article_id + article_type`
- supported formats:
  - `txt`
  - `md`
- stdout-centered output
- saved article metadata + saved responses are rendered in human-readable form
- unsupported format returns bounded failure
- missing article returns bounded failure
- existing scrape / save semantics were not redesigned
- existing inspect command was preserved

The adopted result remained CLI-centered and did not expand into Web UI, API,
CSV support, multi-article export, parser/storage/http_client redesign, or
broad presentation-layer framework work.

## Why Copilot was adopted
Primary reasons:

1. It matched the fixed TASK017 semantics more directly.
   - one saved article identified by `article_id + article_type`
   - bounded stdout-centered export
   - `txt` and `md` support without broader interface expansion

2. It stayed well bounded.
   - changes remained centered in `cli.py`, `main.py`, and focused tests
   - no parser / storage / http_client redesign
   - no Web/API/CSV expansion
   - no multi-article export expansion

3. It made the read path and export behavior easier to review.
   - shared loader behavior in `cli.py` was clear
   - error handling for unsupported format / missing article was explicit
   - txt/md rendering remained practical and simple

4. It passed validation cleanly after submission-quality cleanup.

## Why Cursor was not adopted
Cursor implementation was valid, bounded, and useful as comparison evidence.

Observed strengths:
- remained CLI-centered
- used `article_id + article_type`
- supported bounded txt/md export

Reasons it was not selected:
- the adopted Copilot result kept the export/readout path slightly more
  direct and reviewable for the fixed TASK017 scope
- Cursor leaned a little further into presentation details than was necessary
  for this bounded task

## Why Hybrid was not selected
Hybrid was considered, but not selected because:
- no narrow borrowed change clearly improved the adopted Copilot result enough
  to justify a hybrid
- Copilot already satisfied the intended TASK017 boundary well
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
  - `adopted/task017-archive-export`
- after product-repo integration, both child repositories were realigned to the
  same adopted final state

## Notes for future AI sessions
Important interpretation:
- TASK017 is complete
- the project now has a bounded archive export / readout command
- export remains CLI-centered and stdout-centered
- one saved article is exported at a time
- target selection uses `article_id + article_type`
- supported export formats are `txt` and `md`
- no Web/API/CSV expansion was introduced in this task

## Meta note
This log is AI-readable review memory.
It is not authoritative current state by itself.

Authoritative context should still be restored from:
- `AI_CONTEXT.md`
- `PROJECT_STATE.md`
- `WORKSPACE.md`
- `project_snapshot.txt`

