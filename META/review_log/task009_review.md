# TASK009 Review

## Task
Harden `orchestrator.py` so that article-not-found and no-BBS / zero-response cases are handled explicitly and consistently at the scrape-flow level, with focused tests protecting the behavior.

## Scope
- `orchestrator.py`
- `tests/test_orchestrator.py`

## Non-goals
- large-thread cutoff / block policy
- malicious content sanitization policy
- parser redesign
- storage redesign
- full failure-classification design
- scheduler / batch scrape / target-list work

## Compared implementations

### Copilot
- Introduced `ArticleNotFoundError` for orchestration-local article-not-found handling
- Treated article page 404 and missing `og:url` as article-not-found outcomes
- Treated BBS first-page 404 as no-BBS and returned an empty response list
- Kept non-404 first-page failures distinct from empty-result handling
- Saved empty results explicitly when responses were empty
- Added focused tests for:
  - article metadata not found
  - article page 404
  - BBS first-page 404 as no-BBS
  - first-page non-404 failure propagation
  - article-not-found save-path skip
  - zero-response empty-result save behavior

### Cursor
- Added explicit article-not-found handling in `run_scrape`
- Added explicit empty-result logging for `responses == []`
- Kept the implementation smaller and more conservative
- Added focused tests around article-not-found early return and empty-result save behavior

## Adoption decision
Adopted: **Copilot**

## Why Copilot was adopted
- Stayed within the bounded orchestration-flow scope
- Provided stronger explicit handling for article-not-found cases
- More clearly separated no-BBS / zero-response from generic failure paths
- Added focused protection for the intended edge-case behavior
- Final validated result passed all checks
- A simple real-sample verification also confirmed basic runtime behavior was maintained

## Why Cursor was not adopted
- Cursor was valid, bounded, and conservative
- However, its implementation handled fewer representative edge cases
- Copilot made the scrape-flow distinction between article-not-found, empty-result, and generic failure more explicit

## Why hybrid was not selected
- Both implementations were close in direction
- Copilot already covered the preferred behavior without needing additional integration work
- A hybrid would add complexity without enough extra benefit

## Validation result
- `./validate_helix.sh` passed for both `copilot/` and `cursor/`
- Copilot initially failed due to a small print-call shape mismatch in a focused test expectation
- That issue was corrected without changing task scope or implementation intent
- Final validation passed for both child repositories

## Convergence result
- `./compare_helix.sh --all` passed after realignment
- `copilot/` and `cursor/` were confirmed to match on the post-adoption baseline

## Review notes
- Copilot initially produced a small submission-quality mismatch around the article-not-found print shape
- The issue was localized and corrected without widening scope
- The adoption decision was made on the corrected implementation substance
- TASK009 remains a bounded orchestration hardening task, not a redesign task

## Final state
- TASK009 adopted result: Copilot
- Both child repositories should be realigned to the adopted final state
- Next task not yet fixed

