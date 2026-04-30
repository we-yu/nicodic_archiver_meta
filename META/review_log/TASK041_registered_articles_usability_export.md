# TASK041 Review Log: Registered Articles usability and export

## Result

Adopted implementation: Cursor.

Copilot was reviewed as a comparison implementation, but was not adopted.
The Copilot branch remained failing validation with syntax/lint issues.
Cursor passed repo-local validation and runtime-copy smoke checks.

## Implemented scope

TASK041 added or improved:

- recent-first Registered Articles ordering
- bounded server-side sorting
- bounded pagination with 100 / 200 / 500 / 1000 page sizes
- bounded search by title and stored article identity
- clickable canonical URL links
- current-page CSV export
- internal all-record CSV export
- top-page Registered Articles button-like link
- human-facing download/export identity normalization

## Validation summary

Cursor validation passed during review.

Observed result:
- 309 tests passed.

Runtime-copy smoke confirmed:
- Registered Articles page rendered against /tmp/task041_cursor_smoke.db
- search worked for known titles
- current-page CSV matched the visible filtered page
- canonical URL links opened externally
- TXT download no longer exposed raw percent-encoded slug as the ID line

## Known limitations

The current Article ID column does not yet represent the numeric NicoNicoPedia
/id/ value such as 5560706.

The current DB appears to preserve the canonical article identity / slug as
the archive identity. Numeric IDs may appear inside response HTML link
parameters, but TASK041 does not introduce parser/storage/backfill logic for
numeric article ID capture.

Follow-up candidate:

TASK041B: Capture and display numeric NicoNicoPedia article ID

Potential follow-up items:
- numeric article ID capture and display
- Clear button on Registered Articles search
- table layout polish for long canonical URLs
- refined filename contract for slug-based articles
- pending-row visual confirmation with fixture data

## Runtime deployment note

Do not reflect TASK041 into the runtime checkout while the current long shot is
running. Runtime deployment should wait for a safe maintenance point or a later
soft-terminate mechanism.

