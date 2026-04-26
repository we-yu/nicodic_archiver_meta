# SUBTASK010 Canonical Scrape Identity Review Log

## Task
SUBTASK010

Preserve canonical `/a` article identity at the scrape/archive boundary.

## Background
SUBTASK007 fixed the target registration boundary so `/id/<number>` inputs can
be normalized to effective `/a/<title>` targets.

A later runtime shot showed that targets were registered as `article_type='a'`,
but scrape/archive persistence recreated many `articles.article_type='id'`
zero-response rows.

The observed shape was:
- target rows were `/a`
- article rows were recreated as `/id`
- response rows for `/id` stayed at zero

This meant target registration was fixed, but scrape/archive metadata identity
could still be pulled back to `/id`.

## Root cause
Nicopedia article pages can contain:
- `link rel="canonical"` pointing to `/a/<title>`
- `meta property="og:url"` pointing to `/id/<number>`

The scrape/archive path did not sufficiently preserve the canonical `/a` URL
through metadata resolution, BBS URL generation, and DB save boundary.

## Adopted implementation
Copilot implementation was adopted.

The implementation:
- preserves canonical article URL in metadata result
- keeps legacy tuple metadata test seams compatible
- uses canonical article URL in `run_scrape()`
- uses canonical article URL for BBS base URL construction
- passes canonical article URL to DB save boundary
- avoids redesigning target registration, feeder, storage schema, and Web UI

## Validation
Validation passed:
- focused orchestrator tests passed
- full helix validation passed
- Copilot and Cursor main branches converged on the adopted commit

Runtime smoke:
- `/id/654665` resolved at scrape time to `/a/発達障害`
- BBS fetch used `/b/a/...`
- `run_scrape(..., response_cap=1)` saved one response
- DB after smoke showed:
  - `articles.article_type='id'` count was `0`
  - `responses.article_type='id'` count was `0`
  - `target.article_type='id'` count was `0`
  - `articles_by_type` increased on `a`
  - `responses_by_type` increased on `a`

## Runtime follow-up
The runtime checkout required a local compose hotfix so
`SCRAPE_PAGE_DELAY_SECONDS` is passed into the container environment.

Runtime was verified with:
- `SCRAPE_PAGE_DELAY_SECONDS=2.5`
- `get_scrape_delay_seconds()` returning `2.5`

This compose environment forwarding should be reflected into mainline in a
small follow-up task.

## Operational status
The periodic cron job was intentionally paused during investigation.

After runtime smoke and cleanup, cron can be restored and a manual
`periodic_once.sh` shot can be started.

## Non-goals
This task did not:
- migrate historical ID rows
- change DB schema
- change Web UI
- change download formats
- redesign delete-request feeder
- restore JSON archive output
- introduce a new scheduler


