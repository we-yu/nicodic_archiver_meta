# SubTask: zero-response board scraped state

## Summary

SubTask-zero-response-board-scraped-state was adopted.

The task corrected Registered Articles semantics so that an article with a
completed scrape/check but zero saved responses is treated as scraped/checked,
not as pending or never-scraped.

## Adopted implementation

Cursor implementation was adopted.

Reason:

- It expresses scrape/check completion through existing
  `articles.latest_scraped_at`.
- It separates scrape/check completion from saved response count.
- It uses the same displayed Max Res No expression for read-side projection and
  sort semantics.
- It centralizes Web UI checked-state meaning through a helper instead of
  relying only on `saved_response_count`.
- It included slightly broader focused coverage than the Copilot alternative.

## Behavior after adoption

A registered article is treated as scraped/checked when:

- it has saved responses, or
- it has a populated last_scraped_at / latest_scraped_at value.

For completed zero-response scrapes:

- Saved Responses remains 0.
- Max Res No is displayed/read as 0.
- Last Scraped is populated.
- The row does not use the pending/not-scraped visual state.

Pending / never-scraped state is reserved for rows with:

- saved_response_count == 0
- no last_scraped_at

## Archive safety

This task did not change response preservation semantics.

Explicit invariants:

- existing responses are not deleted
- existing responses are not overwritten
- fake/dummy responses are not inserted
- an article with existing saved responses is not reset to zero by a later
  empty scrape/check
- downloads for already archived responses remain valid

## Validation

Before adoption:

- Copilot alternative passed validation.
- Cursor alternative passed validation.
- validate_helix.sh passed for both variants.
- Cursor reported 417 tests passed and was selected.

After adoption:

- product main was updated from the Cursor implementation.
- copilot and cursor child repos were synced to main.
- Helix convergence was confirmed.
- validate_helix.sh passed after adoption.

## Runtime status

Runtime reflection should be recorded separately after reflect_runtime.sh is
run and the runtime container is rebuilt/recreated.

Runtime smoke should focus on Registered Articles rows where:

- Saved Responses = 0
- Max Res No = 0
- Last Scraped is populated
- the row is not shown with the pending/not-scraped background

## Non-goals

This task intentionally did not introduce:

- response deletion
- response overwrite
- fake/dummy responses
- broad schema migration
- Max Res No full semantic redesign
- scrape_id / run mark
- target state system redesign
- board migration / redirect archive merge
- Delete Feeder changes
- cron policy changes
