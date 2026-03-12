# TASK008 Review

## Task
Harden `http_client.py` by clarifying fetch failure boundaries, adding minimal timeout-centered request-boundary protection, and protecting the behavior with focused tests.

## Scope
- `http_client.py`
- `tests/test_http_client.py`

## Non-goals
- parser redesign
- orchestrator redesign
- storage redesign
- cross-layer refactor
- system-wide failure classification design
- scheduler / batch scrape / future workflow work

## Compared implementations

### Copilot
- Added `REQUEST_TIMEOUT_SECONDS = 10`
- Added `requests.get(..., timeout=REQUEST_TIMEOUT_SECONDS)`
- Wrapped `requests.Timeout` as `RuntimeError` with a stable timeout message
- Wrapped other `requests.RequestException` failures as `RuntimeError` while preserving exception class/name details
- Added focused tests for:
  - success path with timeout assertion
  - non-200 status
  - timeout wrapping
  - request-exception wrapping

### Cursor
- Added `DEFAULT_TIMEOUT = 10`
- Added `requests.get(..., timeout=DEFAULT_TIMEOUT)`
- Wrapped `requests.Timeout` as `RuntimeError("... (timeout)")`
- Wrapped other `requests.RequestException` failures as `RuntimeError("... (request error)")`
- Added focused tests for the same boundary areas with more conservative message assertions

## Adoption decision
Adopted: **Copilot**

## Why Copilot was adopted
- Stayed fully within the bounded `http_client.py` fetch-layer scope
- Added minimal timeout-centered request-boundary protection
- Preserved more failure-detail information for request exceptions
- Produced a slightly stronger production hardening result while still remaining conservative
- Final validated result passed all normal checks

## Why Cursor was not adopted
- Cursor was valid, bounded, and conservative
- However, its request-exception handling was more abstract (`request error`) and preserved less immediate diagnostic detail
- For TASK008, Copilot provided the more informative hardening while still staying within scope

## Why hybrid was not selected
- Both implementations were already close in scope and shape
- A hybrid merge would add unnecessary integration work without clear additional benefit
- Copilot alone was sufficient as the adopted final result

## Validation result
- `./validate_helix.sh` passed for both `copilot/` and `cursor/`
- Final post-adoption validation also passed for both child repositories on `main`

## Convergence result
- `./compare_helix.sh --all` passed after realignment
- `copilot/` and `cursor/` were confirmed to match on the post-adoption baseline

## Review notes
- Initial Copilot validation failure was due to minor submission-quality issues in the new test file
- During manual correction, a temporary file-target mistake caused test code to be pasted into `http_client.py`
- That temporary accident was corrected before final review
- The adoption decision was made based on the corrected implementation substance, not on the temporary manual-fix accident

## Final state
- TASK008 complete
- Both child repositories converged to the adopted final state
- Next task not yet fixed

