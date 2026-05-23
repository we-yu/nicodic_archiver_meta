# MainTask: target order modes

## Summary

MainTask-target-order-modes was completed.

The task introduced a bounded target-ordering boundary for batch and periodic
scraping so runtime runs no longer have to always traverse active targets from
the beginning of the registered target list.

## Adopted implementation

The Copilot implementation was adopted.

Reason:

- It provides a dedicated target_ordering.py boundary.
- It supports default, reverse, and random_rotation modes.
- It supports TARGET_ORDER_START_ARTICLE_ID as a focused verification override.
- It adds CLI options for batch, periodic-once, and periodic.
- It preserves env-based runtime defaults.
- It preserves default traversal compatibility.
- It uses stored numeric article_id values for start override, so numeric
  article_id matching still works for canonical /a/<encoded title> URLs.
- It emits compact [TARGET ORDER] logging suitable for host cron / batch logs.
- It updates runtime env examples and PERSONAL_RUNTIME documentation.

## Implemented modes

- default:
  - preserves current loaded target order
- reverse:
  - reverses the loaded active target list
  - useful for reaching recently registered / Delete Feeder appended targets
    sooner
- random_rotation:
  - selects one start index at run start
  - rotates the loaded target list once
  - does not shuffle per target
  - does not duplicate targets within one run
- start article override:
  - TARGET_ORDER_START_ARTICLE_ID or --target-order-start-article-id rotates
    the list so the matching stored article_id is first
  - invalid or not-found override falls back to default order

## Configuration

Environment variables:

- TARGET_ORDER_MODE
- TARGET_ORDER_START_ARTICLE_ID

CLI options:

- --target-order-mode
- --target-order-start-article-id

Precedence:

1. CLI option values
2. environment values
3. default behavior

## Logging

Each run emits one compact [TARGET ORDER] line near run start.

The line includes:

- requested mode
- mode source when available
- requested start article_id when available
- target count
- effective mode
- start index / start article_id when applicable
- fallback reason when applicable

## Validation

Before adoption:

- validate_helix.sh passed.
- Copilot branch: 437 tests passed.
- Cursor comparison branch: 429 tests passed.

After adoption:

- product main should be updated from the Copilot implementation.
- copilot and cursor child repos should be synced to main.
- compare_helix.sh --all should confirm convergence.
- validate_helix.sh should pass again.

## Runtime status

Runtime reflection should be recorded separately after reflect_runtime.sh is
run.

This task intentionally does not change crontab or runtime scheduling policy.

The expected future runtime-operation follow-up is to decide a schedule such
as:

- frequent random_rotation runs
- occasional reverse runs for newer / Delete Feeder appended targets
- optional explicit start-article verification runs

## Non-goals

This task intentionally did not introduce:

- cron changes
- Docker compose changes
- DB schema changes
- scrape semantics changes
- response storage changes
- Delete Feeder semantics changes
- persistent resume cursor
- per-target shuffle
- scrape_id / run mark
- target registration order changes in storage
