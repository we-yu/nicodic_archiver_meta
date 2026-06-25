# MainTask048: materialized article response summary

## Task

MainTask048-materialized-article-response-summary

## Decision

Adopted: Cursor

Non-adopted comparison:

- Copilot implementation was retained and pushed as comparison evidence.

Hybrid:

- Not selected.

## Purpose

Registered Articles was still too slow on the production-sized runtime DB.

The previous page-first query fix restored practical browser usability for
non-aggregate sorts, but aggregate sorts such as Saved Responses and Saved Max
Res No still depended on expensive response aggregation.

This task introduced a materialized saved-response summary table so Registered
Articles can read per-article saved response stats from derived summary rows.

## Adopted implementation

The adopted Cursor implementation added:

- `article_response_stats`
- saved response count summary
- saved max saved response number summary
- summary maintenance from `save_to_db`
- operator rebuild/backfill command

Operator command:

- `python main.py operator stats rebuild-response-summary --db PATH`
- `python main.py operator stats rebuild-response-summary --db PATH --apply`

## Schema

New table:

- `article_response_stats`

Primary key:

- `(article_id, article_type)`

Core fields:

- `article_id`
- `article_type`
- `saved_response_count`
- `saved_max_res_no`
- `stats_updated_at`

## Semantic decision

`Saved Responses` means the number of saved response rows.

`Saved Max Res No` means the raw maximum saved `res_no`.

For no saved rows, the adopted storage-level meaning keeps saved max as NULL.
Checked-zero display behavior remains a read/display policy.

True observed-board Max Res No remains deferred.

## Why Cursor was adopted

Cursor was adopted because it kept storage semantics closer to the actual saved
responses data:

- `saved_response_count = COUNT(saved response rows)`
- `saved_max_res_no = MAX(saved res_no)`
- no saved rows means NULL at storage level
- checked-zero display policy remains outside the stored summary

This is a cleaner basis for a later observed-board max implementation.

## Why Copilot was not adopted

Copilot was valid and passed validation.

It was not adopted because its storage-level zero-response behavior used a
0/0-style summary, which blends saved-row summary semantics with display policy.

## Why Hybrid was not selected

Hybrid was not selected because the key difference was semantic design rather
than a narrow isolated implementation detail. Mixing implementations would add
manual integration risk without a clear benefit.

## Validation

Before adoption:

- Cursor sample DB rebuild dry-run passed.
- Cursor sample DB rebuild apply passed.
- Sample DB rehearsal wrote summary rows and was then removed.
- No rehearsal DB was left behind.

After adoption:

- both child repos were synced to product main
- `compare_helix.sh --all` passed
- `validate_helix.sh` passed
- copilot: 484 tests passed
- cursor: 484 tests passed

## Runtime reflection

Runtime reflection was performed after confirming:

- no periodic lock
- no soft-stop file
- no scrape-like process

Runtime checkout was fast-forwarded to product main and runtime was recreated
with `tools/runtime_up.sh`.

## Runtime DB backfill

Runtime DB dry-run:

- computed articles: 12109
- existing summary rows: unknown
- written rows: 0

Runtime DB apply:

- computed articles: 12109
- existing summary rows: 0
- written rows: 12109

Post-apply counts:

- articles: 12235
- responses: 13131174
- article_response_stats: 12109
- nonzero summary rows: 12109
- zero summary rows: 0

No full runtime DB backup was created for this task. This was intentional
because the operation writes a derived/rebuildable summary table and does not
rewrite the archive-critical `articles` or `responses` rows.

No temporary rehearsal DB or backup DB remained after the work.

## Runtime Web result

Browser verification succeeded:

- Registered Articles default view rendered.
- Saved Max Res No descending sort rendered.
- Summary-backed values appeared in the table.

Observed performance:

- local curl with a 30 second timeout still timed out
- browser rendering was roughly 20 to 30 seconds by human observation
- this is acceptable for a personal convenience tool but not a final
  performance endpoint

## Known limitations

- Registered Articles is still not lightweight.
- The summary table removes the most obvious per-request response aggregation,
  but the runtime page still appears slow at current production DB scale.
- Further query-plan, index, or rendering investigation remains useful.
- True observed-board Max Res No is still not implemented.
- Summary drift diagnostics are not implemented.

## Follow-up candidates

Recommended follow-up:

- inspect Registered Articles query plan after summary adoption
- add missing indexes if query plan indicates avoidable scans
- add operator summary drift diagnostics
- later implement true observed-board Max Res No persistence
