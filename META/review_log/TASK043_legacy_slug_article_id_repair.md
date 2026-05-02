# TASK043 Review Log: Legacy slug article_id repair tooling

## Result

Adopted implementation: Cursor.

Copilot was reviewed as a comparison implementation, but was not adopted.

## Why Cursor was adopted

Cursor implemented a standalone maintenance tool for repairing legacy
`article_type='a'` rows whose `article_id` is a URL-encoded `/a/<title>` slug.

The adopted implementation keeps the repair outside normal scrape/runtime flow.

It provides:

- explicit DB path
- dry-run default
- explicit `--apply` for writes
- transaction-backed apply behavior
- optional `--allow-network` metadata resolution
- bounded staged validation through `--limit`
- compact operational output through `--summary-only`

## Identity model preserved

The repair target is:

- `article_id`: numeric NicoNicoPedia article ID as digits-only text
- `article_type`: `a`
- `canonical_url`: canonical `/a/<slug>` URL

The implementation does not create normal `article_type='id'` rows.

The implementation does not rewrite canonical URLs into `/a/<numeric>`.

## Copy DB validation

Runtime DB was not modified.

A runtime DB copy was created with the SQLite backup API and passed
`PRAGMA integrity_check`.

A `--limit 10` copy DB apply succeeded.

A `--limit 100` copy DB apply succeeded.

Observed `--limit 100` result:

- Processed groups: 100
- Resolved groups: 100
- Applied groups: 100
- Response totals: inserted=586157 duplicate=0 missing_after=0
- total responses before: 3809134
- total responses after: 3809134
- articles_id_type_after: 0
- responses_id_type_after: 0
- target_id_type_after: 0
- repaired_numeric_rows_found: 100
- changed_canonical_url_count: 0

Target behavior also matched the intended safe-normalization model:

- active slug targets decreased by 100
- inactive slug targets increased by 100
- active numeric targets increased by 100

## Copilot comparison notes

Copilot implemented a broadly similar repair concept, but Cursor was stronger
for staged operational safety and validation readiness.

Cursor added `--limit` and `--summary-only`, which are important because the
runtime copy contained more than 1000 legacy groups and millions of legacy
responses.

## Runtime note

The runtime environment is still running a long shot.

TASK043 does not apply changes to the runtime DB.

Runtime apply is deferred until a safe maintenance point, preferably after a
soft-terminate mechanism or after the current long shot is safely stopped.

## Follow-up

Recommended follow-up:

- SubTask-soft-terminate-periodic-shot
- staged runtime DB apply plan for TASK043 tool after runtime is stopped
- optional broader full-copy dry-run / apply rehearsal before runtime apply

