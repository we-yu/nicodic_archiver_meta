# TASK013 Adoption Log

## Task
TASK013

Introduce a plain-text file-based target source together with a bounded loader
and bounded CLI/application entry, without expanding into batch scrape,
scheduler, request intake, or DB-backed target registry design.

## Decision
Adopted: **Copilot implementation**

Alternative reviewed:
- Cursor implementation was retained as comparison evidence
- Hybrid was considered but not selected

## Final adopted shape
Changed files:
- `target_list.py`
- `main.py`
- `tests/test_main.py`
- `tests/test_target_list.py`

## What changed in the adopted result
The adopted result introduced a minimal plain-text target source for article URLs.

Key behavior added:
- human-editable plain-text target file support
- bounded loader that reads a stable URL list from file input
- bounded CLI entry that loads and displays target URLs
- focused tests protecting loader behavior and CLI entry behavior

The adopted result kept this target source explicitly provisional and did not
treat it as a long-term registry design.

## Why Copilot was adopted
Primary reasons:

1. It matched the TASK013 boundary more conservatively.
   - It introduced the target source, loader, and entry
   - It stopped at loading and listing targets
   - It did not step into scrape execution from the target list

2. It preserved the intended task shape clearly.
   - plain text target list
   - bounded loader
   - bounded CLI/application entry
   - no batch scrape expansion

3. It stayed within bounded functional expansion.
   - no scheduler
   - no request intake
   - no DB-backed target registry
   - no parser / storage / http_client redesign

4. It remained review-friendly.
   - the target-loading responsibility was easy to identify
   - focused tests clearly protected the new bounded behavior

## Why Cursor was not adopted
Cursor implementation was valid and useful as comparison evidence.

Observed strengths:
- it kept the loader responsibility bounded
- it clearly marked the file-based source as provisional
- it connected the target list to application flow in a practical way

Reasons it was not selected:
- it went one step further by executing `run_scrape()` on the first loaded target
- that moved slightly closer to TASK014-style flow
- compared with Copilot, the TASK013 boundary was less conservative

## Why Hybrid was not selected
Hybrid was considered, but not selected because:
- both implementations were already small and coherent
- no narrow borrowed adjustment clearly improved the adopted Copilot result enough to justify a hybrid
- merge-for-the-sake-of-merge was unnecessary
- a simpler adoption decision is easier to preserve as review memory

## Validation result
Validation was run with the established workflow:
- `./validate_helix.sh` passed for both child repositories after minor cleanup
- final post-adoption validation on `main` passed

## Convergence result
- `./compare_helix.sh --all` passed after realignment
- `copilot/` and `cursor/` matched on the adopted final state

## Repository outcome
- adopted implementation repository: `copilot/`
- comparison-evidence repository: `cursor/`
- optional adoption marker branch:
  - `adopted/task013-target-list-loading`
- after integration, both child repositories were realigned to the same adopted final state

## Notes for future AI sessions
Important interpretation:
- TASK013 is complete
- the project now has a provisional plain-text target source and bounded loading path
- batch scrape behavior is still intentionally out of scope
- future planning may now proceed toward TASK014-style batch execution using this bounded input path

## Meta note
This log is AI-readable review memory.
It is not authoritative current state by itself.

Authoritative context should still be restored from:
- `AI_CONTEXT.md`
- `PROJECT_STATE.md`
- `WORKSPACE.md`
- `project_snapshot.txt`

