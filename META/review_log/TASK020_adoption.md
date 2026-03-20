# TASK020 Adoption Log

## Task
TASK020

Add a bounded provisional personal-use runtime profile and minimal ops docs
without changing product semantics or introducing scheduling packaging.

## Decision
Adopted: Copilot

Alternative reviewed:
- Cursor implementation was retained as comparison evidence
- Hybrid was considered but not selected

## Final adopted shape
Changed files:
- `Dockerfile.runtime`
- `docker-compose.runtime.yml`
- `docs/PERSONAL_RUNTIME.md`
- `runtime/targets/.gitkeep`
- `runtime/data/.gitkeep`
- `runtime/logs/.gitkeep`

The adopted result remained bounded to runtime/profile + ops docs.

## What changed in the adopted result
The adopted result introduced:
- a separate Docker-based runtime profile distinct from development usage
- a long-lived terminal-friendly runtime container
- child-repo-local persistence anchors for:
  - targets
  - SQLite/archive data
  - logs
- minimal runtime operations documentation
- host UID/GID-aware runtime execution guidance for mounted-path writeability
- initial smoke-test guidance for fresh runtime data

No product behavior redesign was introduced.

## Why Copilot was adopted
Primary reasons:

1. It defined a more concrete separate runtime profile.
   - runtime image plus runtime compose profile
   - explicit persistence anchors
   - clearer practical shape for provisional personal-use operation

2. It matched the intended TASK020 scope better.
   - separate runtime/profile
   - minimal ops docs
   - no cron packaging
   - no overlap/lock policy
   - no target-registry migration
   - no Web/API expansion

3. It was validated by practical smoke testing.
   - runtime container build/up/exec/down succeeded
   - one known-good article fetch succeeded
   - `list-articles` confirmed saved output
   - cleanup succeeded after host UID/GID-aware runtime adjustment

## Why Cursor was not adopted
Cursor implementation was valid, bounded, and useful as comparison evidence.

Observed strengths:
- conservative scope
- small file set
- clear minimal compose/doc approach

Reasons it was not selected:
- the adopted Copilot result defined the separate runtime profile more concretely
- persistence layout and runtime shape were easier to review and operate
- the adopted result fit the intended provisional personal-use runtime direction
  more directly

## Why Hybrid was not selected
Hybrid was not selected because no narrow borrowed change clearly improved the
adopted Copilot result enough to justify a hybrid.

## Validation result
- `./validate_helix.sh` passed for both child repositories
- post-adoption validation on converged `main` passed

## Practical runtime verification
Smoke-test verification was performed against the adopted Copilot runtime:
- runtime image build succeeded
- runtime container start succeeded
- batch execution against a known-good target succeeded
- `list-articles` confirmed the saved result
- cleanup after the smoke test succeeded without requiring `sudo chown`
  after host UID/GID-aware runtime handling was introduced

## Convergence result
- `./compare_helix.sh --all` passed after adoption and synchronization
- `copilot/` and `cursor/` matched on the adopted final state

## Repository outcome
- adopted implementation repository: `copilot/`
- comparison-evidence repository: `cursor/`
- optional adoption marker branch:
  - `adopted/task020-runtime-profile`
- the adopted result was integrated into child-repo `main`
- both child repositories were then brought to the same adopted final state
  via `main` pull
- convergence was confirmed on `main`

## Notes for future AI sessions
Important interpretation:
- TASK020 is complete
- the project now has a bounded provisional personal-use runtime profile
- runtime docs exist for build/start/stop/smoke-test/cleanup flow
- runtime/profile remains separate from development usage
- actual cron packaging, overlap/lock policy, and periodic operation packaging
  remain deferred
- those deferred items belong to TASK021 or later

## Meta note
This log is AI-readable review memory.
It is not authoritative current state by itself.

