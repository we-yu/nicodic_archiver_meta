# SubTask Review Log: soft terminate periodic shot

## Result

Adopted implementation: Copilot.

## Editor model

Copilot editor model: GitHub Copilot GPT-5.4

## Summary

This SubTask added bounded operator controls for long-running batch /
periodic-one-shot runs.

Implemented controls:

- `SOFT_TERMINATE_FILE`
- `ONESHOT_LIMIT_DURATION_SECONDS`

The stop behavior is article-boundary based.

A stop request does not interrupt:

- an in-flight article scrape
- an in-flight BBS page fetch
- a DB write

The current article is allowed to finish. The run then stops before starting
the next target.

## Runtime behavior

Default soft terminate flag path:

- `runtime/control/stop_after_current`

A positive `ONESHOT_LIMIT_DURATION_SECONDS` value bounds one batch /
periodic-one-shot run by elapsed time. The duration limit is checked only at
safe article boundaries.

Controlled stops are treated as success-class when no scrape failure occurred.

## Validation

The implementation passed repo-local validation.

Observed validation:

- Copilot: PASS
- Cursor: PASS

Additional static checks:

- `runtime/periodic_once.sh` passed `bash -n`
- docker compose config included the soft terminate variables and control mount

## Runtime note

Runtime DB was not modified.

TASK043 DB apply was not performed.

This feature does not retroactively affect an already-running process that has
not loaded this code. The currently running long shot will not gain this
feature until runtime code is reflected and the runtime process is restarted or
recreated.

## Follow-up

After reflecting this change to runtime, operators can use the soft terminate
flag or one-shot duration limit for future runs.

The current long shot still requires separate manual stop handling if it must
be stopped before natural completion.

