# SUBTASK005 Web Saved Download Polish

## Task
SUBTASK005

Polish the bounded Web saved-download UX without widening into broad export,
runtime, or scheduler redesign.

## Positioning
This is a bounded subtask on top of the adopted TASK034 Web single-submit baseline.

It is not a new mainline feature family.
It is a bounded UX / readout / download polish correction task.

## Adopted result
Adopted: Copilot

Comparison status:
- Copilot side was used as the adopted implementation path
- Cursor side remained unchanged and was retained only as branch evidence

## What changed
Changed files in the adopted result:
- `archive_read.py`
- `orchestrator.py`
- `storage.py`
- `web_app.py`
- `tests/test_archive_read.py`
- `tests/test_cli.py`
- `tests/test_orchestrator.py`
- `tests/test_storage.py`
- `tests/test_web_app.py`

Main adopted behavior:
- long result/status text now wraps more safely in the Web UI
- saved TXT download filename is now human-readable with article title included
- normal TXT response header lines no longer include the misleading leading `>`
- misleading user-facing `Created` metadata was removed from TXT export
- bounded article-facing metadata support was improved in additive form
- Web action logging failure is now non-fatal
- archive read path no longer performs write-on-read schema mutation
- readonly-like archive read conditions now degrade safely
- saved URL input parity was restored for:
  - decoded article URL input
  - percent-encoded article URL input
- saved URL input no longer falls incorrectly into unsaved registration flow
- bounded registration-write failure handling no longer leaks a raw server error page

## Validation summary
The following validation/review path was completed:

1. Copilot implementation was iteratively corrected within bounded scope
2. runtime-like temporary container smoke checks were performed against the Copilot branch
3. browser checks confirmed:
   - title input saved flow OK
   - decoded article URL input saved flow OK
   - encoded article URL input saved flow OK
   - result panel healthy
   - TXT auto-download healthy
4. downloaded TXT content confirmed:
   - human-readable filename
   - expected article metadata header shape
   - normal response header leading `>` removal
5. `./validate_helix.sh` passed:
   - copilot: PASS
   - cursor: PASS

## Why Copilot was adopted
Primary reasons:
- it reached bounded practical completion for the intended Web/TXT polish task
- browser-side result and TXT download behavior were confirmed directly
- the adopted result repaired runtime-like readonly/logging issues without widening scope
- the final shape preserved the TASK034/TASK028 Web baseline while improving practical saved-download UX

## Why Cursor was not adopted
- Cursor did not carry this subtask implementation forward
- it remained on the earlier shared baseline and served only as unchanged branch evidence

## What did not change
This subtask did not introduce:
- CSV / MD / HTML Web download
- scrape redesign
- queue / scheduler redesign
- broad storage redesign
- runtime publication redesign
- auth / multi-user / dashboard work

## Repository outcome
- adopted implementation branch: `task005-web-saved-download-polish-copilot`
- adopted result was integrated into child-repo `main`
- both child repositories were then realigned to the same adopted final state
- `_runtime` sibling checkout was also reflected to adopted `main`

## Interpretation
Current Web saved-download baseline should now be read as including:
- bounded long-text wrap improvement
- bounded saved TXT filename improvement
- bounded TXT response-header readability improvement
- bounded metadata-header polish
- readonly-safe archive read behavior
- saved URL-input parity restoration for the Web archive-check flow

## Meta note
This log is AI-readable review memory.
It is not authoritative current state by itself.

Authoritative context should still be restored from:
- `AI_CONTEXT.md`
- `PROJECT_STATE.md`
- `WORKSPACE.md`
- `project_snapshot.txt`


