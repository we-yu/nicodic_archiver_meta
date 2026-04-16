# TASK036 Delete request feeder

## Task
TASK036

Add a bounded feeder that reads saved responses from
5511090a_ニコニコ大百科:掲示板レス削除依頼, extracts supported NicoNicoPedia
URLs, normalizes them into article-target input, and hands them off into the
existing target registration route.

## Positioning
This is a bounded mainline scrape/runtime task.

It changes:
- saved delete-request response scanning
- supported / unsupported NicoNico URL classification
- article-target normalization for accepted URL patterns
- bounded feeder state tracking by last processed response number
- bounded inspect seam for human verification
- batch-shot pre-pass behavior before the normal target loop

It does not change:
- broad text understanding semantics
- AI inference over request text
- user-facing article ID input support
- video / user / live support
- queue/scheduler redesign
- broad logging/observability platform

## What changed
Adopted result from Copilot sideflow:
- `main.py`
- `delete_request_feeder.py`
- `tests/test_main.py`
- `tests/test_delete_request_feeder.py`

Main adopted behavior:
- saved delete-request responses are scanned from the archive DB
- only explicit URL patterns are extracted in a bounded way
- URLs are classified into supported / unsupported categories
- supported patterns include:
  - `/a/...`
  - `/id/...`
  - `/b/a/...`
  - `/t/b/a/...`
  - `/t/a/...`
- supported board/thread URLs are normalized back to article URLs
- `/id/...` is resolved through an internal-only helper
- extracted normalized candidates are handed off into the existing target
  registration route
- duplicate / invalid / redirect handling remains delegated to existing
  mainline behavior
- the feeder tracks `last_processed_res_no`
- periodic/batch execution runs the feeder once at shot start
- newly queued targets are appended to the shot tail
- an inspect seam is available for stdout-only verification
- normal runtime logging remains tiny-summary only

## What did not change
This task did not change:
- user-facing input semantics
- general article resolution semantics outside the feeder
- archive save/read identity rules
- broad DB platform design
- generic URL support outside supported NicoNicoPedia article classes

## Validation summary
The following validation path was completed:

1. Double Helix implementation was attempted in both child repositories
2. Both Copilot and Cursor reached validate PASS
3. Synthetic smoke verification was run for the adopted Copilot result
4. Supported URL normalization behaved as expected
5. `/id/...` internal resolution behaved as expected in synthetic inspection
6. Reject-path handling for unsupported categories was observed
7. Copilot result was adopted
8. Cursor result was preserved as non-adopted comparison evidence
9. child repo mains were re-synchronized after adoption

## Synthetic smoke note
Adopted Copilot result was manually smoke-checked with a synthetic DB and
representative URL patterns. Observed inspect output included:

- ACCEPT for `/a/...`
- ACCEPT for `/b/a/...` normalized to `/a/...`
- ACCEPT for `/id/...` resolved to canonical article input
- REJECT for `/v/...`
- final SUMMARY line

## Interpretation
Current mainline scrape/runtime behavior should now be read as including:
- bounded delete-request feeder behavior
- supported NicoNicoPedia URL classification
- bounded article-target normalization
- shot-start feeder execution with shot-tail append
- bounded inspect seam for delete-request candidate review

## Meta note
This review log is AI-readable working memory.
It is not authoritative by itself.

Authoritative current state should still be restored from:
- `AI_CONTEXT.md`
- `_AI_RULES.md`
- `PROJECT_STATE.md`
- `WORKSPACE.md`
- `project_snapshot.txt`
