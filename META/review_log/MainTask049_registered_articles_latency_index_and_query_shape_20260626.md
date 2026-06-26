# MainTask049: registered articles latency index and query shape

## Task

MainTask049-registered-articles-latency-index-and-query-shape

## Decision

Adopted: Copilot

Non-adopted comparison:

- Cursor implementation was retained and pushed as comparison evidence.

Hybrid:

- Not selected.

## Purpose

After MainTask048, Registered Articles no longer aggregated the full
`responses` table for normal display or saved-response aggregate sorts, but the
runtime page was still slow.

Observed before MainTask049:

- browser render: roughly 20 to 30 seconds
- local curl with 30 second timeout: timed out
- saved max response sort also remained slow
- runtime DB had roughly:
  - articles: 12235
  - responses: 13131174
  - article_response_stats: 12109

A read-only EXPLAIN probe before this task showed:

- SCAN articles
- SCAN target

This indicated that the remaining bottleneck was not the 13M-row `responses`
table, but the Registered Articles target/article resolution query.

## Adopted implementation

The adopted Copilot implementation added small-table support indexes:

- `idx_articles_type_canonical_url_id`
  - on `articles(article_type, canonical_url, id)`
- `idx_target_active_created_at_id`
  - on `target(is_active, created_at, id)`

It also changed the Registered Articles query shape:

- replaced the correlated canonical URL fallback lookup with a
  `url_fallback_articles` CTE
- selected the deterministic earliest article row with `MIN(id)`
- joined the selected article row by id
- added a no-search total-count fast path:
  - `SELECT COUNT(*) FROM target WHERE is_active = 1`

## Why Copilot was adopted

Copilot was adopted because it directly addressed the suspected bottleneck:

- the unindexed canonical URL fallback path
- the per-target correlated article lookup
- duplicate expensive count work for the no-search common path

It also preserved the existing datetime sort semantics by leaving
`julianday(...)` ordering in place.

## Why Cursor was not adopted

Cursor passed validation and included useful tests.

It was not adopted because its main query change removed `julianday(...)` and
relied on text ordering for timestamps. That may be reasonable for production
UTC-like data, but it narrows the previously tested datetime behavior and was
not necessary to solve the main bottleneck.

## Why Hybrid was not selected

Hybrid was not selected because the adopted Copilot change was sufficient and
low-risk. Manually mixing Cursor tests into Copilot would add integration churn
without a clear need.

## Validation

Before adoption:

- Copilot validation passed
  - 486 tests passed
- Cursor validation passed
  - 492 tests passed

After GitHub merge and child repo synchronization:

- `compare_helix.sh --all` passed
- `validate_helix.sh` passed
- copilot: 486 tests passed
- cursor: 486 tests passed

## Runtime reflection

Runtime reflection was performed after confirming:

- no periodic lock
- no soft-stop file
- no scrape-like process

Runtime checkout was fast-forwarded to product main and runtime was recreated
with `tools/runtime_up.sh`.

Important runtime note:

- after `runtime_up.sh`, the new indexes were not present yet
- explicit `init_db('/app/data/nicodic.db')` was run through runtime execution
- after that, the indexes were created

This should be remembered for future schema/index additions: runtime recreate
does not necessarily imply existing-DB `init_db()` side effects have run.

## Runtime index verification

After explicit runtime `init_db`, a read-only EXPLAIN probe changed from full
scans to index usage:

- `SEARCH articles USING COVERING INDEX idx_articles_type_canonical_url_id`
- `SEARCH target USING INDEX idx_target_active_created_at_id`

## Runtime Web timing

After runtime reflection and index creation:

- `/registered?page=1&per_page=100`
  - http=200
  - time=0.106639 seconds
- `/registered?sort_by=saved_max_res_no&sort_order=desc&page=1&per_page=100`
  - http=200
  - time=0.094546 seconds
- `/registered?sort_by=saved_response_count&sort_order=desc&page=1&per_page=100`
  - http=200
  - time=0.072703 seconds

Browser verification also succeeded. The user reported that display and sorting
now feel effectively instant.

## Safety notes

No full runtime DB backup was created.

This was intentional because the adopted runtime change only added indexes on
small tables and did not rewrite archive-critical `articles` or `responses`
data.

No new index was added to the 13M-row `responses` table.

Runtime final status after verification:

- no periodic lock
- no soft-stop file
- no scrape-like process

## Known limitations

- Search-heavy paths may still need separate inspection later.
- True observed-board Max Res No is still not implemented.
- The current `Saved Max Res No` remains saved-response max semantics.
- Runtime schema/index additions may need explicit `init_db()` execution on
  existing DBs.

## Follow-up candidates

Recommended follow-up:

- implement true observed-board Max Res No semantics
- add an operator/runtime schema ensure command if schema/index changes continue
- optionally add Registered Articles EXPLAIN diagnostics
