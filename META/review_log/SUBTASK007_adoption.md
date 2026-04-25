# SUBTASK007 ID Article URL Normalization Adoption Log

## Task
SUBTASK007

Normalize Nicopedia ID article URL input before target registration.

## Purpose
Prevent incoming `https://dic.nicovideo.jp/id/<number>` URLs from being
persisted as scrape targets that later collect from `/b/id/<number>/`.

Runtime investigation showed that ID-style targets can create valid article
metadata rows with zero responses, while the real discussion board content is
available through the title-based `/a/<title>` route.

## Decision
Adopted: Copilot-only implementation

Cursor was not used for this SubTask.

## Final adopted shape
Production changes were limited to:
- `http_client.py`
- `target_list.py`

Focused tests were updated in:
- `tests/test_http_client.py`
- `tests/test_target_list.py`
- `tests/test_operator_cli.py`

## What changed
A narrow resolver was added for Nicopedia ID article URLs.

When a target input URL matches:

- `https://dic.nicovideo.jp/id/<number>`

the resolver follows normal HTTP redirects and uses the effective `/a/<title>`
URL when available.

If the effective URL is not `/a`, the resolver can fall back to
`link rel="canonical"` when it points to a valid `/a` URL.

`og:url` is not used as the collection / registration target when it points
back to `/id/<number>`.

Target registration now normalizes incoming URLs before persisting them.

Target import now goes through the same registration boundary.

## What stayed unchanged
The following behavior was intentionally kept unchanged:
- `parse_target_identity()` remains syntax-only
- `validate_target_url()` remains syntax-only
- existing `/a/<title>` registration behavior
- scrape orchestration
- article metadata extraction
- BBS URL generation
- storage schema
- Web UI
- saved download TXT / MD / CSV behavior
- registered article list behavior

## Practical validation
Validation passed.

Container smoke checks confirmed:
- `resolve_id_article_url("https://dic.nicovideo.jp/id/5364158")` returns the
  effective `/a/おそ松さん` URL
- `register_target_url()` stores the resolved `/a` URL for ID input
- normal `/a` URL registration is unchanged
- import from a text file also normalizes ID input through the shared boundary
- parse / validate behavior remains syntax-only

## Non-goals
This SubTask did not:
- clean existing runtime DB rows
- migrate existing `article_type='id'` targets
- delete existing empty `id` article rows
- add schema columns
- add collection URL schema separation
- redesign scraping
- redesign delete-request feeder state
- modify Web UI

## Follow-up
Existing runtime `id` records should be handled by a separate maintenance task.

The likely practical maintenance approach is to remove historical empty
ID-style records and reset the delete-request feeder cursor so the feeder can
rescan through the corrected registration path.

That maintenance should only be done after SUBTASK007 is reflected to runtime.


