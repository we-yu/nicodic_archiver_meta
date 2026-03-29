# TASK032 Adoption Log

## Task
TASK032

Add a bounded human-usable operator tooling seam for single-operator target
registry and saved archive management, using a CLI / shell-tooling first
interface, while keeping the task out of Web admin, observability/dashboard,
destructive maintenance, PostgreSQL migration, and DB containerization.

## Decision
Adopted: **Copilot**

Alternative reviewed:
- Cursor implementation was retained as comparison evidence
- Hybrid was considered but not selected

## Final adopted shape
Changed files in the adopted product result:
- `README.md`
- `cli.py`
- `docs/OPERATOR_TOOLING.md`
- `docs/PERSONAL_RUNTIME.md`
- `main.py`
- `operator_cli.py`
- `storage.py`
- `target_list.py`
- `tests/test_main.py`
- `tests/test_operator_cli.py`
- `tests/test_storage.py`
- `tests/test_target_list.py`
- `tools/operator.sh`

## What changed in the adopted result
The adopted result introduced a bounded operator-first CLI / shell tooling seam
for single-operator target registry and saved archive management.

Key behavior added:
- target registry list
- target registry inspect
- canonical target add
- target deactivate
- target reactivate
- saved archive list
- saved archive inspect
- saved archive export
- repo-local shell wrapper for operator usage
- operator-focused documentation for daily / periodic use
- runtime-facing documentation pointing operators to the new bounded tooling

The adopted result stayed additive and did not redesign scrape, batch,
periodic, Web, archive source-of-truth, or telemetry semantics.

## Why Copilot was adopted
Primary reasons:

1. It matched the TASK032 task center more directly.
   - the implementation centered clearly on a bounded human-usable operator
     tooling seam
   - target registry and archive actions were exposed in a directly usable,
     operator-first shape
   - usability was treated as part of the task, not as a side note

2. It preserved the intended boundary more clearly.
   - target add was intentionally limited to canonical article URLs
   - this kept registry management action-oriented and non-ambiguous
   - title resolution was not mixed into the operator target-management path

3. It provided stronger operator guidance.
   - a dedicated operator guide was added
   - runtime-facing documentation was updated to point operators to the new
     bounded tooling
   - the result better reflected the intended single-operator daily / periodic
     usage shape

4. It remained within the fixed non-goals.
   - no target delete
   - no archive delete
   - no archive requeue / re-fetch
   - no Web operator UI
   - no telemetry/dashboard expansion
   - no PostgreSQL migration
   - no DB containerization

## Why Cursor was not adopted
Cursor implementation was valid and useful as comparison evidence.

Observed strengths:
- smaller change surface
- thin `main.py` integration
- good reviewability
- bounded helper additions in storage / tooling

Reasons it was not selected:
- the operator target add path accepted `url_or_title`
- that mixed resolver behavior into the management seam more than intended
- compared with the adopted Copilot result, the fixed TASK032 boundary was less
  strict around action-oriented and non-ambiguous operator behavior
- usability and operator guidance were lighter than in the adopted result

## Why Hybrid was not selected
Hybrid was considered, but not selected because:
- the main difference was not cosmetic
- the more important distinction was task-center interpretation
- the adopted Copilot result already satisfied the intended TASK032 shape well
- no narrow borrowed Cursor adjustment was clearly necessary to make the
  adopted result valid, bounded, and explainable
- merge-for-the-sake-of-merge was unnecessary

## Validation result
Validation was run with the established workflow:
- `./validate_helix.sh` passed for both child repositories on converged `main`

## Convergence result
- `./compare_helix.sh --all` passed after adoption and synchronization
- `copilot/` and `cursor/` matched on the adopted final state

## Repository outcome
- adopted implementation repository: `copilot/`
- comparison-evidence repository: `cursor/`
- optional adoption marker branch:
  - `adopted/task032-operator-tooling`
- after integration, both child repositories were realigned to the same
  adopted final state

## Notes for future AI sessions
Important interpretation:
- TASK032 is complete
- the project now has a bounded human-usable operator tooling seam
- first interface is CLI / shell-tooling
- target registry management now includes list / inspect / add /
  deactivate / reactivate
- saved archive management now includes list / inspect / export
- telemetry / CSV export remains a support layer
- current Web/runtime/archive main-flow semantics remain in place
- Web operator UI remains out of scope
- destructive maintenance remains out of scope

## Meta note
This log is AI-readable review memory.
It is not authoritative current state by itself.

Authoritative context should still be restored from:
- `AI_CONTEXT.md`
- `PROJECT_STATE.md`
- `WORKSPACE.md`
- `project_snapshot.txt`


