# SUBTASK009 Runtime Scrape Delay Config Adoption Log

## Task
SUBTASK009

Externalize runtime BBS page scrape delay.

## Purpose
Make the delay between paginated BBS page fetches configurable without editing
application code.

This was introduced because early runtime collection can involve long-running
shots and many BBS page requests. A safer default pacing value helps reduce
load and makes runtime operation easier to adjust.

## Decision
Adopted: Copilot-only implementation

Cursor was not used for this SubTask.

## Final adopted shape
Production changes were limited to:
- `orchestrator.py`
- `.env.runtime.local.example`
- `docs/PERSONAL_RUNTIME.md`

Focused tests were updated in:
- `tests/test_orchestrator.py`

## What changed
A new runtime setting was added:

- `SCRAPE_PAGE_DELAY_SECONDS`

`orchestrator.get_scrape_delay_seconds()` reads this value from the process
environment.

Default behavior:
- unset value falls back to `5.0`

Valid behavior:
- decimal values such as `2.5` are accepted

Invalid behavior:
- empty values
- non-numeric values
- negative values
- NaN
- positive infinity
- negative infinity

all fall back to `5.0`.

`collect_all_responses()` now uses this configured delay between BBS page
fetches.

## What stayed unchanged
This SubTask did not change:
- target registration
- SUBTASK007 ID URL normalization
- delete-request feeder behavior
- DB schema
- Web behavior
- saved download behavior
- registered article list behavior
- cron schedule
- server timezone
- scrape target selection
- response parsing

## Practical validation
Validation passed.

Container smoke checks confirmed:
- unset value returns `5.0`
- `SCRAPE_PAGE_DELAY_SECONDS=2.5` returns `2.5`
- invalid value falls back to `5.0`

## Runtime note
`.env.runtime.local` is local-only runtime configuration.

Changing it may require runtime container recreation before the new value is
visible inside the running runtime container.

## Non-goals
This SubTask did not:
- clean existing ID records
- reset delete-request feeder state
- change cron
- change server timezone
- add HTTP timeout configuration
- add response cap configuration
- add log retention configuration
- introduce TOML/YAML/JSON config files


