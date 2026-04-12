# SUBTASK004 Runtime Local Env Hardening

## Task
SUBTASK004

Add bounded runtime local-env / recreate / permission hardening so that
provisional runtime operation is less likely to fail due to stale container
code, port clashes, or LOCAL_UID / LOCAL_GID mismatch.

## Positioning
This is a bounded runtime / ops hardening subtask.

It does not change product semantics.
It does not redesign scrape, batch, periodic, DB, queue, scheduler, or Web
behavior.

It specifically hardens the provisional runtime workflow around:
- local runtime env handling
- runtime recreate flow
- permission mismatch prevention
- bounded local preflight guidance

## Background
A provisional runtime failure was observed after mainline changes had already
been merged and pulled into the runtime checkout.

The practical failure pattern was:
- host checkout had current code
- long-lived runtime container still had stale baked `/app` code
- runtime periodic execution path could therefore mismatch current DB-backed
  target-registry baseline
- runtime startup / recreate could also fail or become fragile due to:
  - host port clashes
  - LOCAL_UID / LOCAL_GID mismatch
  - writable-path mismatch on mounted runtime data / logs

The goal of this subtask was to reduce repeat failures without widening into a
deployment-platform redesign.

## What changed
Changed files in the adopted product result:
- `.gitignore`
- `.env.runtime.local.example`
- `docs/PERSONAL_RUNTIME.md`
- `runtime/periodic_once.sh`
- `tools/runtime_env.sh`
- `tools/runtime_up.sh`
- `tests/test_runtime_local_ops.py`

Added / changed behavior:
- `.env.runtime.local` is now treated as local-only runtime config
- `.gitignore` now excludes `.env.runtime.local`
- `.env.runtime.local.example` provides the expected local runtime keys:
  - `WEB_BIND_HOST`
  - `WEB_PORT`
  - `LOCAL_UID`
  - `LOCAL_GID`
- `tools/runtime_env.sh` now provides bounded shared helper behavior for:
  - local env loading
  - safe fallback defaults
  - host UID/GID auto-detection
  - `WEB_PORT` validation
  - bounded host port-busy warning
- `tools/runtime_up.sh` now provides a bounded recreate-oriented runtime
  startup wrapper using build + force-recreate
- `runtime/periodic_once.sh` now loads the shared runtime env helper before
  invoking the existing periodic-once path
- focused runtime-local-ops tests now protect the bounded runtime hardening
  shape

## What did not change
This subtask did not change:
- scrape semantics
- batch semantics
- periodic semantics
- DB semantics
- queue semantics
- scheduler semantics
- Web semantics

This subtask also did not expand into:
- observability platform work
- deployment-platform redesign
- worker / queue framework redesign
- broad container-topology redesign

## Validation summary
The following validation / review path was completed:

1. Copilot-side bounded implementation review
2. `./validate_helix.sh` passed on Copilot after focused runtime-local-ops tests
   were added
3. GitHub merge into `main` was completed
4. both child repositories were realigned to merged `main`
5. `./compare_helix.sh --all` passed after synchronization
6. post-merge `./validate_helix.sh` passed on both child repositories
7. `_runtime` sibling checkout pulled merged `main`
8. `_runtime` local env file was applied with explicit `WEB_PORT`,
   `LOCAL_UID`, and `LOCAL_GID`
9. `_runtime` helper-based recreate succeeded
10. `_runtime` container confirmed `uid=1001 gid=1001`
11. `_runtime` `./runtime/periodic_once.sh` succeeded after recreate
12. host cron log showed a new success block after the old failure history

## Direct runtime observation note
After adoption, the provisional runtime checkout was explicitly recreated with
local runtime env settings.

Confirmed practical shape:
- local runtime env file present with:
  - `WEB_BIND_HOST`
  - `WEB_PORT`
  - `LOCAL_UID`
  - `LOCAL_GID`
- `bash tools/runtime_up.sh` succeeded
- runtime container came up with matching host UID/GID
- `./runtime/periodic_once.sh` completed successfully
- `runtime/logs/host_cron.log` showed a fresh success block

Older traceback lines remained in the active host cron log as historical
content, but the latest run block confirmed successful current behavior.

## Repository outcome
- the sideflow result was adopted into child-repo `main`
- both `copilot/` and `cursor/` were realigned to the same merged `main`
- the `_runtime` sibling checkout also pulled merged `main`
- provisional runtime operation now has a bounded local-env / recreate /
  permission-hardening baseline

## Interpretation
Current provisional runtime baseline should now be read as including:

- local-only `.env.runtime.local` handling
- a tracked `.env.runtime.local.example`
- bounded helper-based runtime startup via `bash tools/runtime_up.sh`
- shared local env loading for `runtime/periodic_once.sh`
- bounded protection against:
  - stale runtime container code
  - port clash confusion
  - LOCAL_UID / LOCAL_GID mismatch
  - common runtime permission mismatch

This remains bounded runtime / ops hardening.
It does not change the product’s scrape or archive semantics.

## Meta note
This log is AI-readable review memory.
It is not authoritative current state by itself.

Authoritative context should still be restored from:
- `AI_CONTEXT.md`
- `PROJECT_STATE.md`
- `WORKSPACE.md`
- `project_snapshot.txt`

