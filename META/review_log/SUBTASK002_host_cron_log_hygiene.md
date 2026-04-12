# SUBTASK002 Host Cron Log Hygiene

## Task
SUBTASK002

Add bounded host-side cron log hygiene for the provisional personal-use runtime.

## Positioning
This is a bounded subtask on top of the adopted runtime / operations baseline.

It is not a new product-semantics task family expansion.
It is a runtime / operations readability and log-hygiene improvement.

## Background
Before this subtask, runtime-side periodic execution was practical, but
host-facing cron/run visibility was still too thin for comfortable
single-operator use.

Observed needs were:

- prevent `host_cron.log` from growing forever
- make one host-side periodic run readable at a glance
- keep old host cron logs in a bounded retained form
- avoid widening into a logging platform or scheduler redesign

## What changed
Changed files in the adopted product result:
- `host_cron.py`
- `main.py`
- `orchestrator.py`
- `runtime/periodic_once.sh`
- `storage.py`
- `docs/PERSONAL_RUNTIME.md`
- `tests/test_host_cron.py`
- `tests/test_main.py`

Added / changed behavior:
- bounded structured host cron logging now exists at:
  - `runtime/logs/host_cron.log`
- daily rollover now exists on next run start:
  - `host_cron.YYYYMMDD.log`
- older daily host cron logs can now be compacted into:
  - `host_cron.YYYYMMDD-YYYYMMDD.tar.gz`
- host cron output now has bounded run-block formatting with:
  - `[RUN] START`
  - `[RUN] END`
  - `[SUMMARY]`
- periodic-one-shot runtime flow can now write through the host-cron-readable
  formatting path
- a small host-cron-specific helper/reporting seam now exists in:
  - `host_cron.py`

## What did not change
The subtask remained bounded and did not expand into:
- batch semantics redesign
- `batch_*.log` redesign
- telemetry / CSV redesign
- DB schema redesign
- queue / scheduler redesign
- Web semantics redesign
- observability / dashboard platform work
- destructive maintenance tooling

## Validation summary
The following bounded validation was completed:

1. focused tests passed for:
   - `tests/test_host_cron.py`
   - `tests/test_main.py`
2. runtime one-shot execution produced structured `host_cron.log`
3. `rotate_active_log(...)` was directly observed to:
   - move prior-day active log into `host_cron.YYYYMMDD.log`
   - reopen a fresh active log
4. `compress_weekly_archives(...)` was directly observed to:
   - create weekly `tar.gz` compaction
   - keep newer daily logs uncompressed
5. full repo validation later passed on converged `main`

## Repository outcome
- the sideflow result was adopted into child-repo `main`
- both `copilot/` and `cursor/` were realigned to the same merged `main`
- convergence and validation were confirmed after synchronization

## Interpretation
Current runtime / operations baseline should now be read as including:

- bounded host cron log hygiene
- structured host-side run logging
- daily rollover
- bounded weekly compaction

Important boundary:
- `host_cron.log` is a host/runtime operations log
- `batch_*.log` remains the product-side batch run log baseline

This subtask does not redefine batch logging.
It adds bounded host-side cron/run readability only.

## Meta note
This log is AI-readable review memory.
It is not authoritative current state by itself.

Authoritative context should still be restored from:
- `AI_CONTEXT.md`
- `PROJECT_STATE.md`
- `WORKSPACE.md`
- `project_snapshot.txt`

