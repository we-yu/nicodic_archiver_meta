# TASK011 Review

## Task
Introduce bounded high-volume handling in `orchestrator.py` by:
- explicitly skipping known high-volume articles with a denylist, and
- applying a fixed response cap to unknown high-volume articles,
while preserving the current architecture and protecting the behavior with
focused tests.

## Scope
- `orchestrator.py`
- `tests/test_orchestrator.py`

## Non-goals
- parser redesign
- storage redesign
- http_client redesign
- retry / backoff design
- full failure-classification design
- scheduler / batch scrape expansion
- external config / blacklist file design
- CLI option / env var design
- cross-layer abstraction

## Compared implementations

### Copilot
- added fixed high-volume policy constants in `orchestrator.py`
- skipped known high-volume article IDs before collection / save flow
- extended `collect_all_responses()` to return:
  - responses
  - interrupted
  - capped
- applied a fixed response cap while preserving partial-save behavior
- added focused tests for:
  - cap reached
  - denylist skip
  - capped save-path behavior

### Cursor
- added fixed high-volume policy constants in `orchestrator.py`
- used a denylist seed with an explicit temporary-comment marker
- skipped known high-volume article IDs before collection / save flow
- extended `collect_all_responses()` to return:
  - responses
  - interrupted
  - cap_reached
- applied a fixed response cap while preserving partial-save behavior
- added focused tests for:
  - cap reached
  - denylist skip
  - capped save-path behavior

## Adoption decision
Adopted: **Cursor**

## Why this result was selected
- stayed fully within the bounded `orchestrator.py` task scope
- expressed the high-volume policy semantics more clearly
- kept denylist skip, cap reached, interruption, and empty-result handling
  easier to distinguish in both code and output
- preserved partial-save behavior under cap reached
- remained conservative and production-facing

## Why Copilot was not adopted directly
- Copilot was valid, bounded, and reviewable
- however, Cursor presented the denylist / cap / normal-flow distinction
  slightly more clearly
- no strong enough Copilot-specific advantage was found to justify either
  direct adoption or a mandatory hybrid

## Why hybrid was not selected
- unlike TASK010, no narrow borrowed change clearly improved the Cursor result
  enough to justify a hybrid
- merge-for-the-sake-of-merge was unnecessary
- Cursor alone already satisfied the task well

## Validation result
- `./validate_helix.sh` passed for both `copilot/` and `cursor/`
- post-adoption validation on `main` also passed for both child repositories

## Convergence result
- `./compare_helix.sh --all` passed after realignment
- `copilot/` and `cursor/` were confirmed to match on the adopted final state

## Final state
- TASK011 adopted result: Cursor
- `orchestrator.py` now includes:
  - denylist-based skip for known high-volume articles
  - fixed response cap handling for unknown high-volume articles
- denylist hits do not enter the save path
- cap reached results are saved as partial results
- focused tests protect the new high-volume policy behavior


