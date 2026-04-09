# SUBTASK001 KGS Builtin Trim Fix

## Task
SUBTASK001

Fix the built-in KGS follow-up trim path so that
`--followup-drop-last N` trims saved responses using the saved canonical
article identity from isolated state, instead of using the URL slug identity.

## Positioning
This is a bounded subtask on top of the adopted TASK033 / TASK033B baseline.

It is not a new mainline task family expansion.
It is a correctness fix inside the existing verification / KGS seam.

## Background
After TASK033 / TASK033B had already been adopted, built-in KGS follow-up
showed a defect during direct observation.

Observed behavior:
- initial fetch saved responses correctly
- built-in follow-up trim reported `Follow-Up Trimmed Responses: 0`
- follow-up state did not actually trim saved responses

This was reproduced directly with built-in KGS follow-up,
not only through helper-based smoke.

## Root cause
The built-in KGS follow-up trim path used the slug-side identity from
`parse_target_identity(...)`, while saved archive rows in isolated state were
stored under the canonical saved article ID.

Representative observed example:
- target URL: `https://dic.nicovideo.jp/a/unix`
- slug-side identity: `unix`
- saved canonical article ID in DB: `694740`

As a result, trim tried to delete rows using `article_id='unix'`,
while the saved rows existed under `article_id='694740'`.

That mismatch caused:
- `saved_response_count_before=0`
- `selected_res_nos=[]`
- `actual_removed=0`

## What changed
Changed file:
- `verification_cli.py`

Added/fixed behavior:
- built-in KGS follow-up now resolves the saved canonical article ID
  from isolated DB state using:
  - `canonical_url`
  - `article_type`
- follow-up trim now uses that resolved canonical article ID
- bounded human-readable trim debug lines were added around:
  - requested drop count
  - trim target article ID
  - saved counts before / after
  - selected response numbers
  - actual removed count

## Validation summary
The following bounded observation / fix cycle was completed in this thread:

1. authoritative current state and side-flow candidate were separated
2. helper-based observation was distinguished from built-in observation
3. built-in KGS follow-up was directly observed on:
   - UNIX
   - ファミリーマート
4. the trim-0 symptom was reproduced on built-in follow-up
5. internal trim debug was added
6. saved DB / JSON state was inspected directly
7. canonical-vs-slug identity mismatch was identified
8. `verification_cli.py` was corrected to resolve canonical saved article ID
9. the fix was validated on built-in KGS follow-up
10. the fix was merged to child-repo `main`
11. `copilot/` and `cursor/` were realigned to the same final state

## Confirmed fixed behavior
Confirmed on merged `main` for UNIX:

- `identity_article_id=unix`
- `canonical_article_id=694740`
- trim target article ID became `694740`
- trim observed:
  - `saved_response_count_before=50`
  - `selected_res_nos=[50, 49, 48, 47, 46]`
  - `actual_removed=5`
  - `saved_response_count_after=45`
- follow-up resumed from:
  - `max_saved_res_no=45`
- bounded re-fetch collected 5 responses
- final saved response count returned to 50

## Repository outcome
- the fix was adopted into child-repo `main`
- both `copilot/` and `cursor/` were pulled forward to the same merged main
- convergence was confirmed after synchronization
- working trees were cleaned after merge and branch cleanup

## Interpretation
Current verification baseline should now be read as:

- TASK033
- TASK033B
- SUBTASK001 built-in KGS canonical trim fix

KGS still remains:
- manual
- opt-in
- isolated
- non-gating

The change does not widen KGS into a new platform.
It fixes a concrete built-in correctness issue inside the existing bounded seam.

## Meta note
This log is AI-readable review memory.
It is not authoritative current state by itself.

Authoritative context should still be restored from:
- `AI_CONTEXT.md`
- `PROJECT_STATE.md`
- `WORKSPACE.md`
- `project_snapshot.txt`
