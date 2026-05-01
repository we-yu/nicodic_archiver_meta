# TASK042 Review Log: Restore numeric article_id storage identity

Copilot: GPT 5.4
Cursor: GPT 5.2

## Result

Adopted implementation: Cursor.

Copilot was reviewed as a comparison implementation, but was not adopted.

## Why Cursor was adopted

Cursor kept the TASK042 boundary cleaner.

It restored the intended saved archive identity model:

- `article_id` stores the numeric NicoNicoPedia article ID as digits-only text.
- `article_type` remains `a` for normal canonical article saves.
- `canonical_url` remains the canonical `/a/<slug>` URL.
- BBS fetching continues to use the canonical `/a/<slug>` URL.

Cursor also preserved legacy read compatibility correctly.

Existing runtime DB rows may still contain URL-encoded slug values in
`article_id`. New saves now reject those values at the save boundary, so
legacy rows in tests must be seeded directly through SQL instead of through
`save_to_db()`. Cursor handled this in `tests/test_archive_read.py`.

## Copilot comparison notes

Copilot had a broadly similar design direction:

- separated numeric article ID from canonical URL
- added save-boundary validation
- preserved canonical `/a/<slug>` URL for BBS flow

However, Copilot did not update archive-read legacy slug-row fixtures to avoid
`save_to_db()`. As a result, validation failed because the new save-boundary
validation correctly rejects slug article IDs for `article_type='a'`.

This was treated as useful comparison evidence, not as the primary adoption
criterion by itself.

## Implemented scope

TASK042 changed product code for new save behavior only.

Implemented:

- numeric article ID extraction from article metadata
- refusal to silently fall back to `/a/<slug>` as saved `article_id`
- explicit save-boundary validation for `article_type='a'`
- preservation of canonical `/a/<slug>` URL for display and BBS fetching
- focused tests for numeric ID persistence and legacy slug-row read behavior

## What did not change

TASK042 did not:

- repair existing runtime DB rows
- add an apply migration
- modify runtime DB
- modify cron
- modify scheduler
- modify nginx
- modify delete feeder
- redesign Web UI
- reintroduce normal `article_type='id'` saved rows

## Validation summary

Cursor validation passed after adoption review.

Observed result:

- Cursor: PASS
- Copilot: FAIL as non-adopted comparison evidence
- After adopting Cursor and realigning both child repos to main, both child
  repositories should pass validation.

## Runtime deployment note

Do not reflect TASK042 into the runtime checkout while the current long shot is
running.

Runtime deployment should wait for a safe maintenance point, or for a later
soft-terminate mechanism.

## Follow-up

A later maintenance task should handle existing slug-identity rows in runtime
DB.

Recommended follow-up:

- TASK043 or equivalent:
  - detect existing `article_type='a'` rows where `article_id` is a URL-encoded
    slug
  - map them to numeric NicoNicoPedia IDs
  - preserve all responses
  - avoid duplicate `res_no` insertion
  - require explicit DB path
  - default to dry-run
  - test on copy DB before runtime apply

