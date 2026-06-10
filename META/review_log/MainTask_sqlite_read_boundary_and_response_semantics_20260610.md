# MainTask: sqlite read boundary and response semantics adoption

## Task

MainTask-sqlite-read-boundary-and-response-semantics

## Decision

Adopted: Cursor

Alternative reviewed:

- Copilot implementation retained as comparison evidence

Hybrid:

- Not selected

## Why Cursor was adopted

Cursor was adopted because it better matched the task purpose while passing
validation.

The task was not a general SQL refactor. The purpose was to clarify SQLite
read/write boundaries, reduce unnecessary schema-initializing reads, and make
the current Registered Articles response-count semantics less misleading.

Cursor provided the stronger fit because it:

- introduced a read-only SQLite helper for selected read paths
- reduced read paths that call schema-initializing `init_db(...)`
- applied a bounded SQLite busy timeout policy
- kept archive-critical write behavior strict
- preserved telemetry lock-tolerance behavior
- renamed current saved-row `MAX(res_no)` semantics to `Saved Max Res No`
- kept true observed-board Max Res No deferred
- avoided schema migration and index changes

## Why Copilot was not adopted

Copilot was valid and conservative.

It passed validation and implemented the core label/read-boundary change in a
smaller patch.

It was not adopted because Cursor addressed the SQLite boundary and lock-pressure
theme more completely, especially around connection policy and busy timeout
handling.

This was not a rejection for instability. It was a fit-to-task decision.

## Why Hybrid was not selected

Hybrid was not selected because there was no clear additional benefit after the
Cursor follow-up fix.

The earlier Cursor issues were localized and fixed. After validation passed,
manually mixing Copilot changes would have increased integration risk without a
clear design benefit.

## Adopted behavior

The adopted product result:

- adds a read-only SQLite connection helper
- routes selected read-like paths through that helper
- keeps write paths on `init_db(...)`
- keeps archive-critical writes fatal
- keeps observation/telemetry tolerance policy unchanged
- changes Registered Articles display wording from `Max Res No` to
  `Saved Max Res No`
- changes the current saved-row max key to `saved_max_res_no`
- defers true board-observed max response number persistence

## Deferred work

True user-facing `Max Res No` remains a future task.

The intended future meaning is:

- `Saved Responses`: how far the archive has actually saved responses
- `Max Res No`: the latest/final board response number observed when the article
  top or scrape path observed the board state

That future behavior requires an explicit persistence seam and likely schema
evolution. It was intentionally not forced into this task to avoid mixed
historical semantics.

## Validation

Post-adoption validation completed:

- `./compare_helix.sh --all`: PASS
- `./validate_helix.sh`: PASS
- Copilot: 464 tests passed
- Cursor: 464 tests passed

Both child repos converged on product main commit:

- `05777fa MainTask: clarify SQLite read boundaries (#80)`

## Runtime note

Runtime reflection is allowed after adoption because the change is bounded to
SQLite connection/read semantics and Registered Articles wording.

Before runtime reflection, confirm:

- no `periodic_once.lock`
- no `stop_after_current`
- no scrape-like process

After reflection, confirm Web root and Registered Articles still respond.
