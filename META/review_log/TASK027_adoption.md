# TASK027 Adoption Log

## Task
TASK027

Queue-drain execution path with bounded per-article cap.

## Decision
Adopted: **Cursor**

Alternative reviewed:
- Copilot implementation was retained for comparison evidence
- Hybrid was considered but not selected

## Final adopted shape
Changed files:
- `orchestrator.py`
- `storage.py`
- `tests/test_orchestrator.py`
- `tests/test_storage.py`

## What changed in the adopted result
The adopted result introduced a bounded queue-drain execution path while
reusing the current scrape baseline.

Key behavior added:
- queued requests can now be listed in bounded form
- success-class terminal outcomes are dequeued
- unexpected failures remain queued
- queue-drain applies a named per-article response cap
- queue-drain passes the cap through the existing scrape path explicitly
- cap-reached behavior remains partial-save success-class
- no broad queue status model was introduced

The adopted result did not introduce:
- batch / periodic visible behavior changes as acceptance requirements
- Web UI / routes / frontend
- scheduler / worker / retry framework
- broad storage redesign
- broad queue-state redesign

## Why Cursor was adopted
Primary reasons:

1. It reused the scrape path more naturally.
   - queue-drain cap was passed explicitly through the scrape path
   - no temporary global response-cap mutation was required

2. It matched the fixed TASK027 queue semantics clearly.
   - success dequeue was explicit
   - unexpected failure remain-queued was explicit
   - no broad status model was added

3. It protected the result more thoroughly in tests.
   - queue-drain behavior was covered in orchestrator-facing tests
   - queue listing / dequeue persistence helpers were protected directly

## Why Copilot was not adopted
Copilot implementation was valid, bounded, and useful as comparison evidence.

Observed strengths:
- queue-drain responsibility was easy to spot
- the dedicated queue-drain module was review-friendly
- queue-drain result reporting was explicit

Reasons it was not selected:
- queue-drain cap reuse depended on temporary global `RESPONSE_CAP` mutation
- compared with Cursor, the scrape-path reuse shape was less preferable for
  maintainability in this task

## Why Hybrid was not selected
Hybrid was considered, but not selected because:
- Cursor already satisfied the intended TASK027 shape on its own
- no narrow borrowed Copilot change clearly improved the adopted result enough
  to justify a hybrid
- merge-for-the-sake-of-merge was unnecessary

## Validation result
Validation was run with the established workflow:
- final `./validate_helix.sh` passed for both child repositories

## Convergence result
- `./compare_helix.sh --all` passed after adoption and synchronization
- `copilot/` and `cursor/` matched on the adopted final state

## Repository outcome
- adopted implementation repository: `cursor`
- comparison-evidence repository: `copilot`
- optional adoption marker branch:
  - `adopted/task027-queue-drain-cap`

## Notes for future AI sessions
Important interpretation:
- TASK027 is complete
- bounded queue-drain execution now exists
- queue-drain uses a named per-article cap in bounded form
- cap-reached behavior remains success-class partial-save
- queue persistence still remains minimal and explainable
- the task remained pre-Web / pre-route / pre-worker-framework

## Meta note
This log is AI-readable review memory.
It is not authoritative current state by itself.

Authoritative context should still be restored from:
- `AI_CONTEXT.md`
- `PROJECT_STATE.md`
- `WORKSPACE.md`
- `project_snapshot.txt`


