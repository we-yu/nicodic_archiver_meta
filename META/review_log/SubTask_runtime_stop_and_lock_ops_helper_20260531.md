# SubTask: runtime stop and lock ops helper

## Summary

SubTask-runtime-stop-and-lock-ops-helper was completed and adopted into product
main.

The task improved runtime operational safety around soft termination and
periodic lock / process checks.

## Adopted product change

Merged product main includes:

- `SubTask: add runtime stop and lock ops helper (#76)`

Commit observed after merge:

- `36f9191`

## Purpose

The task addressed two practical runtime operation issues:

1. `runtime/control/stop_after_current` was easy to forget after use.
2. Periodic lock, soft-stop, and scrape-like process checks required long
   manual one-liners.

## Soft terminate behavior

The existing safe article-boundary stop behavior was preserved.

Additional countdown behavior was added:

- missing stop file means no soft terminate
- empty stop file means one soft stop, then remove the file
- malformed content means one soft stop, then remove the file
- `0` or `1` means one soft stop, then remove the file
- `N >= 2` means one soft stop, then rewrite the file as `N - 1`
- large values are clamped to `255`

This prevents a forgotten stop file from causing repeated unintended
soft-terminate behavior.

## Runtime helper

A bounded runtime helper was added:

- `tools/runtime_periodic_ops.sh`

Supported subcommands include:

- `status`
- `stop-once`
- `stop-count N`
- `show-stop`
- `clear-stop`
- `clear-lock`

The helper is intended for operator support only.

It does not change scrape, DB, cron, Docker, target-order, or lock acquisition
semantics.

## Files changed

Product files changed by the adopted task:

- `main.py`
- `tests/test_main.py`
- `tests/test_runtime_local_ops.py`
- `docs/PERSONAL_RUNTIME.md`
- `tools/runtime_periodic_ops.sh`
- `SubTask-runtime-stop-and-lock-ops-helper_report.txt`

## Validation

After GitHub merge:

- Copilot main was fast-forwarded to product main.
- Cursor main was fast-forwarded to product main.
- `./validate_helix.sh` passed for both child repositories.
- Final observed validation:
  - Copilot: 456 tests passed
  - Cursor: 456 tests passed

## Runtime reflection

Runtime reflection was deferred until the active soft-terminated run completed.

After the run ended safely, runtime checkout can be fast-forwarded to product
main and recreated with `tools/runtime_up.sh`.

## Copilot autonomy pilot note

This task was also used as a pilot for more autonomous Copilot execution.

Copilot successfully performed:

- task branch creation
- implementation
- report generation
- commit
- push

Observed caveats:

- Copilot created a temporary `.vscode/settings.json` auto-approval file.
- That file was removed before adoption.
- Future autonomous prompts should explicitly forbid leaving `.vscode/`
  workspace settings behind.
- Future prompts should also state that runtime-like Python validation should
  prefer the intended container/runtime environment when available.

## Non-goals preserved

The task did not introduce:

- cron changes
- Docker topology changes
- runtime DB changes
- live scraping changes
- target-order changes
- lock acquisition redesign
- automatic process killing
- scheduler redesign

