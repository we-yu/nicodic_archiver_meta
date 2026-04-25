# SUBTASK008 Runtime ID Record Cleanup Log

## Task
SUBTASK008

Clean historical runtime ID-style records after SUBTASK007.

## Purpose
Remove historical runtime records created from Nicopedia `/id/<number>`
targets that produced zero saved responses, then reset the delete-request
feeder cursor so future feeder runs can rescan through the corrected
SUBTASK007 registration boundary.

## Positioning
This was a maintenance-only SubTask.

It did not change product code.
It did not change schema.
It did not redesign scraping, storage, Web behavior, or feeder logic.

## Runtime prerequisites
Before cleanup:
- SUBTASK007 was reflected to runtime.
- SUBTASK009 was reflected to runtime.
- Runtime container was recreated successfully.
- Runtime scrape delay returned `5.0`.
- `/id/5364158` resolved to the effective `/a/おそ松さん` URL.
- No periodic shot lock was active.

## Safety steps
Before cleanup:
- Runtime SQLite DB was backed up.
- Delete-request feeder state was backed up.
- Queue table was checked for ID-style requests.

The feeder state before reset was:

- `data/delete_request_feeder_state.json`
- `last_processed_res_no = 134305`

The queue check showed:

- `queue_id_count = 0`

## Chosen maintenance approach
Historical `article_type='id'` records were removed rather than migrated.

Rows were deleted from:
- `responses`
- `articles`
- `target`

The delete-request feeder cursor was reset to:

- `last_processed_res_no = 0`

## Before cleanup
Before cleanup:
- `articles_by_type`: `a=77`, `id=12168`
- `responses_by_type`: `a=1214184`
- `target_by_type`: `a=82`, `id=12170`
- `id` response rows: `0`
- all `id` article rows were zero-response rows

## After cleanup
After cleanup:
- `articles_by_type`: `a=77`
- `responses_by_type`: `a=1214184`
- `target_by_type`: `a=82`
- remaining `id` rows:
  - `articles=0`
  - `responses=0`
  - `target=0`
- delete-request feeder cursor was `0`
- runtime Web surface still returned HTML

## Post-cleanup runtime observation
A scheduled cron shot started at `2026-04-25 20:05:02 UTC` after cleanup.

During that shot:
- target records increased as `/a` targets
- `remaining_id` stayed at zero
- no immediate ID target re-growth was observed

This indicates that delete-request feeder re-scan was entering the corrected
SUBTASK007 URL normalization boundary.

## Why not migrate ID rows to A rows
A precise migration would require resolving each ID row, updating identities,
and preserving cross-table consistency.

Because the ID-style rows contained no saved responses and were created by
best-effort delete-request feeder intake, simple removal was safer and easier
to verify than a broad migration script.

## Runtime build note
During runtime reflection, Docker build initially failed because local runtime
state was included in the Docker build context.

A local runtime `.dockerignore` was added to exclude:
- `runtime/data/**`
- `runtime/logs/**`
- `runtime/targets/**`

This reduced the build context and allowed runtime reflection to complete.

A future small codebase task should add the same Docker build-context exclusion
to the mainline repository to prevent recurrence in fresh runtime checkouts.

## Validation
Validation consisted of:
- before / after counts by `article_type`
- confirming ID rows were removed from target and archive tables
- confirming A rows remained
- confirming queue had no ID requests
- confirming feeder cursor reset to 0
- confirming runtime Web surface remained reachable
- confirming post-cleanup cron intake added `/a` targets without adding `id`
  targets

## Interpretation
Historical runtime ID-style data is treated as discarded bad intake artifacts.

Future ID-style URL intake should enter through the SUBTASK007 normalization
path and be persisted as effective `/a/<title>` targets when resolvable.

## Non-goals
This SubTask did not:
- add product code
- add migration tooling
- add schema fields
- migrate ID records into A records
- alter scrape logic
- alter feeder logic
- alter Web behavior



