# TASK038 Saved Download Format Selection

## Task
TASK038

Add bounded multi-format saved-article download selection to the Web UI while
keeping TXT as the default and preserving the existing saved-download baseline.

## Positioning
This is a bounded main task on top of the current Web saved-download baseline.

It extends saved article download behavior for a single article.
It does not redesign scrape, queue, scheduler, runtime publication, or broad
archive semantics.

## Adopted result
Adopted: Copilot

Comparison status:
- Copilot implementation was adopted
- Cursor implementation was reviewed but not adopted

## Why Copilot was adopted
Primary reasons:
- better alignment with the actual TASK038 center:
  bounded Web saved-download format selection
- format selection was integrated into the saved flow more directly
- export handling was generalized cleanly for `txt` / `md` / `csv`
- browser-side practical behavior was confirmed as acceptable
- final validation passed

## Why Cursor was not adopted
Cursor had useful ideas, especially around cautious archive/export handling,
but the resulting UI/flow shape was less aligned with the intended saved-flow UX.
In practice it behaved more like a post-result manual selector path than the
preferred direct saved-download selection flow.

## What changed
Changed files in the adopted implementation:
- `archive_read.py`
- `web_app.py`
- `tests/test_archive_read.py`
- `tests/test_web_app.py`

Main adopted behavior:
- Web saved-download now supports bounded format selection
- supported formats in this task:
  - `txt`
  - `md`
  - `csv`
- default format remains `txt`
- saved title input flow supports selected format
- saved decoded article URL input flow supports selected format
- saved encoded article URL input flow supports selected format
- CSV export is 1 response = 1 record
- CSV uses the stable header:
  - `article_id`
  - `article_type`
  - `article_title`
  - `article_url`
  - `res_no`
  - `poster_name`
  - `poster_id`
  - `posted_at`
  - `content_text`
  - `content_html`
- TXT behavior from the previous baseline remains preserved
- Markdown rendering was additionally corrected so leading `>` lines are escaped
  and visible line breaks are kept in common Markdown preview behavior

## Practical validation summary
Validation and review path completed:
1. Copilot and Cursor implementations were compared
2. both child repos passed validate
3. practical browser checks were performed against temporary child-repo containers
4. saved flow was checked for:
   - title input
   - decoded article URL input
   - encoded article URL input
5. download success was checked for:
   - TXT
   - MD
   - CSV
6. downloaded file contents were spot-checked
7. Markdown preview behavior was additionally corrected for quote-like lines and
   line-break preservation
8. final adopted implementation passed validation again

## What did not change
This task did not introduce:
- HTML export
- JSON export
- scrape redesign
- queue / scheduler redesign
- whole-archive export redesign
- runtime publication redesign
- auth / account work

## Interpretation
Current Web saved-download baseline should now be read as including:
- TXT default saved download
- bounded Web format selection for `txt` / `md` / `csv`
- saved title-input parity
- saved decoded/encoded URL-input parity
- bounded CSV one-response-per-record export
- bounded Markdown human-readable export

## Repository outcome
- adopted implementation branch: `task038-web-download-format-selection-copilot`
- adopted result was integrated into child-repo `main`
- both child repositories were then realigned to the same adopted final state
- sibling runtime checkout should also be reflected as part of practical closeout

## Meta note
This log is AI-readable review memory.
It is not authoritative current state by itself.

Authoritative restore still depends on:
- `AI_CONTEXT.md`
- `PROJECT_STATE.md`
- `WORKSPACE.md`
- `project_snapshot.txt`


