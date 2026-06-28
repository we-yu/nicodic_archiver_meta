# SubTask: runtime batch_runs retention

Date: 2026-06-28 UTC

## Summary

Adopted product commit `20659af`:

`SubTask: archive old batch run logs weekly`

This task extends the existing host_cron log hygiene model to
`runtime/logs/batch_runs/batch_*.log`.

## Adopted behavior

- Recent batch run logs remain plain for readability.
- Older `batch_*.log` files are selected by file mtime.
- Older batch logs are grouped by calendar week.
- Archives are written as:
  - `runtime/logs/batch_runs/batch_runs.YYYYMMDD-YYYYMMDD.tar.gz`
- Original `.log` files are removed only after successful archive creation.
- Compressed archives are kept indefinitely for now.
- Existing host_cron daily/weekly rotation behavior remains unchanged.

## Digest explanation logs

The runtime log hygiene pass now also maintains grep-friendly explanation files:

- `runtime/logs/README.log`
- `runtime/logs/batch_runs/README.log`

These contain `DIGEST EXP` lines explaining compact digest keys such as:

- `B`
- `dur`
- `end`
- `H`
- `OK0`
- `W`
- `F`
- `S`
- `NEW`
- `UOBS`
- `P`
- `T`
- `R`

This keeps future commands such as `grep DIGEST *.log` self-explanatory.

## Validation

Before adoption:

- `compare_helix.sh --all`: PASS
- `validate_helix.sh`: PASS
- copilot: 526 passed
- cursor: 526 passed

Runtime reflection:

- active periodic run was stopped with the existing soft-stop helper
- no periodic lock remained before reflection
- no scrape-like process remained before reflection
- runtime checkout was fast-forwarded to `20659af`
- runtime container was rebuilt/recreated through the standard reflection flow

Runtime observation:

- `README.log` explanation files were confirmed after the runtime log hygiene pass
- `grep DIGEST *.log` now surfaces `DIGEST EXP` explanation lines
- batch run archive behavior is covered by tests and will archive eligible files once their mtime is outside the 14-day plain retention window
- runtime DB and runtime/data were not changed

## Non-goals

- No scrape behavior change.
- No batch log emission behavior change.
- No host_cron policy change.
- No cron wiring change.
- No Docker config change.
- No runtime DB or runtime/data cleanup.
- No archive expiry/deletion policy.

## Follow-up candidates

1. Archive-expiry policy for old `.tar.gz` files if compressed archives eventually grow too large.
2. Zero-page unknown success classification:
   - `stored_new=0 saved_after=unknown observed_after=unknown pages_ok=0 reason=ok`
3. Optional factoring of shared weekly archive helpers if log hygiene grows further.
