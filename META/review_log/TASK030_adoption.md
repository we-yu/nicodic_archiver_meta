# TASK030 Adoption Log

## Task
TASK030

Package the existing bounded Web app into a practical single-operator Web
runtime/publication baseline, while keeping target registration text-based and
separating Web-side registration from scheduled scrape execution.

## Decision
Adopted: **Copilot**

Alternative reviewed:
- Cursor implementation was retained as comparison evidence
- A narrow hybrid was considered during review
- Final adopted result uses the Copilot runtime/publication baseline

## Final adopted shape
Changed files:
- `docker-compose.runtime.yml`
- `docs/PERSONAL_RUNTIME.md`
- `main.py`
- `tests/test_main.py`
- `tests/test_web_app.py`
- `web_app.py`

## What changed in the adopted result
The adopted result packaged the existing bounded Web app into a practical
single-operator runtime/publication baseline.

Key behavior added:
- the runtime profile now starts the existing Web app directly
- the runtime profile now publishes the Web app on a host-visible IP:port
- `main.py web` now accepts a bounded target-list-path option
- the runtime profile wires the Web app to the mounted text target list
- Web-side registration now adds only the canonical article URL to the
  existing plain-text target list
- Web-side registration does not enqueue work
- Web-side registration does not trigger immediate scrape execution
- actual scrape execution remains delegated to later periodic or batch runs
- saved article TXT download remains available from the Web UI
- the task remains single-operator-friendly and bounded

The adopted result did not introduce:
- DB source-of-truth migration for targets
- `targets.txt` format changes
- auth / account
- public-abuse policy
- broad deploy / cloud-platform redesign
- queue / scheduler / worker redesign
- rich UI / design-system expansion
- CSV / JSON / MD / HTML implementation

## Why Copilot was adopted
Primary reasons:

1. It matched the TASK030 center more directly.
   - the runtime/publication packaging was more concrete
   - the Web app became directly usable through the runtime profile

2. It made the IP:port access story clearer.
   - compose wiring, runtime startup, and operator-facing docs were more
     explicit and easier to use

3. After adopted-side narrowing, it matched the final meaning more closely.
   - Web-side behavior is limited to bounded validation, target registration,
     and saved TXT download
   - immediate enqueue / immediate scrape is not part of the normal Web flow

4. It remained bounded.
   - target registration stays text-based in this task
   - future DB migration remains possible without forcing it into TASK030

## Why Cursor was not adopted
Cursor implementation was valid and useful as comparison evidence.

Observed strengths:
- clean target-registration seam
- good future-facing shape for later target-storage evolution

Reasons it was not selected:
- the runtime/publication packaging was less concrete than the adopted result
- the adopted Copilot result better expressed the practical single-operator
  Web runtime baseline targeted by TASK030

## Why Hybrid was not selected
A narrow hybrid was considered during review.

However:
- the adopted Copilot runtime/publication baseline already satisfied the task
  well after the adopted-side narrowing
- no additional borrowed Cursor change was necessary to make the adopted
  result valid and explainable
- merge-for-the-sake-of-merge was unnecessary

## Validation result
Validation was run with the established workflow:
- `./validate_helix.sh` passed for both child repositories on the final state

## Convergence result
- `./compare_helix.sh --all` passed after adoption and synchronization
- `copilot/` and `cursor/` matched on the adopted final state

## Repository outcome
- adopted implementation repository: `copilot/`
- comparison-evidence repository: `cursor/`
- optional adoption marker branch:
  - `adopted/task030-web-runtime-beta`
- after product-repo integration, both child repositories were realigned to the
  same adopted final state

## Notes for future AI sessions
Important interpretation:
- TASK030 is complete
- the project now has a bounded single-operator Web runtime/publication
  baseline
- the runtime profile can expose the Web app on a host-visible IP:port
- Web-side registration updates only the plain-text target list in this task
- actual scrape execution remains periodic/batch driven
- target-storage DB migration remains deferred for a later bounded task

## Meta note
This log is AI-readable review memory.
It is not authoritative current state by itself.

Authoritative context should still be restored from:
- `AI_CONTEXT.md`
- `PROJECT_STATE.md`
- `WORKSPACE.md`
- `project_snapshot.txt`


