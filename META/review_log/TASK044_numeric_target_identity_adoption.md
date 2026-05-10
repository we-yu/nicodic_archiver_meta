# TASK044 numeric target identity adoption log

## Task

- Title: Normalize target registry identity to numeric NicoNicoPedia article ID
- Type: MainTask / Double Helix
- Adopted implementation: Cursor
- Reference implementation: Copilot branch retained
- Adopted product commit: GitHub-merged `main` after Cursor branch
  `TASK044-numeric-target-identity-cursor`

## Purpose

Registered Articles exposed a target identity mismatch: pending target rows
stored `/a/<slug>`-derived values in `target.article_id`, causing the Article ID
column to show values like `zun`, `zzz`, or decoded Japanese titles.

The intended semantic is that Article ID means the numeric NicoNicoPedia article
ID, normally derived from page metadata such as:

`<meta property="og:url" content="https://dic.nicovideo.jp/id/<digits>"/>`

## Adopted design

- Added a shared URL parsing seam in `dicopedia_urls.py`.
- Added a shared page identity extraction seam in `article_page_identity.py`.
- Target registration now resolves article pages to:
  - numeric `article_id`
  - `article_type='a'`
  - canonical `/a/<slug>` URL
  - title
- Added optional `target.title`.
- Added storage boundary validation so `article_type='a'` target rows require a
  non-empty digits-only `article_id`.
- Registered Articles and CSV now prefer `target.title` and numeric article ID.
- Default Registered Articles sort keeps registration-time descending and adds
  target row id descending as a stable tie-breaker.
- `resolution_failure` is the canonical registration resolution failure key.
- `orchestrator.fetch_article_metadata_record` reuses the shared identity
  extraction seam so scrape-side metadata interpretation stays aligned.

## DHM notes

Copilot produced a smaller existing-structure implementation and was retained as
a reference branch.

Cursor was adopted because TASK044 is primarily about consistent identity
interpretation across registration, metadata, and scrape boundaries. The shared
seam approach better matches that purpose.

## Validation

Post-adoption validation must be recorded after both child repos are pulled to
main.

Expected:
- `./compare_helix.sh --all`: converged
- `./validate_helix.sh`: Copilot and Cursor PASS

## Non-goals

- Runtime DB was not edited by editor AI.
- Runtime cron was not restarted.
- Existing runtime DB slug target migration was not included.
- Response cap behavior was not changed.
- No `article_type='id'` rows are introduced.
- No user/video article expansion was implemented.

## Runtime follow-up

Runtime reflection is still pending after product adoption.

Because the current runtime DB is disposable / reconstructable and already
contains imported target rows with legacy slug identity, runtime maintenance
should be handled separately after merge.

Preferred operational options:
- reset/reimport runtime DB using the new registration behavior, or
- run bounded maintenance only if explicitly designed later.

Cron remains disabled until runtime reflection and smoke checks are complete.

