# TASK024 Adoption Log

## Task
TASK024

Add a bounded article input resolution seam that accepts either
a full article top URL or a full article title and resolves that input
into a reusable canonical article target, while keeping the task pre-Web,
pre-queue, and limited to a thin operator-facing entry.

## Decision
Adopted: **Copilot**

Alternative reviewed:
- Cursor implementation was retained as comparison evidence
- Hybrid was considered but not selected

## Final adopted shape
Changed files:
- `article_resolver.py`
- `main.py`
- `tests/test_article_resolver.py`
- `tests/test_main.py`

## What changed in the adopted result
The adopted result introduced a bounded article input resolution seam.

Key behavior added:
- accepts one user-provided input in either of these forms:
  - full article top URL
  - full article title
- resolves input into a canonical target containing:
  - `article_url`
  - `article_id`
  - `article_type`
- returns a success result envelope containing:
  - `title`
  - `matched_by`
  - `normalized_input`
- keeps failure taxonomy bounded to:
  - `invalid_input`
  - `not_found`
  - `ambiguous`
- keeps title-input resolution bounded to:
  - first-page-only search handling
  - exact-title matching only
- adds a minimal operator-facing CLI entry:
  - `resolve-article`
- keeps the operator-facing entry as a thin wrapper over the same resolver path

The adopted result remained pre-Web / pre-queue and did not introduce:
- Web UI / Web routes
- queue persistence / queue drain
- export format expansion
- scheduler framework changes
- storage schema redesign
- target-registry redesign

## Why Copilot was adopted
Primary reasons:

1. It matched the TASK024 definition more directly.
   - canonical target and result envelope were separated clearly
   - `title` remained a meaningful success-envelope field rather than a fallback input echo

2. It kept the title-input method bounded while still producing a more useful resolved result.
   - first-page-only
   - exact-title-only
   - final target was resolved through the common URL path

3. The minimal operator-facing entry stayed thin and task-aligned.
   - `main.py` only gained a bounded `resolve-article` wrapper
   - existing scrape / archive-read / runtime responsibilities were preserved

4. It preserved boundedness well.
   - no Web / queue / scheduler / storage redesign drift
   - no broad neighboring refactor

## Why Cursor was not adopted
Cursor implementation was valid, bounded, and useful as comparison evidence.

Observed strengths:
- conservative scope
- first-page-only exact-title handling remained bounded
- thin wrapper shape was preserved
- final validation passed

Reasons it was not selected:
- the success-envelope handling was slightly weaker for URL-based success
- compared with Copilot, the adopted result provided a more useful and more task-faithful resolved result without widening scope

## Why Hybrid was not selected
Hybrid was considered, but not selected because:
- Copilot already satisfied the intended TASK024 boundary well on its own
- no narrow borrowed Cursor adjustment clearly improved the adopted result enough to justify a hybrid
- merge-for-the-sake-of-merge was unnecessary
- keeping the review memory simple is preferable

## Validation result
Validation was run with the established workflow:
- initial Copilot validation failed only due to missing trailing newline at EOF in touched files
- that localized submission-quality issue was corrected immediately
- final `./validate_helix.sh` passed for both child repositories

## Convergence result
- `./compare_helix.sh --all` passed after adoption and synchronization
- `copilot/` and `cursor/` matched on the adopted final state

## Repository outcome
- adopted implementation repository: `copilot/`
- comparison-evidence repository: `cursor/`
- optional adoption marker branch may be used as:
  - `adopted/task024-article-input-resolution`
- after product-repo integration, both child repositories were realigned to the same adopted final state

## Notes for future AI sessions
Important interpretation:
- TASK024 is complete
- the project now has a bounded article input resolution seam
- a minimal operator-facing `resolve-article` entry exists as a thin wrapper
- title-input resolution remains bounded and pre-search-platform
- the task remains pre-Web / pre-queue
- future work may build on this seam, but should not retroactively widen TASK024

## Meta note
This log is AI-readable review memory.
It is not authoritative current state by itself.

Authoritative context should still be restored from:
- `AI_CONTEXT.md`
- `PROJECT_STATE.md`
- `WORKSPACE.md`
- `project_snapshot.txt`


