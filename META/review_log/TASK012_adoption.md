# TASK012 Adoption Log

## Task
TASK012

Strengthen representative regression protection for the already-adopted
single-article scrape path, centered on `tests/test_orchestrator.py`,
while preserving current semantics and avoiding production-code redesign.

## Decision
Adopted: **Copilot**

Alternative reviewed:
- Cursor retry implementation was retained as comparison evidence
- Hybrid was considered but not selected

## Final adopted shape
Changed file:
- `tests/test_orchestrator.py`

Production code was not changed.

## What changed in the adopted result
The adopted result added representative regression coverage for the
already-adopted single-article `run_scrape()` behavior.

The added coverage explicitly protects representative save-path cases:
- normal save path
- no-BBS / zero-response empty-result save path
- later-page interruption partial-save path
- response-cap reached partial-save path

The added coverage also explicitly protects representative skip-path cases:
- article not found
- known high-volume skip

The adopted result kept the task centered on executable regression protection
rather than documentation-only clarification.

## Why Copilot was adopted
Primary reasons:

1. It matched the TASK012 intent more directly.
   - TASK012 was about representative regression strengthening
   - Copilot expressed that strengthening as explicit executable regression tests

2. The resulting task shape was easy to review.
   - representative save-path coverage was grouped clearly
   - representative skip-path coverage was also grouped clearly
   - the single-article baseline protected by TASK012 was easy to see

3. It preserved project boundaries well.
   - only `tests/test_orchestrator.py` changed
   - production code remained untouched
   - no parser / storage / http_client redesign was introduced
   - no retry/backoff or broader failure-taxonomy expansion was introduced

4. It remained within the bounded tests-centered scope.
   - no tests-only drift into unrelated cleanup
   - no architecture change
   - no task-scope widening

## Why Cursor retry was not adopted
Cursor retry became a valid comparison candidate after re-prompting.

Observed strengths:
- very conservative change size
- executable regression assertions were added
- production code remained untouched
- existing tests were tightened locally rather than expanded broadly

Reasons it was not selected:
- the representative scenario coverage was less explicit at the task-shape level
- the final protection was more distributed across existing tests
- compared with Copilot, the adopted single-article baseline was less immediately visible as a representative regression layer

## Why Hybrid was not selected
Hybrid was considered, but not selected because:
- both results were already valid and bounded
- no narrow borrowed adjustment clearly improved the adopted Copilot result enough to justify a hybrid
- merge-for-the-sake-of-merge was unnecessary
- keeping the decision simple improved review memory clarity

## Validation result
Validation was run via the established helix workflow helper.

- `./validate_helix.sh` passed for both `copilot/` and `cursor/`
- final post-adoption validation on `main` also passed for both child repositories

## Convergence result
- `./compare_helix.sh --all` passed after realignment
- `copilot/` and `cursor/` were confirmed to match on the adopted final state

## Repository outcome
- adopted implementation repository: `copilot/`
- comparison-evidence repository: `cursor/`
- an adoption marker branch may be used as:
  - `adopted/task012-orchestrator-regression`
- after product-repo integration, both child repositories were realigned to the same adopted final state

## Notes for future AI sessions
Important interpretation:
- TASK012 is complete
- the post-TASK012 baseline includes stronger representative regression protection
  for the already-adopted single-article `orchestrator` path
- production behavior was not intentionally changed
- future planning may now move more confidently toward TASK013-style bounded
  functional expansion, while treating the single-article baseline as more firmly protected

## Meta note
This log is AI-readable review memory.
It is not authoritative current state by itself.

Authoritative context should still be restored from:
- `AI_CONTEXT.md`
- `PROJECT_STATE.md`
- `WORKSPACE.md`
- `project_snapshot.txt`


