# TASK031 Adoption Log

## Task
TASK031

Migrate the scrape target source of truth away from the provisional
plain-text target list into a bounded SQLite-backed target registry,
while preserving the already-adopted Web/runtime/archive baseline and
keeping the task centered on target-registry ownership rather than broad
DB-platform redesign.

## Decision
Adopted: **Copilot**

Alternative reviewed:
- Cursor implementation was retained as comparison evidence
- Hybrid was considered but not selected

## Final adopted shape
Changed files in the adopted product result:
- `docker-compose.runtime.yml`
- `docs/PERSONAL_RUNTIME.md`
- `main.py`
- `runtime/periodic_once.sh`
- `storage.py`
- `target_list.py`
- `tests/test_main.py`
- `tests/test_storage.py`
- `tests/test_target_list.py`
- `tests/test_web_app.py`
- `web_app.py`

## What changed in the adopted result
The adopted result introduced a bounded SQLite-backed target registry as the
new scrape target source of truth.

Key behavior added:
- the long-term scrape target source of truth is no longer the plain-text
  target list in mainline flow
- a SQLite `target` table now stores scrape targets
- the table uses:
  - surrogate integer primary key: `id`
  - canonical identity: `article_id + article_type`
  - stored `canonical_url`
  - bounded `is_active`
  - `created_at`
- Web-side target registration now writes to the target registry
- Web-side target registration still does not enqueue work
- Web-side target registration still does not trigger immediate scrape execution
- periodic / batch / cron-facing target reads now use the same target registry
- active-only target listing is supported in bounded form
- duplicate canonical target registration remains bounded
- inactive canonical targets can be reactivated in bounded form
- legacy `targets.txt` can still be imported through an explicit admin-only,
  one-shot, non-automatic path
- the runtime profile and runtime documentation now point to the SQLite-backed
  target registry rather than the plain-text file as the active source of truth

The adopted result did not introduce:
- archive source-of-truth redesign
- queue persistence / drain redesign
- log schema redesign
- observability / dashboard expansion
- GUI admin tooling
- PostgreSQL migration
- DB containerization
- pgAdmin-like integration

## Why Copilot was adopted
Primary reasons:

1. It matched the fixed TASK031 center more directly.
   - the task was a bounded target source-of-truth migration
   - Copilot kept the center of gravity on target-registry ownership rather
     than broader implementation convenience

2. It preserved explicit runtime / path plumbing more clearly.
   - DB-backed target path handling remained visible in `main.py`,
     runtime wrapper wiring, and runtime documentation
   - the resulting runtime story stayed easier to review and operate

3. It preserved module responsibility boundaries more cleanly.
   - `storage.py` remained the persistence owner
   - `target_list.py` remained the target-source handling seam
   - the adopted shape stays easier to extend later for bounded operator-facing
     management without forcing TASK032 into TASK031

4. It handled bounded inactive-target reactivation more explicitly.
   - inactive targets can return to the active registry through the same
     bounded registration path
   - this preserves a small but practical state model without widening the
     task into broad target management

## Why Cursor was not adopted
Cursor implementation was valid and useful as comparison evidence.

Observed strengths:
- readable target-registry-oriented naming
- clear IN / OUT separation intent
- validation passed cleanly

Reasons it was not selected:
- explicit DB-path plumbing became slightly less direct in the review result
- some target-handling logic leaned less cleanly around the storage / target
  seam than the adopted result
- compared with Copilot, the final bounded migration story was slightly less
  conservative and slightly less review-friendly for this specific task

## Why Hybrid was not selected
Hybrid was considered, but not selected because:
- Copilot already satisfied the intended TASK031 boundary well on its own
- no narrow borrowed Cursor adjustment clearly improved the adopted result
  enough to justify a hybrid
- merge-for-the-sake-of-merge was unnecessary
- keeping the review memory simple is preferable

## Validation result
Validation was run with the established workflow:
- `./validate_helix.sh` passed for both child repositories on the review state
- post-adoption validation on converged `main` also passed

## Convergence result
- `./compare_helix.sh --all` passed after adoption and synchronization
- `copilot/` and `cursor/` matched on the adopted final state

## Repository outcome
- adopted implementation repository: `copilot/`
- comparison-evidence repository: `cursor/`
- optional adoption marker branch may be used as:
  - `adopted/task031-target-registry`
- the adopted result was integrated into child-repo `main`
- both child repositories were then brought to the same adopted final state
  via `main` pull
- convergence was confirmed on `main`

## Notes for future AI sessions
Important interpretation:
- TASK031 is complete
- the project now has a bounded SQLite-backed target registry as the scrape
  target source of truth
- the plain-text target list is no longer the long-term source of truth in
  mainline flow
- Web-side registration remains bounded and still does not enqueue or trigger
  immediate scrape execution
- periodic / batch / cron now read from the target registry
- legacy `targets.txt` remains only as an explicit admin import source
- TASK032 should be treated as the next bounded operator-facing target /
  archive management seam, rather than as part of TASK031

## Meta note
This log is AI-readable review memory.
It is not authoritative current state by itself.

Authoritative context should still be restored from:
- `AI_CONTEXT.md`
- `PROJECT_STATE.md`
- `WORKSPACE.md`
- `project_snapshot.txt`


