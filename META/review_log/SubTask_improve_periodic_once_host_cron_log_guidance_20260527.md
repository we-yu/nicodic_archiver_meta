# SubTask: improve periodic-once host cron log guidance

## Summary

SubTask-Improve-periodic-once-host-cron-log-guidance was completed and adopted
into product main.

The task added small operator-facing guidance to the runtime periodic-once
wrapper so the command no longer appears stalled after the initial terminal
messages.

## Task type

- Copilot-only bounded product SubTask
- Not a DHM MainTask
- Not a root/meta task

## Background

Runtime investigation showed that `runtime/periodic_once.sh` prints the initial
terminal banner, then runs `python main.py periodic-once` through Docker
Compose.

When `HOST_CRON_LOG_PATH` is set, detailed periodic progress is intentionally
written through the host cron reporter into `host_cron.log`.

This means terminal output can become quiet while the run is actually
progressing normally.

## Root cause of operator confusion

The runtime was not necessarily stalled.

The wrapper did not explicitly hand off the operator from:

- terminal startup messages

to:

- `runtime/logs/host_cron.log` / the effective host cron log path

where `[RUN START]`, `[TARGET ORDER]`, `[SCRAPE START]`, `[STEP OK0]`,
`[STEP START]`, `[STEP END ...]`, and `[RUN END ...]` are emitted.

## Adopted behavior

`runtime/periodic_once.sh` now prints two guidance lines before Docker Compose
executes the periodic-once process:

- `[periodic-once] Progress is written to $HOST_CRON_LOG_PATH`
- `[periodic-once] Follow progress with: tail -f $HOST_CRON_LOG_PATH`

The path is printed from the effective wrapper variable rather than being
hard-coded.

## Files changed

- `runtime/periodic_once.sh`
- `tests/test_runtime_local_ops.py`
- `SubTask-Improve-periodic-once-host-cron-log-guidance_report.txt`

## Validation

The adopted product change was merged into product main as:

- `SubTask: improve periodic-once host log guidance (#75)`

After merge:

- `copilot/` was fast-forwarded to product main.
- `cursor/` was fast-forwarded to product main.
- `./compare_helix.sh` confirmed convergence.
- `./validate_helix.sh` passed.
- Copilot reported `445 passed`.
- Cursor reported `445 passed`.

## Runtime reflection

Runtime reflection was intentionally not performed immediately after this
task because the sibling runtime checkout had an active periodic run.

This is acceptable because the change is terminal guidance only and does not
change scrape, DB, cron, Docker, or host-cron log semantics.

Runtime reflection can be deferred to a safe maintenance point after the
active run completes.

## Non-goals

This task intentionally did not introduce:

- automatic log tailing
- host_cron log format changes
- scrape behavior changes
- DB changes
- cron changes
- Docker compose changes
- runtime DB edits
- observability platform work

## Current interpretation

The current product baseline should be read as:

- `host_cron.log` remains the compact live/tail operations log.
- `batch_*.log` remains the detailed audit/postmortem log.
- `runtime/periodic_once.sh` now tells the operator where live progress is
  being written.

