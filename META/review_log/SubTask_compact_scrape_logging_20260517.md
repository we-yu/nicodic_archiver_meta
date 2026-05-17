# SubTask: compact scrape logging and OK0 host-log compression

## Positioning

This review log records two consecutive bounded logging subtasks:

- SubTask-compact-shot-heartbeat-log
- SubTask-compact-ok0-host-log

Together, they improve runtime scraping log readability while preserving scrape
semantics, DB schema, cron policy, and runtime data behavior.

The work is operational/logging polish, not a scraping behavior redesign.

## Background

Before these tasks, host-side scrape visibility was functional but still too
verbose for long-running personal runtime use.

The important observed problem was:

- successful no-change targets produced repeated STEP START / PAGE / STEP END
  blocks
- as the archive became populated, most targets were expected to become OK0
  targets
- long periodic runs would therefore become dominated by low-information
  no-change log rows
- AI and Human review both benefited from clearer HIT / WARN / FAIL / OK0
  separation

The goal was to make `host_cron.log` useful as a compact live/tail log while
keeping `batch_*.log` as detailed audit evidence.

## Adopted product changes

### Compact scrape heartbeat log

Adopted in product main as:

- `SubTask: compact scrape heartbeat logs (#67)`

Main outcomes:

- `host_cron.log` now emits compact structured sections:
  - `[RUN START]`
  - `[FEEDER SUMMARY]`
  - `[TARGETS]`
  - `[SCRAPE START]`
  - `[STEP START]`
  - grouped `[PAGE]` lines
  - `[WARN DETAIL]`
  - `[FAIL DETAIL]`
  - `[STEP END OK 🟢]`
  - `[STEP END WARN 🟡]`
  - `[STEP END FAIL 🔴]`
  - `[RUN END ...]`
  - `[RUN DIGEST]`
- URL is emitted on STEP START only.
- STEP END keeps result fields and does not repeat URL.
- PAGE heartbeat tokens are grouped to reduce vertical log growth.
- RUN DIGEST summarizes HIT / OK0 / WARN / FAIL / SKIP.
- `batch_*.log` keeps detailed PROGRESS audit rows and appends:
  - `BATCH_DIGEST`
  - `BATCH_DIGEST_ITEMS`

### Compact OK0 host log

Adopted in product main as:

- `SubTask: compact OK0 host log (#68)`

Main outcomes:

- clean no-change host-cron targets now emit one compact line:

  `[STEP OK0 🟢] ... reason=already_up_to_date`

- the one-line OK0 form includes:
  - timestamp
  - step index/total
  - article_id
  - title
  - saved count
  - observed count
  - page
  - elapsed time
  - reason
- URL is intentionally omitted from the one-line OK0 form.
- RUN DIGEST accounting remains intact.
- board page token display was normalized so page keys drop the trailing dash.

## OK0 compression rule

A target is eligible for `[STEP OK0 🟢]` only when all of the following are true:

- status is success
- stored_new is 0
- reason resolves to `already_up_to_date`
- no WARN / FAIL detail was emitted during the step
- exactly one successful PAGE token was observed
- saved_after is known
- observed_after is known
- no interrupt/status text is present

If any condition is not met, the target falls back to the detailed compact form:

- STEP START
- PAGE
- WARN DETAIL / FAIL DETAIL when applicable
- STEP END OK / WARN / FAIL

This keeps unusual, partial, warning, failure, multi-page, and unknown-observed
cases visible.

## Runtime observation

Runtime reflection was performed after product merge and validation.

A short periodic-once smoke run was executed with:

- `ONESHOT_LIMIT_DURATION_SECONDS=180`

Observed runtime result:

- host_cron.log emitted many `[STEP OK0 🟢]` rows
- OK0 rows were one-line, URL-free, and grep-friendly
- RUN DIGEST reported:
  - `hit_targets=0`
  - `ok0_targets=146`
  - `warn_targets=0`
  - `fail_targets=0`
  - `total_new_responses=0`
  - `[OK0] others=146`
- this confirms that the normal no-change path is compressed as intended

No WARN / FAIL runtime case was observed during the short smoke run. That is
acceptable because longer periodic runs are expected to eventually exercise
🟡 / 🔴 cases.

## Validation

Before adoption:

- Copilot and Cursor variants were both tested during the OK0 task.
- Copilot implementation was adopted for the OK0 compression task.
- The adopted implementation passed full Helix validation after merge.

Post-merge validation:

- `collect_task_review.sh` showed both child repos on product main.
- `compare_helix.sh --all` confirmed convergence.
- `validate_helix.sh` passed for both child repos.
- Both copilot and cursor reported:
  - 409 tests passed

## Files involved in adopted product changes

Important files touched across the two tasks:

- `compact_scrape_log.py`
- `host_cron.py`
- `main.py`
- `orchestrator.py`
- `tests/test_compact_scrape_log.py`
- `tests/test_host_cron.py`
- `tests/test_main.py`
- `SubTask-compact-shot-heartbeat-log_report.txt`
- `SubTask-compact-ok0-host-log_report.txt`

## Preserved non-goals

The logging tasks intentionally did not introduce:

- DB schema changes
- scrape_id / scrape_mark
- Delete Feeder detailed logging redesign
- parent log / third log stream
- JSON logging
- external log collector
- dashboard / Web log viewer
- cron schedule redesign
- scrape ordering changes
- response collection semantic changes
- Max Res No semantic redesign

## Current interpretation

The current runtime logging baseline should be read as:

- `host_cron.log` is the compact live/tail operations log
- `batch_*.log` is the detailed audit/postmortem log
- OK0 no-change targets are intentionally compacted in host_cron
- HIT / WARN / FAIL / partial / unusual cases remain expanded enough for review
- RUN DIGEST is the primary per-run summary for quick Human/AI inspection

Future related work should build on this boundary instead of scattering new
print statements.
