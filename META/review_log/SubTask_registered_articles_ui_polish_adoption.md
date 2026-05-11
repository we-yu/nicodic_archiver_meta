# SubTask: Registered Articles UI polish adoption

## Summary

The `Registered Articles` UI polish SubTask was implemented as a
Copilot-only single-editor SubTask and adopted through the standard GitHub PR
flow.

This task improved the read-side and UI behavior of the Registered Articles
page after TASK044 normalized article identity handling to numeric NicoNicoPedia
article IDs.

The task is now adopted into product `main` and reflected to the runtime
checkout.

## Task type

- Type: bounded SubTask
- Editor: Copilot only
- DHM: not used
- Product branch: `Subtask-registered-articles-ui-polish-copilot`
- Product merge target: `main`
- Runtime reflection: completed after product merge

This was kept as a single-editor SubTask because the work was bounded to
read-side sorting, table layout, Web display formatting, CSV preservation, and
focused tests. It did not require competing architectural proposals.

## Adopted product changes

### Registered Articles sorting

The Registered Articles read-side sorting was updated so sortable columns use
the appropriate data type instead of plain text ordering.

Adopted behavior:

- `Article ID` sorts numerically for numeric article IDs.
- `Saved Responses` sorts numerically.
- `Max Res No` sorts numerically using the current existing read-side value.
- `Created At` sorts as a datetime-like value.
- `Last Scraped` sorts as a datetime-like value.
- Default sort remains `Created At DESC`.
- Stable ordering was preserved for normal list browsing.

### Registered Articles Web UI

The Registered Articles Web UI was polished for operational and visitor-facing
readability.

Adopted behavior:

- Web table times are displayed in JST.
- `Created At` and `Last Scraped` now use a consistent compact display style.
- Search input width was increased.
- `Reset` action was added.
- `Refresh` action was added.
- Pagination controls are shown above and below the table.
- Title and Canonical URL column widths were adjusted.
- Long canonical URLs are ellipsized in the Web table.
- Full canonical URLs remain available through the actual link target and
  tooltip/title behavior.
- Table header and body cells are vertically centered.
- Horizontal alignment was adjusted by data type:
  - Title and Canonical URL are left-aligned.
  - Article ID, Saved Responses, and Max Res No are right-aligned.
  - Type and date columns are centered.

### CSV behavior

CSV export behavior was intentionally preserved where it matters for data use.

- CSV keeps full Canonical URL values.
- CSV does not use visual ellipsis.
- CSV date formatting was preserved as machine-friendly existing values.
- Web-only table display was changed to JST.

## Final browser review

A Copilot temporary Web smoke server was launched against runtime data for
browser review before adoption.

Browser review confirmed:

- Article ID numeric sorting behaved correctly.
- Created At and Last Scraped were displayed in JST.
- Search input width was improved.
- Reset and Refresh were present and usable.
- Top pagination was present.
- Bottom pagination remained present.
- URL display used ellipsis while preserving full link behavior.
- CSV retained full Canonical URL values.
- Title and URL column widths were adjusted after review.
- Final Title 21% / URL 13% width balance was accepted.
- Table vertical alignment was accepted after the final alignment tweak.

The UI can still be refined in future polish work, but the current state is a
substantial improvement and is acceptable for regular use.

## Validation

Pre-adoption validation:

- `./validate_helix.sh`
- Copilot: PASS
- Cursor: PASS

Post-merge validation after child repo synchronization:

- `./compare_helix.sh --all`: expected to converge after Cursor pulls merged
  main.
- `./validate_helix.sh`: expected to pass for both Copilot and Cursor after
  synchronization.

Recorded validation before final Cursor synchronization showed:

- Copilot main: 394 tests passed
- Cursor main: 379 tests passed

Cursor was still on the previous main during the first compare check, so
`compare_helix.sh --all` reported a file-list mismatch for
`SubTask-registered-articles-ui-polish_report.txt`. This is expected until
Cursor is fast-forwarded to merged main.

## Runtime reflection

Runtime update was performed after product merge.

Runtime reflection steps completed:

- Confirmed no periodic/batch process was running.
- Confirmed `periodic_once.lock` was absent.
- Removed obsolete runtime-only temporary file:
  `orchestrator.py.pre_df_cap_20260510_180127`
- Fast-forwarded `/home/manage/product/nicodic_archiver_runtime` to merged main.
- Rebuilt and recreated runtime with `tools/runtime_up.sh`.
- Confirmed runtime container restarted.
- Confirmed runtime Web process is running.

Runtime Web now shows the improved Registered Articles UI.

## Cron state

Periodic cron remains active:

```text
5 */3 * * * cd /home/manage/product/nicodic_archiver_runtime && ONESHOT_LIMIT_DURATION_SECONDS=7200 ./runtime/periodic_once.sh >> /home/manage/product/nicodic_archiver_runtime/runtime/logs/host_cron.log 2>&1

Meaning:

Every 3 hours.
2 hour oneshot limit.
Current article is allowed to finish when duration limit is reached.
Lock file protects against overlapping runs.

Cron behavior was not changed by this SubTask.

Explicit non-goals

The following were intentionally not changed:

Max Res No semantic redesign.
Scraper behavior.
Delete-request feeder behavior.
Runtime DB contents.
Runtime cron policy.
Response cap behavior.
DB schema.
DB migrations.
Article identity semantics.
Direct runtime DB editing.
JavaScript-heavy table redesign.
Max Res No note

Max Res No still uses the current read-side value derived from locally saved
responses. It now sorts numerically, but its deeper semantic mismatch with the
live NicoNicoPedia board's observed latest response number remains unresolved.

This should be handled as a separate future MainTask, likely together with run
identity / scrape observation / target state tracking.

Files changed in product repo
archive_read.py
web_app.py
tests/test_archive_read.py
tests/test_web_app.py
SubTask-registered-articles-ui-polish_report.txt
Report file

Product-local report:

SubTask-registered-articles-ui-polish_report.txt

The report includes:

Summary
Files touched
Tests added or updated
Validation status reported by the editor
Known limitations
Max Res No semantic non-goal
CSV date formatting note
88-character line limit note
Final layout tweak note
Follow-up candidates

Likely follow-up work:

Max Res No semantic redesign.
Scrape run identity and short run mark display.
Target state tracking, including invalid state and observed max response
number.
Import / feeder resilience when individual article resolution fails.
Root/meta generated snapshot handling policy.
EOF

確認します。

```bash
cd /home/manage/product/nicodic_archiver && test -s META/review_log/SubTask_registered_articles_ui_polish_adoption.md && echo review_log_ok


