# SUBTASK003 Batch Log Readability

## Task
SUBTASK003

Improve `batch_*.log` readability in bounded form so that a single batch run is
easier to inspect by humans without changing existing batch semantics.

## Positioning
This is a bounded subtask on top of the adopted batch / periodic / verification
baseline.

It is not a new product-semantics task family expansion.

It is specifically a bounded readability / operator-readout improvement for
`batch_*.log`.

Important boundary:
- `batch_*.log` is the product-side batch run log
- `host_cron.log` remains the host/runtime operations log
- this subtask does not redefine `host_cron.log`

## Background
Before this subtask, `batch_*.log` already existed as a bounded text-log layer,
but the readability was still weak for practical single-run inspection.

Observed needs were:

- make one target-processing unit easier to recognize visually
- improve success-side minimal visibility for human verification
- improve failure-side investigation starting information
- improve end-summary readability
- keep the task within text-log readability rather than widening into an
  observability platform

## What changed
Changed files in the adopted product result:
- `main.py`
- `orchestrator.py`
- `tests/test_main.py`

Added / changed behavior:
- `batch_*.log` now has clearer run start formatting
- each target is now represented as a readable progress block using:
  - `[PROGRESS = X/Y]`
- success progress now includes bounded minimal verification fields:
  - `result`
  - `target_url`
  - `article_title`
  - `collected_response_count`
  - `observed_max_res_no`
- failure progress now includes the same minimal per-target fields plus a
  bounded `FAILURE_DETAIL` block
- failure detail now includes bounded investigation-start information:
  - `progress`
  - `target_url`
  - `article_title`
  - `failure_page`
  - `failure_cause`
  - `collected_response_count`
  - `observed_max_res_no`
  - `short_reason`
- end summary now includes:
  - `duration_seconds`
  - `success_targets`
  - `failed_targets`
  - `final_status`

## What did not change
The subtask remained bounded and did not expand into:
- `host_cron.log` redesign
- telemetry / CSV redesign
- DB schema redesign
- queue / scheduler redesign
- Web semantics redesign
- observability / dashboard platform work
- destructive maintenance tooling

Existing batch semantics were preserved:
- batch success / failure judgment was not redesigned
- batch execution order was not redesigned
- text-log output remained the medium
- the task did not introduce structured JSON logging or a DB-backed log layer

## Validation summary
The following validation / review path was completed:

1. bounded implementation review on the Copilot side
2. `./validate_helix.sh` passed
3. child-repo `main` merge was completed
4. both child repositories were realigned to merged `main`
5. `./compare_helix.sh --all` passed after synchronization
6. post-merge `./validate_helix.sh` passed on converged `main`
7. `bash ./copilot/tools/kgs_dual_smoke.sh` passed
8. direct batch-log probe on known-good smoke state confirmed the new readable
   success-side log shape

## Direct log observation note
A direct `batch_*.log` probe was performed against isolated known-good smoke
state after adoption.

Representative confirmed shape included:
- `BATCH_RUN_START`
- `[PROGRESS = 1/1]`
- `result=SUCCESS`
- `target_url=...`
- `article_title=...`
- `collected_response_count=...`
- `observed_max_res_no=...`
- `BATCH_RUN_END`
- `duration_seconds=...`
- `success_targets=...`
- `failed_targets=...`
- `final_status=success`

Because the direct probe target was known-good, this observation confirmed the
success-side readability shape directly.

Failure-detail practical shape remains protected by focused tests in
`tests/test_main.py`.

## Repository outcome
- the sideflow result was adopted into child-repo `main`
- both `copilot/` and `cursor/` were realigned to the same merged `main`
- convergence and post-merge validation were confirmed

## Interpretation
Current batch-log baseline should now be read as including:

- readable run start formatting
- per-target progress blocks
- bounded minimal success-side visibility
- bounded failure-side investigation detail
- readable end summary with duration and counts

Important boundary:
- `batch_*.log` is still a bounded text-log layer
- `host_cron.log` remains a distinct host/runtime log layer
- this subtask does not widen logging into an observability platform

## Meta note
This log is AI-readable review memory.
It is not authoritative current state by itself.

Authoritative context should still be restored from:
- `AI_CONTEXT.md`
- `PROJECT_STATE.md`
- `WORKSPACE.md`
- `project_snapshot.txt`


