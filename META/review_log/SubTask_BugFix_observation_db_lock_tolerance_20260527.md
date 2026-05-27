# SubTask-BugFix: observation DB lock tolerance

## Summary

SubTask-BugFix-observation-db-lock-tolerance was completed and adopted into
product main.

The task corrected a runtime failure mode where append-only scrape-run
observation telemetry could raise:

- `sqlite3.OperationalError: database is locked`

and abort an otherwise successful periodic / batch run.

## Task type

- Copilot-only bounded product BugFix SubTask
- Not a DHM MainTask
- Not a root/meta task

## Background

Runtime periodic-once encountered a DB lock failure at the scrape-run
observation telemetry boundary:

- `main.py` `_record_scrape_run_observation(...)`
- `storage.py` `append_scrape_run_observation(...)`
- failure at `conn.commit()`

The failure was in auxiliary run observation / telemetry persistence, not in
archive-critical response storage.

## Adopted behavior

- Archive-critical persistence remains fatal.
- Target registry writes remain fatal.
- Scrape-run observation telemetry lock / busy failures are bounded and
  non-fatal.
- Lock-style observation failures are surfaced as warnings rather than silently
  swallowed.
- Non-lock observation `sqlite3.OperationalError` cases remain fatal when they
  are not part of the bounded lock / busy tolerance.

## Safety boundary

The task intentionally did not change:

- response archive save semantics
- target registry write semantics
- scrape collection semantics
- SQLite schema
- cron configuration
- Docker configuration
- runtime DB contents

## Validation

The adopted product state was merged into product main as:

- `SubTask-BugFix: tolerate observation DB locks (#74)`

After adoption, both child product repos were synced to main.

Observed validation after synchronization:

- `./compare_helix.sh` confirmed child repo convergence.
- `./validate_helix.sh` passed.
- Copilot validation passed.
- Cursor validation passed.

## Runtime interpretation

This task addressed the specific failure mode where telemetry-only observation
append locks could turn into whole-run failures.

It did not by itself change periodic console visibility or runtime wrapper
operator guidance. That was handled later by:

- `SubTask-Improve-periodic-once-host-cron-log-guidance`

## Non-goals

This task did not introduce:

- broad SQLite access redesign
- WAL migration
- global busy-timeout redesign
- DB schema migration
- runtime DB repair
- cron restart
- Docker restart
- scrape behavior changes
- Delete Feeder behavior changes

