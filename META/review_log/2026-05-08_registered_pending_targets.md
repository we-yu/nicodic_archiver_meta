# 2026-05-08 Registered Articles pending target fixes

## Closed work

- Merged `SubTask: show pending registered targets` (#61).
- Merged `SubTask-BugFix: search encoded registered targets` (#62).

## Runtime verification

- Runtime checkout was fast-forwarded to main and restarted.
- `query_registered_articles(search='神')` returned 122 rows.
- `query_registered_articles(search='神谷')` returned 5 rows, including `神谷浩史`.
- Web Registered Articles search also displayed `神谷浩史`.

## Notes

- The Registered Articles list now reflects active target rows, so the count can show all imported targets even before scraping.
- Rows with identical `created_at` may not place a newly registered item first; this is not treated as a blocker.
- Cron remains disabled until the denylist/ignore-list policy is reviewed.

## Next candidate work

- Review target/import/scrape denylist behavior, especially high-volume pages such as `>>3が理解できることが不幸`.
