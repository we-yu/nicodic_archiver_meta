# TASK026 Adoption Log

## Task
TASK026

Minimal request queue persistence.

## Decision
Adopted: **Cursor**

Alternative reviewed:
- Copilot implementation was retained for comparison evidence
- Hybrid was considered but not selected

## Final adopted shape
Changed files:
- `storage.py`
- `tests/test_storage.py`

## What changed in the adopted result
The adopted result introduced a bounded persistence seam for queued article requests.

Key behavior added:
- resolved canonical article targets can now be persisted as queued requests
- duplicate enqueue is handled in bounded form
- queue identity is based on canonical article identity
- enqueue returns a bounded result usable by later callers
- queue state remains minimal and explainable
- the task remained persistence-centered and did not introduce drain behavior

The adopted result did not introduce:
- queue drain execution
- scrape execution changes
- scheduler / worker / retry design
- Web UI / routes / frontend
- broad storage redesign
- job-platform behavior

## Why Cursor was adopted
Primary reasons:

1. It matched the queue-persistence task boundary more directly.
   - the persistence seam stayed centered in the storage layer
   - the result shape was explicit and caller-friendly

2. It used a clearer bounded queue identity model.
   - duplicate handling was tied to canonical article identity
   - duplicate suppression remained explainable

3. It protected persistence semantics more thoroughly in tests.
   - queue creation, enqueue, duplicate suppression, and persistence behavior were covered
   - persistence across connections was explicitly protected

## Why Copilot was not adopted
Copilot implementation was valid, bounded, and passed validation.

Observed strengths:
- minimal change surface
- simple queue-entry model
- bounded duplicate handling

Reasons it was not selected:
- compared with Cursor, the persistence seam result shape was a little less explicit for later callers
- the storage-layer style and persistence protection were slightly weaker than the adopted version

## Why Hybrid was not selected
Hybrid was considered, but not selected because:
- Cursor already satisfied the intended TASK026 boundary well on its own
- no narrow borrowed Copilot change clearly improved the adopted result enough to justify a hybrid
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
  - `adopted/task026-request-queue-persistence`

## Notes for future AI sessions
Important interpretation:
- TASK026 is complete
- minimal request queue persistence now exists
- duplicate enqueue is handled in bounded form
- the task remains pre-drain / pre-Web / pre-scheduler
- future work may build on this seam, but should not retroactively widen TASK026

## Meta note
This log is AI-readable review memory.
It is not authoritative current state by itself.

Authoritative context should still be restored from:
- `AI_CONTEXT.md`
- `PROJECT_STATE.md`
- `WORKSPACE.md`
- `project_snapshot.txt`


