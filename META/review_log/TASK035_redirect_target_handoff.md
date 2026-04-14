# TASK035 Redirect target handoff

## Task
TASK035

Detect redirect articles during scrape, stop repeated failure of old targets,
and hand off collection to redirected canonical targets in a bounded way.

## Positioning
This is a bounded mainline scrape/runtime task.

It changes:
- redirect detection during article fetch
- target registry state for redirected targets
- bounded target handoff behavior during batch handling

It does not change:
- archive read semantics
- archive migration/merge behavior
- queue/scheduler design
- broad DB platform design

## What changed
Adopted result from Copilot sideflow:
- `main.py`
- `orchestrator.py`
- `storage.py`
- `target_list.py`
- `tests/test_main.py`
- `tests/test_orchestrator.py`
- `tests/test_storage.py`
- `tests/test_target_list.py`

Main adopted behavior:
- redirect article pages are no longer treated as plain article_not_found
- redirect signals are detected from article HTML
- at minimum:
  - `meta http-equiv="refresh"`
  - `location.replace(...)`
  are handled
- redirect source target is marked redirected and deactivated
- redirect target URL is registered into the target registry with duplicate
  suppression
- redirect handoff is treated as success-class in batch execution
- batch log now includes a bounded `REDIRECT_DETAIL` block
- archive migration/merge is not performed
- old and new article identities remain separate in saved archive data

## What did not change
This task did not change:
- archive save/read identity rules
- old archive data ownership
- Web download semantics as a unified canonical redirect layer
- scheduler/queue platform shape
- broad observability or redirect graph tooling

## Validation summary
The following validation path was completed:

1. Double Helix implementation was attempted in both child repositories
2. Both Copilot and Cursor reached validate PASS
3. Design comparison was completed after validation
4. Copilot result was adopted
5. Cursor result was preserved as non-adopted comparison evidence
6. child repo mains were re-synchronized after adoption
7. runtime sibling checkout was updated from adopted main

## Interpretation
Current mainline scrape/runtime behavior should now be read as including:
- bounded redirect article detection
- bounded redirect target handoff into registry
- redirected old target deactivation
- no archive migration across redirect identities

## Meta note
This review log is AI-readable working memory.
It is not authoritative by itself.

Authoritative current state should still be restored from:
- `AI_CONTEXT.md`
- `_AI_RULES.md`
- `PROJECT_STATE.md`
- `WORKSPACE.md`
- `project_snapshot.txt`
