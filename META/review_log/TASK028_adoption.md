# TASK028 Adoption Log

## Task
TASK028

Minimal Web app skeleton and frontend.

## Decision
Adopted: **Copilot**

Alternative reviewed:
- Cursor implementation was retained for comparison evidence
- Hybrid was considered but not selected

## Final adopted shape
Changed files:
- `archive_read.py`
- `article_resolver.py`
- `main.py`
- `web_app.py`
- `tests/test_archive_read.py`
- `tests/test_article_resolver.py`
- `tests/test_main.py`
- `tests/test_web_app.py`

## What changed in the adopted result
The adopted result introduced a bounded Web-facing archive-check UI.

Key behavior added:
- a minimal Web page now exists
- the UI accepts article-name or article-URL input
- the UI includes a submit action
- the UI returns a bounded result display
- `main.py` now exposes a bounded Web app entrypoint
- archive-read reuse was extended for Web-facing saved-article summary checks
- local saved-title lookup was added for the archive-check UX
- a bounded case-insensitive local saved-title fallback was added for visitor-
  facing parity such as `G123` / `g123`
- ordinary title-path misses no longer leak RuntimeError as the normal outcome
- no TXT download behavior was added yet
- no enqueue behavior was added yet

The adopted result did not introduce:
- saved → TXT download
- unsaved → enqueue
- auth / account / public-product concerns
- broad frameworkization
- broad resolver redesign
- public runtime / publication packaging
- multi-format export expansion

## Why Copilot was adopted
Primary reasons:

1. It produced the more complete bounded Web skeleton.
   - it added a clearer Web-facing page and route shape
   - it added a bounded `main.py` entrypoint for browser smoke checks
   - it reused archive-read more richly for saved-state reporting

2. It was more review-friendly for the archive-check UX.
   - browser smoke checks were practical on the adopted-side candidate
   - the page exposed saved result details in a bounded, explainable form

3. After narrow follow-up fixes, it met the intended TASK028 UX better.
   - title-input RuntimeError was removed as the normal failure shape
   - local saved-title lookup was added without broadening into TASK029

## Why Cursor was not adopted
Cursor implementation was valid, bounded, and useful as comparison evidence.

Observed strengths:
- very small diff surface
- simple stdlib WSGI shape
- bounded Web loop with focused tests

Reasons it was not selected:
- it remained thinner as a Web-facing archive-check surface
- it exposed less archive-check detail than the adopted result
- once the adopted-side candidate was repaired narrowly, Cursor no longer had
  the stronger overall case for TASK028

## Why Hybrid was not selected
Hybrid was considered, but not selected because:
- Copilot already satisfied the intended TASK028 shape after narrow fixes
- no narrow borrowed Cursor change clearly improved the adopted result enough
  to justify a hybrid
- merge-for-the-sake-of-merge was unnecessary

## Review-path note
Review did not close immediately after the first browser smoke check.

Initial browser observations:
- URL input behaved broadly as expected on both implementations
- title input on both implementations initially failed in practice
- the shared failure shape suggested a common path issue rather than a clean
  differentiator between the two implementations

Because of that:
- TASK028 was intentionally not closed at that point
- Copilot was kept as the provisional adopted-side candidate
- an adopted-side-only diagnostic path was used before final adoption

## Adopted-side-only diagnostic note
A temporary local diagnostic helper path was used on the adopted-side candidate.

Shape of that diagnostic work:
- temporary `front_test/` helpers seeded deterministic local data in
  `copilot/data/`
- no product code was changed by that seed itself
- the purpose was to separate data-shape issues from title-path code issues

What the seeded checks showed:
- URL input could reach saved results
- saved-archive lookup itself was working
- title input was still the remaining problem

Interpretation:
- the remaining issue was in the title-input path / archive-check behavior
- the problem was not primarily that local saved data could not be found

## Follow-up fixes before close-out
The adopted-side candidate then received narrow follow-up fixes before close-out.

### 1. title-path ordinary miss fix
- ordinary title-search 404 behavior was mapped to bounded `not_found`
- unexpected non-404 failures remained internal_error

### 2. local saved-title archive-check fix
- for non-URL input, the Web archive-check path now checks for a locally saved
  title hit before falling back to broader resolution behavior
- this made saved title input behave like the equivalent saved URL input for
  exact local title hits

### 3. bounded case-insensitive local title lookup
- a narrow local title fallback was added for case-insensitive lookup
- this was chosen for visitor-facing parity such as `G123` / `g123`
- fuzzy matching and broader search expansion were intentionally not added

## Browser verification note
Representative adopted-side browser smoke checks succeeded for saved cases such
as:
- article URL input for `g123`
- article URL input for `G123`
- article URL input for the Hetalia article
- article title input for `プロイセン(APヘタリア)`

Additional bounded local title parity handling was implemented for the archive-
check UX.

## Validation result
Validation was run with the established workflow:
- final `./validate_helix.sh` passed for both child repositories

Observed final validation state:
- `copilot`: PASS
- `cursor`: PASS

## Convergence result
- `./compare_helix.sh --all` passed after adoption and synchronization
- `copilot/` and `cursor/` matched on the adopted final state

## Repository outcome
- adopted implementation repository: `copilot`
- comparison-evidence repository: `cursor`
- optional adoption marker branch:
  - `adopted/task028-web-skeleton-frontend`

## Front-check helper note
Temporary front-check helpers were useful during review.

However:
- they were treated as local workflow support
- they were not part of the adopted product diff itself
- they were not required to close TASK028

If browser-smoke helper formalization is desired later, it should be handled as
a separate root-helper improvement rather than by retroactively widening TASK028.

## Notes for future AI sessions
Important interpretation:
- TASK028 is complete
- a bounded Web archive-check UI now exists
- browser smoke checks were used as part of the review path
- title-input behavior required adopted-side-only follow-up fixes before final
  closure
- local saved-title lookup now exists for the archive-check UX
- bounded case-insensitive local title lookup was added
- saved → TXT download and unsaved → enqueue remain for later tasks

## Meta note
This log is AI-readable review memory.
It is not authoritative current state by itself.

Authoritative context should still be restored from:
- `AI_CONTEXT.md`
- `PROJECT_STATE.md`
- `WORKSPACE.md`
- `project_snapshot.txt`


