# SUBTASK006 Delete Request Feeder Hardening

## Task
SUBTASK006

Harden the bounded delete-request feeder so malformed candidates and
candidate-level resolution / fetch / registration failures do not abort the
whole batch / periodic shot.

## Positioning
This is a bounded corrective subtask on top of the adopted TASK036 feeder
baseline.

It is not a scheduler redesign, queue redesign, runtime publication redesign,
or logging-platform task.

## Adopted result
Adopted: Copilot

Comparison status:
- Copilot implementation was adopted
- Cursor implementation was reviewed but not adopted

## Why Copilot was adopted
Primary reasons:
- stronger bounded candidate sanitize behavior
- clearer summary counters for practical runtime reading
- better separation between invalid candidates, resolution failures, and
  registration failures
- runtime-like direct checks confirmed the intended sanitize behavior against
  CR/LF-contaminated URL input
- validate passed

## Why Cursor was not adopted
Cursor also implemented bounded hardening successfully, but its summary naming
and failure bucket semantics were less precise for practical runtime reading.
In particular, the adopted Copilot version better matched the intended
interpretation of:
- invalid candidate skip
- resolver failure skip
- registration failure skip

## What changed
Changed files in the adopted implementation:
- `delete_request_feeder.py`
- `tests/test_delete_request_feeder.py`

Main adopted behavior:
- candidate sanitize was strengthened
- surrounding whitespace is stripped
- embedded CR/LF and obvious control contamination are removed
- percent-encoded control contamination is removed
- sanitize runs both:
  - after normalization during scan
  - again at handoff time for bounded self-heal of already-dirty candidates
- malformed / empty candidates are skipped without aborting the feeder run
- candidate-level resolver failures no longer abort the whole run
- candidate-level registration failures no longer abort the whole run
- whole batch / periodic shot no longer needs to fail because of one bad
  delete-request candidate

## Summary visibility
Normal runtime logging remains tiny-summary only.

Bounded summary visibility was expanded with:
- `processed_candidates`
- `registered_candidates`
- `skipped_invalid_candidates`
- `skipped_resolution_failures`
- `skipped_registration_failures`

## Practical validation summary
Validation and review path completed:
1. Copilot and Cursor implementations were compared
2. both child repos passed validate
3. Copilot runtime-like temporary container check was performed
4. direct sanitize check confirmed CR/LF-contaminated URL cleanup
5. summary formatting check confirmed the added bounded counters
6. no GUI review was needed for this subtask

## What did not change
This subtask did not introduce:
- heavy debug logging platform
- `log_AIanalyze`
- DB-wide cleanup framework
- scheduler redesign
- queue redesign
- runtime / nginx / ops redesign
- Web UI changes

## Interpretation
Current feeder baseline should now be read as including:
- bounded candidate sanitize hardening
- bounded self-heal on already-dirty candidate input at handoff time
- candidate-level resolver failure containment
- candidate-level registration failure containment
- tiny-summary runtime visibility for skip/failure counts

## Repository outcome
- adopted implementation branch:
  `task006-delete-request-feeder-hardening-copilot`
- adopted result was integrated into child-repo `main`
- both child repositories were then realigned to the same adopted final state
- sibling runtime checkout should also be reflected as part of practical
  closeout

## Meta note
This log is AI-readable review memory.
It is not authoritative current state by itself.

Authoritative restore still depends on:
- `AI_CONTEXT.md`
- `PROJECT_STATE.md`
- `WORKSPACE.md`
- `project_snapshot.txt`

