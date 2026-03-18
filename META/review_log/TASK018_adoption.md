# TASK018 Adoption Log

## Task
TASK018

Add a bounded target intake / add-target command that allows a new scrape target
to be appended to the plain-text target list from the CLI, while preserving the
file/CLI-based model and avoiding target-management subsystem expansion.

## Decision
Adopted: **Copilot**

Alternative reviewed:
- Cursor implementation was retained as comparison evidence
- Hybrid was considered but not selected

## Final adopted shape
Changed files:
- `main.py`
- `target_list.py`
- `tests/test_main.py`
- `tests/test_target_list.py`

Production code outside the target-list / CLI entry path was not redesigned.

## What changed in the adopted result
The adopted result introduced a bounded add-target entrypoint for future scrape
targets.

Key behavior added:
- `add-target` CLI entrypoint
- one target URL appended at a time
- plain-text target list reused as the source of truth
- exact duplicate targets are not added
- minimal syntax validation is performed
- invalid permanent state is not stored
- online existence check is intentionally not performed
- bounded result messages for added / duplicate / invalid outcomes

The adopted result remained file/CLI-based and did not expand into queue
systems, DB-backed target registries, request platforms, Web/API work, or
online validation design.

## Why Copilot was adopted
Primary reasons:

1. It matched the fixed TASK018 semantics more directly.
   - one target added at a time
   - plain-text target list remained the source of truth
   - duplicate handling was simple and bounded
   - minimal syntax validation stayed minimal

2. It stayed well bounded.
   - changes remained centered in `target_list.py`, `main.py`, and focused tests
   - no parser / storage / http_client redesign
   - no queue / DB / Web / API expansion
   - no online existence check

3. It made the intended intake semantics easier to review.
   - add / duplicate / invalid outcomes were explicit
   - append behavior and no-write-on-invalid behavior were protected in tests
   - the validation scope remained clearly minimal

4. It passed validation cleanly after review.

## Why Cursor was not adopted
Cursor implementation was valid, bounded, and useful as comparison evidence.

Observed strengths:
- remained file/CLI-based
- preserved bounded target intake scope
- kept online validation out of the task

Reasons it was not selected:
- the adopted Copilot result aligned slightly more directly with the intended
  minimal-intake shape
- Cursor leaned a little further into validation strictness / reason taxonomy
  than was necessary for this bounded task

## Why Hybrid was not selected
Hybrid was considered, but not selected because:
- no narrow borrowed change clearly improved the adopted Copilot result enough
  to justify a hybrid
- Copilot already satisfied the intended TASK018 boundary well
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
  - `adopted/task018-add-target`
- after product-repo integration, both child repositories were realigned to the
  same adopted final state

## Notes for future AI sessions
Important interpretation:
- TASK018 is complete
- the project now has a bounded add-target intake command
- target intake remains file/CLI-based
- one target is added at a time
- exact duplicate targets are not added
- minimal syntax validation is performed
- online existence check was not introduced in this task
- no queue / DB-backed registry / Web / API expansion was introduced

## Meta note
This log is AI-readable review memory.
It is not authoritative current state by itself.

Authoritative context should still be restored from:
- `AI_CONTEXT.md`
- `PROJECT_STATE.md`
- `WORKSPACE.md`
- `project_snapshot.txt`

