# SubTask-BugFix: registered list page-first query

## Task

SubTask-BugFix-registered-list-page-first-query

## Product commit

Adopted product main commit:

- `294fdfc SubTask-BugFix: speed up registered list page query (#81)`

## Purpose

Runtime `/registered` was too slow on the production-sized SQLite DB.

Before the fix:

- web root `/` responded
- saved article download worked
- `/registered` could return nginx 504 in browser
- local curl to `/registered` variants timed out after 30 seconds
- runtime DB had roughly:
  - 12k articles
  - 13M responses
  - 12k targets

The root cause was the Registered Articles query building a full saved-response
aggregate before pagination on every request.

## Adopted behavior

`query_registered_articles()` now uses a page-first query shape for
non-aggregate sorts:

- `created_at`
- `last_scraped_at`
- `title`
- `article_id`

For those sorts, the query:

1. resolves active registered targets and article metadata
2. applies search filter
3. counts matching targets without response stats
4. orders and pages target/article rows first
5. fetches saved response count and saved max res no only for page identities
6. assembles the same public result shape as before

Aggregate sorts remain correctness-first:

- `saved_response_count`
- `saved_max_res_no`

Those may still be slow until a future materialized summary is introduced.

## Validation

Post-merge validation completed:

- `compare_helix.sh --all`: PASS
- `validate_helix.sh`: PASS
- Copilot: 468 tests passed
- Cursor: 468 tests passed

## Runtime reflection

Runtime reflection completed after soft terminate succeeded.

Runtime reflected commit:

- `294fdfc SubTask-BugFix: speed up registered list page query (#81)`

Confirmed after reflection:

- runtime checkout updated
- runtime container recreated
- web root `/` returned HTTP 200
- text download succeeded
- `/registered` rendered in browser and displayed Registered Articles
- visible count: 12235
- visible range: 1-100

Known runtime limitation:

- local curl with `--max-time 30` still timed out during immediate post-reflection
  probes
- browser display remains noticeably slow
- this task restored visibility/usability but did not fully solve Registered
  Articles performance at production DB scale

## Boundaries preserved

The task did not introduce:

- timeout extension as the main solution
- nginx config changes
- schema migration
- response-table index addition
- stored summary table
- observed-board Max Res No implementation
- live scraping
- runtime DB modification
- cron change

## Why this fits future DB work

This was not a one-off local workaround.

It separated Registered Articles into two responsibilities:

- selecting the page of registered targets
- reading display statistics for that page

That boundary is compatible with future materialized summary work such as:

- saved response count
- saved max res no
- observed board max res no

## Follow-up

Future candidate tasks:

- materialize saved response count and saved max res no at write time
- add explicit observed board max res no persistence
- review indexes for target/articles joins
- continue Registered Articles latency reduction until local curl returns within
  practical timeout
