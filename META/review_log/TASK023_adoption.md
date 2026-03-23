# TASK023 Adoption Log

## Task
TASK023

Add bounded incremental fetch for saved articles, centered on
`max_saved_res_no` anchor resume, while keeping the task bounded to
CLI / orchestration / storage-read scope and adding minimal plain-text
target-list usability support.

## Decision
Adopted: **Copilot**

Alternative reviewed:
- Cursor implementation was retained as comparison evidence
- Hybrid was considered but not selected

## Final adopted shape
Changed files in the adopted product result:
- `orchestrator.py`
- `target_list.py`
- `tests/test_orchestrator.py`
- `tests/test_target_list.py`

## What changed in the adopted result
The adopted result added bounded incremental fetch for saved articles.

Saved-article behavior now:
- resumes from the page containing `max_saved_res_no`
- treats `res_no <= max_saved_res_no` as already existing on the resume page
- treats only `res_no > max_saved_res_no` as new candidates
- advances only into later pages that are needed
- treats zero-new as success-class behavior

Unsaved-article behavior remains:
- full fetch from the beginning

Target-list usability was also improved in bounded form:
- ignore comment lines beginning with `#`
- ignore blank lines
- trim surrounding whitespace

## Why Copilot was adopted
Primary reasons:

1. It matched the bounded task shape more directly.
   - the task core remained incremental fetch
   - the paired capability remained small and focused

2. It preserved the existing architecture more conservatively.
   - the change stayed centered on orchestrator behavior and target-list handling
   - it avoided widening the task into a broader redesign

3. It preserved the established persistence-flow baseline.
   - existing JSON-first / SQLite-second save ordering remained intact

4. After the small manual lint fix and the resume-start correction,
   the implementation aligned with the intended containing-page resume rule.

## Why Cursor was not adopted
Cursor remained useful as comparison evidence.

Observed strengths:
- storage-read helper placement had some architectural appeal
- the result was still informative for comparison

Reasons it was not selected:
- scope widened more than necessary for this task
- `storage.py` was changed even though the task could stay more bounded
- validation still failed in the reviewed state
- the implementation shape drifted farther from the intended bounded
  containing-page resume behavior

## Why Hybrid was not selected
Hybrid was considered, especially around small storage-read helper ideas.

Hybrid was not selected because:
- Copilot already satisfied the task with a narrower adopted shape
- no borrowed change was necessary to complete the task safely
- preserving a simple, conservative adoption decision was preferable

## Validation performed
Confirmed during review:
- pre-adoption review compared both task branches
- a localized lint issue in the adopted branch was manually corrected
- post-fix `./validate_helix.sh` passed for the adopted result
- non-adopted Cursor branch remained preserved as comparison evidence

Post-adoption confirmation:
- both child repos were realigned after `main` integration
- post-realignment validation passed
- helix convergence passed with `./compare_helix.sh --all`

## Repository outcome
- adopted product repository: `copilot/`
- adopted assets were product code / tests, not root meta assets
- adopted implementation branch was pushed
- Cursor comparison branch was also pushed as review evidence
- optional adopted marker branch was pushed
- adopted result was integrated into child-repo `main`
  using the repository-compliant method

## Convergence result
Confirmed:
- adopted final state exists in both child repos after realignment
- `./compare_helix.sh --all` passed
- post-task baseline is shared again

## Notes for future AI sessions
Important interpretation:
- TASK023 is complete once the adopted result is on product `main`
  and both child repos are realigned
- bounded incremental fetch is now part of the adopted scraping baseline
- target-list comment / blank / trim support is part of the adopted
  plain-text target-list behavior
- do not reopen TASK023 unless there is a concrete defect or a clearly
  new bounded follow-up goal

## Meta note
This log is AI-readable review memory.
It is not the authoritative project state by itself.
Authoritative context should still be restored from:
- `AI_CONTEXT.md`
- `PROJECT_STATE.md`
- `WORKSPACE.md`
- `project_snapshot.txt`

