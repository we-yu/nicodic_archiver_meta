# SubTask-hotword-target-feeder adoption log

## Summary

Cursor-only implementation was adopted for `SubTask-hotword-target-feeder`.

The task adds a bounded HOT word target feeder that extracts recent article URLs
from the NicoNicoPedia article "今週のニコニコ大百科 HOTワード" and feeds them
through the existing target registration boundary.

## Adopted implementation

Adopted repo:

- cursor

Adopted branch:

- subtask-hotword-target-feeder-cursor

Main behavior:

- Adds `hotword_feeder.py`.
- Extracts candidates only from the "過去のHOTワードbest3" section/table.
- Uses a bounded recent-week limit, default 12.
- Processes only data-row 1st/2nd/3rd rank cells.
- Deduplicates candidates in first-seen order.
- Supports relative `/a/...` and absolute `https://dic.nicovideo.jp/a/...` article URLs.
- Reuses `target_list.register_target_url()` for validation, normalization, denylist handling, resolution, and duplicate suppression.
- Does not insert directly into target tables.
- Integrates near the existing Delete Feeder shot-start feeder phase.
- Adds `inspect-hot-word-target-feed` as a bounded scan-only inspect seam.
- Adds compact HOT_WORD_FEED summary output/logging.

## Scope control

Explicitly not changed:

- No DB schema migration.
- No target registry schema change.
- No Web UI change.
- No runtime DB direct edit.
- No runtime crontab change.
- No Docker config change.
- No Slack/Gmail/monitoring/Web problem report feature.
- No broad all-page `/a/...` extraction.
- No score ranking / related item extraction.
- No custom target insert logic.

## Review notes

Initial validation found failures in `tests/test_main.py`.

The failure was judged to be a test isolation issue, not a collapse of the
HOT word extraction design. The default-on HOT word feeder leaked into existing
main batch tests and expanded the mocked target list by fetching/registering
HOT word targets.

The fix isolates existing main tests from the real HOT word feeder while adding
focused integration tests that explicitly mock small HOT word summaries and
verify same-shot target append behavior.

Production `HOT_WORD_FEED_ENABLED` remains default-on. The tests do not change
production default behavior to hide the issue.

## Same-shot semantics

Added/reactivated HOT word targets are returned in `queued_target_urls` and
merged into the current run target list via `append_batch_targets()` before
target ordering and the scrape loop.

Therefore, newly added/reactivated HOT word targets can be same-shot scrape
targets.

Caveat:

- `stored_article_ids_by_url` is built from pre-existing active targets before
  the HOT word feeder runs.
- Fresh HOT word targets may not have stored article IDs available in that map.
- They can be same-shot scrape targets, but article_id-based start override is
  not guaranteed for those fresh targets in the same shot.
- Target ordering semantics were not redesigned.

## Validation

Pre-adoption validation:

- `./validate_helix.sh cursor`: PASS
- Result: 538 passed

Post-adoption validation:

- To be filled after `compare_helix.sh --all` and `validate_helix.sh`.

## Editor AI

Editor AI:

- Claude Opus 4.8 via Cursor agent

## Conclusion

Adopt Cursor implementation. No DHM expansion or full redesign is needed for
this bounded SubTask.

