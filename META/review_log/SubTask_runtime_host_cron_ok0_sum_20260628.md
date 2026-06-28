# SubTask: runtime host_cron OK0 summary

Date: 2026-06-28 UTC

## Summary

Adopted product commit `2ca9f8c`:

`SubTask: summarize host cron OK0 lines`

This task changes host_cron clean OK0 logging from per-target lines to bounded aggregate `[OK0 SUM 🟢]` lines by default.

## Adopted behavior

- Clean host_cron OK0 targets are summarized by default as:
  - `[OK0 SUM 🟢]`
- Per-target clean OK0 lines are suppressed by default:
  - `[STEP OK0 🟢]`
- Legacy per-target OK0 output remains available with:
  - `HOST_CRON_OK0_MODE=line`
- Invalid, empty, or unset `HOST_CRON_OK0_MODE` falls back to:
  - `sum`
- `HOST_CRON_OK0_SUM_EVERY` controls count-based summary flushing.
- Default/fallback summary interval:
  - `250`
- Pending OK0 summaries flush:
  - when the count threshold is reached
  - before non-OK detail output
  - before run end / run digest

## Runtime-observed log shape

Observed host_cron examples after runtime reflection:

- `[OK0 SUM 🟢] steps=2997-3027/12241 cnt=31 total_ok0=3000 last_id=4203815 elapsed=3586s last_page=121`
- `[OK0 SUM 🟢] steps=3029-3154/12241 cnt=126 total_ok0=3126 last_id=5054725 elapsed=3714s last_page=121`

The `cnt` value may be below `HOST_CRON_OK0_SUM_EVERY` when pending OK0 entries are flushed before HIT/WARN/FAIL detail. This is intentional because it preserves chronological context around actionable events.

## Preserved behavior

- HIT detail remains individually logged.
- WARN detail remains individually logged.
- FAIL detail remains individually logged.
- RUN DIGEST counts remain available.
- Batch log behavior was not changed by this task.
- Scrape semantics were not changed.
- Runtime DB was not changed.
- Host cron rotation/retention was not changed.

## Validation

Before adoption:

- `compare_helix.sh --all`: PASS
- `validate_helix.sh`: PASS
- copilot: 519 passed
- cursor: 519 passed

Runtime reflection:

- active periodic run was stopped with the existing soft-stop helper
- no periodic lock remained before reflection
- no scrape-like process remained before reflection
- runtime checkout was fast-forwarded to `2ca9f8c`
- runtime container was rebuilt/recreated through the standard reflection flow

Runtime observation:

- host_cron.log emitted `[OK0 SUM 🟢]` lines
- HIT/FAIL detail remained visible around actionable targets
- new batch logs generated after the previous digest-first task were much smaller than historical verbose batch logs

## Notes

This task completes the second stage of the runtime log slimming sequence:

1. batch logs digest-first by default
2. host_cron clean OK0 summarized by default
3. remaining old log volume can now be handled by retention/archive policy

## Follow-up candidates

1. `SubTask-runtime-batch-runs-retention`
   - Add bounded manual retention/archive helper for old `runtime/logs/batch_runs/batch_*.log` files.

2. `SubTask-runtime-zero-page-unknown-success-classification`
   - Clarify `stored_new=0 saved_after=unknown observed_after=unknown pages_ok=0 reason=ok` outcomes.

3. Optional:
   - Add time-based OK0 summary flushing if future long runs show sparse target completion with too little liveness output.
