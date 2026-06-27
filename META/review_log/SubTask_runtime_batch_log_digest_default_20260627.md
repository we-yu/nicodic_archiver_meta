# SubTask: runtime batch log digest default

Date: 2026-06-27 UTC

## Summary

Adopted product commit `5039445` / PR #86:

`SubTask: make batch logs digest-first by default`

This task changes batch run logs so they are digest-first by default. The large per-target `[PROGRESS = i/n]` blocks are now suppressed unless explicitly enabled with `BATCH_LOG_VERBOSE=1`.

## Adopted behavior

- Batch logs keep `BATCH_RUN_START`.
- Batch logs keep `DELETE_REQUEST_FEED`.
- Batch logs keep `BATCH_RUN_END`.
- Batch logs keep `BATCH_DIGEST`.
- Batch logs keep `BATCH_DIGEST_ITEMS`.
- Default batch logs omit per-target `[PROGRESS = i/n]` blocks.
- `BATCH_LOG_VERBOSE=1` restores legacy per-target progress blocks for temporary debugging.
- `BATCH_DIGEST` counters now use compact keys:
  - `H`
  - `OK0`
  - `W`
  - `F`
  - `S`
  - `NEW`
  - `UOBS`
- `host_cron` `[RUN DIGEST]` now includes compact operational metadata:
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
  - `R` when totals are available

## Non-goals

- No change to host_cron OK0 per-target behavior.
- No heartbeat behavior change.
- No batch log retention or archive helper.
- No host_cron rotation change.
- No runtime DB change.
- No scraping semantic change.
- No runtime data cleanup.

## Validation

Before adoption:

- `compare_helix.sh --all`: PASS
- `validate_helix.sh`: PASS
- copilot: 514 passed
- cursor: 514 passed

After adoption:

- copilot and cursor were fast-forwarded to product main.
- runtime checkout was reflected to `5039445`.
- runtime container was rebuilt and restarted.
- post-reflection runtime status showed:
  - `periodic_lock_exists=no`
  - `soft_stop_exists=no`
  - `scrape_like_processes=none`
  - `container_scrape_like_processes=none`

## Runtime notes

`tools/verify.sh` failed on the host with `python: command not found`. This was not treated as a product failure because the repo-local validations already passed inside the expected validation path. A future helper cleanup may switch that host script to `python3` or container-oriented execution if desired.

The most recent existing batch log inspected after reflection was generated before the runtime reflection and still uses the old long `BATCH_DIGEST` keys. That is expected. The new digest-first behavior should appear from the next runtime batch/periodic run.

## Follow-up candidates

1. `SubTask-runtime-host-cron-ok0-heartbeat`
   - Fold host_cron `[STEP OK0 🟢]` per-target lines into heartbeat or aggregate summaries.

2. `SubTask-runtime-batch-runs-retention`
   - Archive old `runtime/logs/batch_runs/batch_*.log` files by mtime after log emission has been slimmed.

3. Optional: `SubTask-runtime-batch-digest-one-line`
   - Consider adding a one-line batch digest summary if `grep BATCH_DIGEST batch_*.log` should behave more like `grep RUN DIGEST host_cron*.log`.

4. Separate human-confirmed cleanup:
   - old DB gzip / pre-migration DB snapshots / task seed files under `runtime/data`.
