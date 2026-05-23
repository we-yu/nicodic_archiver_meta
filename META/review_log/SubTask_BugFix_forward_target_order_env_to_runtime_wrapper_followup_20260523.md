# SubTask-BugFix: forward target order env to runtime wrapper follow-up

## Summary

SubTask-BugFix-forward-target-order-env-to-runtime-wrapper-followup was
completed.

This follow-up fixed the remaining runtime target-order wrapper issue where an
empty TARGET_ORDER_START_ARTICLE_ID was treated as an explicit invalid start
override.

## Background

The first wrapper fix made TARGET_ORDER_MODE and TARGET_ORDER_START_ARTICLE_ID
reach the container periodic-once process.

Runtime smoke then revealed a remaining issue:

- TARGET_ORDER_MODE=reverse reached the container
- but empty TARGET_ORDER_START_ARTICLE_ID was also forwarded
- the empty value was treated as invalid_start_article_id
- the run fell back to default order

## Adopted behavior

- Empty or whitespace-only TARGET_ORDER_START_ARTICLE_ID is treated as absent.
- TARGET_ORDER_MODE=reverse remains effective when no start article override is
  provided.
- TARGET_ORDER_MODE=random_rotation remains effective when no start article
  override is provided.
- Non-empty invalid start article id still falls back to default.
- Valid stored article_id override still works.

## Runtime branch smoke

Runtime branch smoke was performed before PR merge.

Observed successful target-order log lines:

- TARGET_ORDER_MODE=reverse produced effective=reverse.
- TARGET_ORDER_MODE=random_rotation produced effective=random_rotation.
- TARGET_ORDER_START_ARTICLE_ID=5400838 produced effective=start_article_id.

This confirmed that article_id and list index are not being confused:

- start_article_id=5400838 is the stored Nicopedia article_id.
- start_index=12192 is the target list offset.

## Files touched

- target_ordering.py
- tests/test_target_ordering.py
- SubTask-BugFix-forward-target-order-env-to-runtime-wrapper_report.txt

Earlier wrapper fix files remained part of the overall bugfix context:

- tools/runtime_env.sh
- runtime/periodic_once.sh
- tests/test_runtime_local_ops.py
- docs/PERSONAL_RUNTIME.md

## Validation

Reported validation before adoption:

- focused target-order/runtime wrapper tests: 22 passed
- full child repo pytest: 442 passed
- flake8: no output

After merge, child repos should be synced to main and validate_helix.sh should
be rerun.

## Runtime status

After merge, runtime should be returned from detached branch-smoke HEAD to
official main and rebuilt/recreated through the standard runtime reflection
flow.

Final smoke should confirm:

- effective=reverse
- effective=random_rotation
- effective=start_article_id

## Non-goals

This task intentionally did not introduce:

- crontab changes
- scheduling policy changes
- Docker compose topology changes
- DB/schema changes
- scrape semantics changes
- target ordering algorithm changes
- Delete Feeder behavior changes
- persistent resume cursor
- scrape_id / run mark
