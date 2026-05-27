# Runtime periodic recovery note

## Summary

Runtime periodic operation was recovered after investigation of a
`sqlite3.OperationalError: database is locked` incident and subsequent
periodic-once confusion.

This is an operational review note, not a product implementation task.

## Incident summary

A runtime periodic-once run previously failed at the scrape-run observation
telemetry append boundary with:

- `sqlite3.OperationalError: database is locked`

After that failure, runtime operation appeared stalled or stuck around the
periodic-once startup messages.

Investigation separated three issues:

1. telemetry-only DB lock failure
2. stale periodic_once lock / skipped re-entry
3. terminal quietness while detailed progress was actually written to
   `host_cron.log`

## Corrective product tasks

Two small product fixes were completed and adopted before final recovery:

- `SubTask-BugFix-observation-db-lock-tolerance`
- `SubTask-Improve-periodic-once-host-cron-log-guidance`

## Runtime state checks

Before restoring scheduled operation, the operator confirmed:

- no `runtime/logs/periodic_once.lock`
- no scrape-like process
- runtime checkout clean on main
- `tools/runtime_up.sh` completed successfully
- a short periodic-once smoke run completed normally
- `host_cron.log` showed normal progress and run completion

## Crontab restoration

The three target-order cron patterns were restored:

- daily default run
- daily reverse run
- frequent random_rotation runs

Restored schedule shape:

- `00:05` default
- `03:05` reverse
- `06:05,09:05,12:05,15:05,18:05,21:05` random_rotation

Each uses:

- `ONESHOT_LIMIT_DURATION_SECONDS=8500`
- `./runtime/periodic_once.sh`
- append output to `runtime/logs/host_cron.log`

## Manual reverse run

After cron restoration, a manual background reverse periodic-one-shot was
started with:

- `ONESHOT_LIMIT_DURATION_SECONDS=8500`
- `TARGET_ORDER_MODE=reverse`

Observed `host_cron.log` behavior showed:

- `[RUN START]`
- `[FEEDER SUMMARY]`
- `[TARGET ORDER] mode=reverse`
- `[SCRAPE START]`
- normal `[STEP START]` / `[STEP END OK]` progress
- occasional platform-side HTTP 500 cases treated as WARN / FAIL / partial
  outcomes while the run continued

The reverse run appeared to process newly registered / recent targets as
intended.

## Interpretation

Runtime operation should currently be treated as active and recovering normally.

The original `database is locked` failure was addressed at the telemetry
tolerance boundary.

The later "stalled" perception was primarily a host-log visibility issue:
normal progress is written to `host_cron.log`, not continuously to the wrapper
terminal.

## Deferred action

The sibling runtime checkout should not be reflected while an active periodic
run is in progress.

The host-log guidance change can be reflected later at a safe maintenance
point because it is terminal guidance only and does not affect scrape behavior.

