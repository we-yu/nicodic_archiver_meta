# TASK033 / TASK033B Adoption Log

## Tasks
TASK033 and TASK033B

These two tasks were completed as one continuous adoption sequence.

- TASK033 added bounded human-friendly verification / smoke tooling on top of
  existing seams.
- TASK033B then added a bounded known-good smoke (KGS) helper on top of that
  verification tooling.

In practice, TASK033 was adopted into child-repo `main`, child repositories
were converged, and TASK033B was started immediately after without doing the
root/meta close-out step in between. Therefore this log records the combined
close-out interpretation for TASK033 + TASK033B.

## Decision
Adopted mainline:
- **Copilot**

Alternative reviewed as evidence:
- **Cursor**

Hybrid:
- considered, not selected for close-out

## Combined adopted shape

### TASK033
Added a bounded human-friendly verification / smoke tooling seam for a single
operator.

Core result:
- verification helpers stayed CLI / shell-tooling centered
- existing seams were reused
- verification remained read-first, one-shot, human-readable, and bounded

### TASK033B
Added a bounded known-good smoke (KGS) helper on top of TASK033 verification
tooling.

KGS result:
- manual
- opt-in
- isolated
- non-gating
- KGS-specific helper guidance is stdout-only

## Adopted product result

### TASK033 adopted result
Changed files in the adopted product result included:
- `README.md`
- `main.py`
- `docs/VERIFICATION_TOOLING.md`
- `verification_cli.py`
- `tools/verify.sh`
- `tests/test_main.py`
- `tests/test_verification_cli.py`

### TASK033B adopted result
Changed files in the adopted product result included:
- `README.md`
- `docs/VERIFICATION_TOOLING.md`
- `main.py`
- `tests/test_main.py`
- `tests/test_verification_cli.py`
- `verification_cli.py`

## What changed overall

The adopted result now provides a bounded verification stack with two layers:

### Layer 1: TASK033 verification / smoke baseline
- one-shot verification fetch
- target registry state confirmation
- one-shot batch verification
- telemetry CSV review helper
- human-readable verification documentation
- read-first verification flow

### Layer 2: TASK033B bounded KGS extension
- `verify kgs fetch <canonical_article_url>`
- `verify kgs batch <canonical_article_url>`
- optional isolated state directory
- optional bounded follow-up via `--followup-drop-last N`
- stdout-only KGS helper guidance
- isolated smoke state for KGS usage

## Why Copilot was adopted

### For TASK033
Copilot was adopted because it matched the intended task center more directly:
- it treated verification tooling as a thin, bounded wrapper over existing
  seams
- it preserved the already adopted product shape more cleanly
- it kept verification human-friendly without broadening into a platform

### For TASK033B
Copilot was adopted because it added KGS as a narrow extension of the existing
verification seam:
- KGS stayed manual / opt-in / isolated / non-gating
- KGS-specific helper guidance stayed stdout-only
- the added implementation surface remained small and explainable
- documentation continuity with the adopted TASK033 baseline was stronger

## Why Cursor was not adopted

Cursor implementation was useful and valid comparison evidence across both
tasks.

Observed strengths:
- richer known-good target ergonomics
- stronger KGS target configuration ideas
- explicit `show / smoke / follow-up` split
- clear isolated-state thinking
- bounded follow-up smoke wording was operator-friendly
- `tools/kgs.example.txt` was a useful operator-facing affordance

Reasons it was not selected as the adopted mainline:
- verification tooling broadened more than needed for TASK033 / TASK033B close
- the implementation surface was larger than necessary for the bounded task
  center
- compared with the adopted Copilot line, it moved closer to a verification
  subsystem expansion rather than a narrow bounded extension

## Hybrid decision
Hybrid was considered but not selected for the combined close-out.

Reasoning:
- TASK033 and TASK033B are already valid and complete with the adopted Copilot
  line
- re-opening the adopted branch to borrow Cursor ergonomics at this point would
  blur the adoption boundary
- better handling is to record the useful Cursor ideas explicitly and revisit
  them later only if still needed

## KGS ergonomics borrow list
Useful Cursor-side ideas worth retaining in review memory:

1. configurable known-good target resolution with a clear priority order
   - flag
   - file
   - env

2. an operator-facing KGS template file
   - e.g. `tools/kgs.example.txt`

3. a more explicit KGS command split
   - `show`
   - `smoke`
   - `follow-up`

4. bounded isolated follow-up smoke with especially explicit operator wording

5. human-friendly KGS target visibility before execution
   - showing the chosen target and parsed identity before smoke execution

These were not required for TASK033 / TASK033B completion, but they are good
candidates for a later side-flow or tiny follow-up if operator ergonomics needs
to be improved.

## Validation result
Validation was run with the established workflow:
- `./validate_helix.sh` passed for both child repositories after TASK033
  convergence
- `./validate_helix.sh` also passed for both child repositories on TASK033B
  comparison state
- after adoption and convergence, both child repositories again passed
  validation on converged `main`

## Convergence result
- `./compare_helix.sh --all` passed after TASK033 adoption
- child repositories were converged before TASK033B started
- after TASK033B adoption and synchronization, `./compare_helix.sh --all`
  passed again

## Repository outcome
- adopted implementation repository: `copilot/`
- comparison-evidence repository: `cursor/`
- optional adoption marker branches:
  - `adopted/task033-verification-tooling`
  - `adopted/task033b-kgs-smoke`
- after integration, both child repositories were realigned to the same
  adopted final state

## Notes for future AI sessions
Important interpretation:
- TASK033 is complete
- TASK033B is complete
- the project now has bounded human-friendly verification / smoke tooling
- the project also now has a bounded KGS helper inside that verification
  tooling
- verification remains CLI / shell-tooling first
- verification remains read-first and bounded
- KGS remains manual / opt-in / isolated / non-gating
- KGS-specific helper guidance remains stdout-only
- verification / KGS remain helper layers, not a platform
- richer KGS ergonomics are optional later work, not missing current state

## Meta note
This log is AI-readable review memory.
It is not authoritative current state by itself.

Authoritative context should still be restored from:
- `AI_CONTEXT.md`
- `PROJECT_STATE.md`
- `WORKSPACE.md`
- `project_snapshot.txt`

