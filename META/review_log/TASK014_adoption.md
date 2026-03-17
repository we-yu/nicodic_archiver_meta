# TASK014 Adoption Log

## Task
TASK014

Add a bounded batch scrape command using the target list, while reusing the
existing single-article scrape flow and preserving current single-article save
semantics.

## Decision
Adopted: **Cursor**

Alternative reviewed:
- Copilot implementation was retained as comparison evidence
- Hybrid was considered but not selected

## Final adopted shape
Changed files:
- `main.py`
- `orchestrator.py`
- `tests/test_main.py`
- `tests/test_orchestrator.py`

## What changed in the adopted result
The adopted result introduced a bounded batch scrape command centered on the
CLI/application entry layer.

Key behavior added:
- batch execution using the existing target list
- bounded serial multi-target execution
- continue-on-error across targets
- target-level success / failure visibility in CLI output
- final non-zero exit when any target fails

The adopted result reused the existing single-article scrape flow for each
target and did not redesign single-article save semantics.

## Why Cursor was adopted
Primary reasons:

1. It matched the fixed TASK014 semantics more directly.
   - continue-on-error was handled explicitly
   - final non-zero on any failure was handled explicitly
   - target-level success / failure visibility was clearer

2. It handled non-exception single-article non-success outcomes more clearly.
   - a minimal batch-facing success signal was added to `run_scrape()`
   - this allowed the batch layer to distinguish success from skip / failure
     more accurately than exception-only handling

3. It preserved the intended task boundary.
   - no parallel / distributed execution
   - no retry / backoff expansion
   - no scheduler expansion
   - no parser / storage / http_client redesign
   - no single-article save-semantics redesign

4. It remained reviewable.
   - the batch behavior was easy to identify
   - the representative tests made the batch semantics visible

## Why Copilot was not adopted
Copilot implementation was valid and conservative.

Observed strengths:
- very small change surface
- batch glue stayed tightly centered in `main.py`
- tests were focused and review-friendly

Reasons it was not selected:
- failure handling depended mainly on exceptions
- non-exception single-article non-success paths were less clearly reflected
  in batch success / failure judgment
- because of that, the fixed TASK014 semantics were expressed less completely

## Why Hybrid was not selected
Hybrid was considered, but not selected because:
- the main difference was not cosmetic
- Cursor more fully satisfied the intended TASK014 semantics on its own
- no narrow borrowed adjustment from Copilot clearly improved the adopted
  result enough to justify a hybrid
- keeping the adoption decision simple improves review memory clarity

## Validation result
Validation was run with the established workflow:
- `./validate_helix.sh` passed for both child repositories before adoption
- post-adoption validation on converged `main` also passed

## Convergence result
- `./compare_helix.sh --all` passed after realignment
- `copilot/` and `cursor/` matched on the adopted final state

## Repository outcome
- adopted implementation repository: `cursor/`
- comparison-evidence repository: `copilot/`
- optional adoption marker branch:
  - `adopted/task014-batch-scrape`
- after integration, both child repositories were realigned to the same
  adopted final state

## Notes for future AI sessions
Important interpretation:
- TASK014 is complete
- the project now has a bounded batch scrape command using the target list
- batch execution remains serial and CLI-centered
- single-article save semantics were not redesigned in TASK014
- future planning may proceed toward run logging / status recording and later
  periodic execution, while preserving the adopted batch baseline

## Meta note
This log is AI-readable review memory.
It is not authoritative current state by itself.

Authoritative context should still be restored from:
- `AI_CONTEXT.md`
- `PROJECT_STATE.md`
- `WORKSPACE.md`
- `project_snapshot.txt`

