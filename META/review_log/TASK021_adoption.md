# TASK021 Adoption Log

## Task
TASK021

Add bounded periodic operation packaging for the provisional personal-use
runtime, making the existing periodic execution entrypoint practical to run
against the manually maintained text target list, while adding only simple
lock + skip overlap handling and avoiding cron packaging, scheduler-framework
expansion, target-registry redesign, or Web/API expansion.

## Decision
Adopted: **Copilot**

Alternative reviewed:
- Cursor implementation was retained as comparison evidence
- Hybrid was considered but not selected

## Final adopted shape
Changed files:
- `docs/PERSONAL_RUNTIME.md`
- `main.py`
- `runtime/periodic_once.sh`
- `tests/test_main.py`

The adopted result remained a bounded runtime / CLI / ops task.

## What changed in the adopted result
The adopted result introduced bounded periodic packaging for the existing
runtime profile.

Key behavior added:
- a host-side one-shot wrapper:
  - `runtime/periodic_once.sh`
- a bounded CLI entry:
  - `python main.py periodic-once <target_list_path>`
- simple overlap handling using lock + skip
- scheduler-friendly non-interactive invocation via runtime wrapper
- runtime operations documentation was extended in the existing
  `docs/PERSONAL_RUNTIME.md`

The adopted result preserved:
- the existing text-file target list as the source of truth
- the existing periodic execution semantics as the underlying execution path
- the current SQLite / archive / log accumulation model

The adopted result did not introduce:
- container-internal cron
- scheduler framework behavior
- advanced overlap / fairness / queue policy
- target-registry redesign
- Web / API expansion

## Why Copilot was adopted
Primary reasons:

1. It matched the TASK021 task center more directly.
   - The task was about periodic operation packaging for the provisional runtime
   - Copilot kept the center of gravity in the runtime wrapper and runtime docs

2. It kept overlap handling bounded and scheduler-facing.
   - simple lock + skip was implemented in the wrapper layer
   - this avoided pulling overlap policy too far into product semantics

3. It connected TASK020 and TASK016 cleanly.
   - TASK020 introduced the provisional runtime profile
   - TASK016 introduced the periodic entrypoint
   - Copilot connected those two adopted baselines in a practical and
     reviewable way

4. It preserved boundedness well.
   - no cron packaging
   - no scheduler framework
   - no registry redesign
   - no Web / API expansion

## Why Cursor was not adopted
Cursor implementation was valid and useful as comparison evidence.

Observed strengths:
- stronger direct test protection around lock/skip behavior
- clearer CLI-level visibility for skip / failure semantics
- practical external-scheduler-facing one-shot idea was present

Reasons it was not selected:
- the lock / skip policy moved further into product code
- the result centered slightly less on the provisional runtime profile itself
- compared with Copilot, the adopted runtime-packaging task shape was less
  direct and slightly less conservative

## Why Hybrid was not selected
Hybrid was considered, but not selected because:
- Copilot already satisfied the bounded TASK021 intent well on its own
- the main Cursor advantage was broader lock/skip protection, but borrowing
  from it would likely pull overlap-control logic further into product code
- merge-for-the-sake-of-merge was unnecessary
- keeping the review memory simple is preferable

## Validation result
Validation was run with the established workflow:
- `./validate_helix.sh` passed for both child repositories
- post-adoption validation on converged `main` also passed for both child
  repositories

## Convergence result
- `./compare_helix.sh --all` passed after adoption and synchronization
- `copilot/` and `cursor/` matched on the adopted final state

## Repository outcome
- adopted implementation repository: `copilot/`
- comparison-evidence repository: `cursor/`
- adoption marker branch:
  - `adopted/task021-periodic-runtime-packaging`
- the adopted result was integrated into child-repo `main`
- both child repositories were then brought to the same adopted final state
  via `main` pull
- convergence was confirmed on `main`

## Notes for future AI sessions
Important interpretation:
- TASK021 is complete
- the project now has bounded periodic operation packaging for the provisional
  personal-use runtime
- a host-side one-shot runtime wrapper now exists
- simple lock + skip overlap handling now exists in bounded form
- the text target list remains the source of truth
- container-internal cron was not introduced
- no scheduler-framework expansion was introduced
- no dedicated smoke-test helper was added
- lightweight external scheduling compatibility is improved, but still remains
  intentionally bounded

## Meta note
This log is AI-readable review memory.
It is not authoritative current state by itself.

Authoritative context should still be restored from:
- `AI_CONTEXT.md`
- `PROJECT_STATE.md`
- `WORKSPACE.md`
- `project_snapshot.txt`


