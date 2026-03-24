# PROJECT STATE

Current stage of development.

--------------------------------------------------

PROJECT

nicodic_archiver

--------------------------------------------------

ENVIRONMENT

Docker based development

Python 3.12
requests
beautifulsoup4
lxml

pytest
flake8

--------------------------------------------------

WORKSPACE STRUCTURE

workspace
  copilot/
  cursor/

Both are independent git repositories.

--------------------------------------------------

CURRENT STATUS

Environment setup complete.

Docker build works.
pytest works.
flake8 works.

TASK001 has been completed.

TASK001 result:

• Copilot implementation was adopted
• Cursor implementation was retained for comparison
• Both repositories were later aligned again at the same code state

TASK002 has been completed.

TASK002 result:

• Copilot implementation was adopted
• Cursor implementation was retained for comparison
• Both repositories were later aligned again at the same code state
• main.py was reduced to a CLI-focused entrypoint
• orchestration logic was moved to orchestrator.py

TASK003 has been completed.

TASK003 result:

• Cursor implementation was adopted
• Copilot implementation was retained for comparison
• Both repositories were later aligned again at the same code state
• minimal unit tests were added for main.py and orchestrator.py
• tests/conftest.py was added for pytest import-path support
• production code remained unchanged

TASK004 has been completed.

TASK004 result:

• focused parser tests were added
• parser behavior protection was strengthened without changing production code
• both repositories were later aligned again at the same code state

TASK005 has been completed.

TASK005 result:

• root workflow helper scripts were added
• new_task_branches.sh was added as a root helper wrapper
• validate_helix.sh was added as a root helper wrapper
• collect_task_review.sh was added as a root helper wrapper
• helper script implementations were added under META/scripts/
• WORKSPACE.md was updated to reflect the workflow additions
• META/README.md was updated to reflect the workflow additions
• snapshot regeneration has already been performed

TASK006 has been completed.

TASK006 result:

• Cursor-based hybrid adoption was selected
• Copilot contributed the fixed-time `collected_at` verification idea
• `tests/test_storage.py` was added
• production code remained unchanged
• both repositories were realigned again at the same code state
• snapshot regeneration has already been performed

TASK007 has been completed.

TASK007 result:

• Cursor implementation was adopted
• Copilot implementation was retained for comparison evidence
• `tests/test_orchestrator.py` was expanded to protect orchestration flow more broadly
• production code remained unchanged
• both repositories were realigned again at the same code state
• snapshot regeneration has already been performed

TASK008 has been completed.

TASK008 result:

• Copilot implementation was adopted
• Cursor implementation was retained for comparison evidence
• `http_client.py` was hardened within the HTTP fetch layer
• minimal timeout-centered request-boundary protection was added
• `tests/test_http_client.py` was added
• both repositories were realigned again at the same code state
• convergence was confirmed with `./compare_helix.sh --all`
• post-adoption validation passed in both repositories

TASK009 has been completed.

TASK009 result:

• Copilot implementation was adopted
• Cursor implementation was retained for comparison evidence
• `orchestrator.py` was hardened to handle article-not-found and no-BBS / zero-response cases more explicitly
• `tests/test_orchestrator.py` was expanded to protect the new edge-case behavior
• both repositories were realigned again at the same code state
• convergence was confirmed with `./compare_helix.sh --all`
• post-adoption validation passed in both repositories

TASK010 has been completed.

TASK010 result:

• Cursor-based minimal hybrid adoption was selected
• Copilot contributed the later-page interruption page-level observability line
• `orchestrator.py` was hardened to distinguish later-page interruption from empty-result handling
• partial responses are now preserved and saved when later-page interruption occurs
• `tests/test_orchestrator.py` was expanded to protect the new interruption-handling behavior
• both repositories were realigned again at the same code state
• convergence was confirmed with `./compare_helix.sh --all`
• post-adoption validation passed in both repositories

TASK011 has been completed.

TASK011 result:

• Cursor implementation was adopted
• `orchestrator.py` was hardened with bounded high-volume handling policy
• known high-volume article IDs are now skipped before collection and save flow
• a fixed response cap was added for unknown high-volume articles
• capped results are preserved and saved as partial results
• `tests/test_orchestrator.py` was expanded to protect the new high-volume policy behavior
• both repositories were realigned again at the same code state
• convergence was confirmed with `./compare_helix.sh --all`
• post-adoption validation passed in both repositories

TASK012 has been completed.

TASK012 result:

• Copilot implementation was adopted
• `tests/test_orchestrator.py` was strengthened with representative regression coverage for the already-adopted single-article scrape path
• representative save-path behavior is now more explicitly protected for:
  - normal save path
  - no-BBS / zero-response empty-result save path
  - later-page interruption partial-save path
  - response-cap reached partial-save path
• representative skip-path behavior is now more explicitly protected for:
  - article-not-found
  - known high-volume skip
• production code remained unchanged
• both repositories were realigned again at the same code state
• convergence was confirmed with `./compare_helix.sh --all`
• post-adoption validation passed in both repositories

TASK013 has been completed.

TASK013 result:

• Copilot implementation was adopted
• a provisional plain-text file-based target source was introduced
• `target_list.py` was added to provide bounded target-list loading
• `main.py` gained a bounded CLI/application entry for target-list loading
• `tests/test_target_list.py` was added
• `tests/test_main.py` was updated to protect the new bounded entry behavior
• batch scrape behavior was not introduced
• production changes remained limited to bounded functional expansion for target loading
• both repositories were realigned again at the same code state
• convergence was confirmed with `./compare_helix.sh --all`
• post-adoption validation passed in both repositories

TASK014 has been completed.

TASK014 result:

• Cursor implementation was adopted
• Copilot implementation was retained for comparison evidence
• a bounded batch scrape command was added using the target list
• batch execution remains serial and CLI-centered
• existing single-article scrape flow is reused for each target
• continue-on-error behavior was added at the batch layer
• final non-zero exit is returned when any target fails
• target-level success / failure visibility was added to CLI output
• single-article save semantics were not redesigned
• `main.py` was updated
• `orchestrator.py` was minimally extended to support batch-facing success signaling
• `tests/test_main.py` and `tests/test_orchestrator.py` were updated
• both repositories were realigned again at the same code state
• convergence was confirmed with `./compare_helix.sh --all`
• post-adoption validation passed in both repositories

TASK015 has been completed.

TASK015 result:

• Cursor implementation was adopted
• Copilot implementation was retained for comparison evidence
• minimal batch-run logging / status recording was added
• logging is batch-only
• run logs are stored as text `.log` files
• each batch run records:
  - a start marker
  - an end summary
  - failure-only detail entries
• success targets are not individually persisted in run logs
• final status is recorded as:
  - `success`
  - `partial_failure`
  - `failure`
• `main.py` was updated
• `tests/test_main.py` was updated
• no parser / storage / http_client redesign was introduced
• no scheduler / overlap / retry-backoff expansion was introduced
• both repositories were realigned again at the same code state
• convergence was confirmed with `./compare_helix.sh --all`
• post-adoption validation passed in both repositories

TASK016 has been completed.

TASK016 result:

• Copilot implementation was adopted
• Cursor implementation was retained for comparison evidence
• a bounded periodic execution entrypoint was added
• periodic execution remains CLI-centered
• one periodic cycle processes the full target list once
• existing batch scrape behavior is reused for each cycle
• existing batch run logging is reused as-is
• periodic-specific logging format was not added
• interval is provided by CLI argument
• optional `--max-runs` is supported
• cycle-level `partial_failure` / `failure` does not stop later cycles
• safe `Ctrl+C` exit handling was added
• `main.py` was updated
• `tests/test_main.py` was updated
• no parser / storage / http_client redesign was introduced
• no scheduler / overlap / retry-backoff / fairness / deployment expansion was introduced
• both repositories were realigned again at the same code state
• convergence was confirmed with `./compare_helix.sh --all`
• post-adoption validation passed in both repositories

TASK017 has been completed.

TASK017 result:

• Copilot implementation was adopted
• Cursor implementation was retained for comparison evidence
• a bounded archive export / readout command was added
• export remains CLI-centered and stdout-centered
• one saved article is exported at a time
• target selection uses `article_id + article_type`
• supported export formats are `txt` and `md`
• `cli.py` was updated
• `main.py` was updated
• `tests/test_main.py` was updated
• `tests/test_cli.py` was added
• no parser / storage / http_client redesign was introduced
• no Web UI / API / CSV / multi-article export expansion was introduced
• both repositories were realigned again at the same code state
• convergence was confirmed with `./compare_helix.sh --all`
• post-adoption validation passed in both repositories

TASK018 has been completed.

TASK018 result:

• Copilot implementation was adopted
• Cursor implementation was retained for comparison evidence
• a bounded add-target intake command was added
• target intake remains file/CLI-based
• one target is added at a time
• the plain-text target list remains the source of truth
• exact duplicate targets are not added
• minimal syntax validation is performed
• online existence check was not introduced
• `main.py` was updated
• `target_list.py` was updated
• `tests/test_main.py` was updated
• `tests/test_target_list.py` was updated
• no parser / storage / http_client redesign was introduced
• no queue / DB-backed registry / Web / API expansion was introduced
• both repositories were realigned again at the same code state
• convergence was confirmed with `./compare_helix.sh --all`
• post-adoption validation passed in both repositories

TASK019 has been completed.

TASK019 result:

• Copilot implementation was adopted
• Cursor implementation was retained for comparison evidence
• a bounded whole-archive archive-read path was added
• archive listing was added as the core capability
• all-articles export was added as a paired bounded capability
• archive readout remains CLI-centered
• whole-archive export remains stdout-centered
• listing includes:
  - `article_id`
  - `article_type`
  - `title`
  - `created_at`
  - `response_count`
• whole-archive export format is `txt` only in this task
• export output is article-by-article and sectioned
• existing single-article export remains available
• `cli.py` was updated
• `main.py` was updated
• `tests/test_main.py` was updated
• `tests/test_cli.py` was updated
• no parser / storage / http_client / orchestrator redesign was introduced
• no storage schema redesign was introduced
• no file-output expansion was introduced
• no Web UI / API / CSV / multi-format whole-archive expansion was introduced
• both repositories now reflect the same adopted final state on `main`
• convergence was confirmed with `./compare_helix.sh --all`
• post-adoption validation passed in both repositories

TASK020 has been completed.

TASK020 result:

• Copilot implementation was adopted
• Cursor implementation was retained for comparison evidence
• a bounded provisional personal-use runtime profile was added
• minimal runtime operations documentation was added
• the runtime profile remains separate from development usage
• the runtime profile remains Docker/Compose-centered and terminal-friendly
• child-repo-local persistence anchors were introduced for:
  - targets
  - SQLite / archive data
  - logs
• host UID/GID-aware runtime handling guidance was added
• an initial smoke-test flow was documented
• product semantics were not changed
• no cron packaging was introduced
• no overlap / lock policy was introduced
• no target-registry migration was introduced
• no Web / API / orchestration-platform expansion was introduced
• both repositories now reflect the same adopted final state on `main`
• convergence was confirmed with `./compare_helix.sh --all`
• post-adoption validation passed in both repositories

TASK021 has been completed.

TASK021 result:

• Copilot implementation was adopted
• Cursor implementation was retained for comparison evidence
• a bounded periodic operation packaging path was added for the provisional personal-use runtime
• the existing periodic execution entrypoint is now practical to run through a host-side one-shot wrapper
• simple lock + skip overlap handling was added in bounded form
• the plain-text target list remains the source of truth
• runtime operations documentation was extended
• a dedicated smoke-test helper was not added
• container-internal cron was not introduced
• no scheduler framework / advanced overlap-fairness policy was introduced
• no target-registry migration was introduced
• no Web / API expansion was introduced
• both repositories now reflect the same adopted final state on `main`
• convergence was confirmed with `./compare_helix.sh --all`
• post-adoption validation passed in both repositories

TASK022 has been completed.

TASK022 result:

• Copilot implementation was adopted
• Cursor implementation was retained for comparison evidence
• a bounded archive read / export seam was added
• archive-facing read responsibilities were moved out of `cli.py` into `archive_read.py`
• `cli.py` remains responsible for CLI formatting and stdout emission
• existing single-article export behavior was preserved
• existing whole-archive listing / export behavior was preserved
• the task remained pre-Web / pre-API
• no target-registry redesign was introduced
• no storage schema redesign was introduced
• no archive-write redesign was introduced
• no Web / API expansion was introduced
• both repositories now reflect the same adopted final state on `main`
• convergence was confirmed with `./compare_helix.sh --all`
• post-adoption validation passed in both repositories

TASK023 has been completed.

TASK023 result:

• Copilot implementation was adopted
• Cursor implementation was retained for comparison evidence
• a bounded incremental fetch path was added for saved articles
• saved articles now resume from the page containing `max_saved_res_no`
• on the resume page, `res_no <= max_saved_res_no` is treated as already existing
• on the resume page, only `res_no > max_saved_res_no` is treated as new candidates
• only later pages that are actually needed are fetched
• unsaved articles still use the existing full-fetch path
• zero-new results are now treated as success-class behavior
• prior partial / interrupted / capped saved articles reuse the same
  `max_saved_res_no` anchor-resume rule
• existing high-volume / capped policy was preserved
• plain-text target-list usability was improved in bounded form:
  - ignore comment lines beginning with `#`
  - ignore blank lines
  - trim surrounding whitespace
• no scheduler framework was introduced
• no Web / API expansion was introduced
• no storage schema redesign was introduced
• no target-registry redesign was introduced
• no archive-write redesign was introduced
• both repositories now reflect the same adopted final state on `main`
• convergence was confirmed with `./compare_helix.sh --all`
• post-adoption validation passed for the adopted final state

TASK024 has been completed.

TASK024 result:

• Copilot implementation was adopted
• Cursor implementation was retained for comparison evidence
• a bounded article input resolution seam was added
• `article_resolver.py` was added
• the resolver accepts:
  - article top full URL
  - full article title
• canonical target now includes:
  - `article_url`
  - `article_id`
  - `article_type`
• success result envelope now includes:
  - `title`
  - `matched_by`
  - `normalized_input`
• title input resolution remains bounded:
  - search first page only
  - exact title match only
  - `not_found` on zero exact matches
  - `ambiguous` on multiple exact matches
• failure taxonomy remains bounded:
  - `invalid_input`
  - `not_found`
  - `ambiguous`
• a minimal operator-facing `resolve-article` entry was added in bounded form
• the operator entry remains a thin wrapper over the same resolver path
• no Web / API expansion was introduced
• no queue persistence / drain was introduced
• no scheduler framework was introduced
• no storage schema redesign was introduced
• no target-registry redesign was introduced
• both repositories were later aligned again at the same code state
• convergence was confirmed with `./compare_helix.sh --all`
• post-adoption validation passed in both repositories

TASK025 has been completed.

TASK025 result:

• Cursor implementation was adopted
• Copilot implementation was retained for comparison evidence
• the archive-read seam was extended for bounded non-CLI reuse
• a bounded saved-article existence check was added
• a bounded one-article TXT retrieval path was added
• missing article handling is now exposed in bounded non-CLI-facing form
• existing CLI txt export now reuses the read-side seam
• existing CLI-visible export/list behavior was preserved
• the task remained pre-Web / pre-route / pre-queue
• no multi-format expansion was introduced
• no storage schema redesign was introduced
• no archive-write redesign was introduced
• both repositories were later aligned again at the same code state
• convergence was confirmed with `./compare_helix.sh --all`
• post-adoption validation passed in both repositories

TASK026 has been completed.

TASK026 result:

• Cursor implementation was adopted
• Copilot implementation was retained for comparison evidence
• a bounded request queue persistence seam was added
• resolved canonical article targets can now be persisted as queued requests
• duplicate enqueue handling was added in bounded form
• queue identity is based on canonical article identity
• queue persistence remains minimal and explainable
• the task remained pre-drain / pre-Web / pre-scheduler
• no queue-drain execution was introduced
• no scrape execution redesign was introduced
• no Web / API expansion was introduced
• no broad storage schema redesign was introduced
• both repositories were later aligned again at the same code state
• convergence was confirmed with `./compare_helix.sh --all`
• post-adoption validation passed in both repositories

Operational note:

• a separate sibling checkout for provisional personal-use runtime operation now exists outside this workspace root:
  - `/home/manage/product/nicodic_archiver_runtime`
• this runtime checkout is being used as a provisional dogfooding / personal-use operation instance
• it is intentionally separate from the `nicodic_archiver/` development + meta workspace
• the runtime instance uses the adopted product `main` baseline
• manually maintained scrape targets are stored under:
  - `runtime/targets/targets.txt`
• runtime data/log persistence continues under:
  - `runtime/data/`
  - `runtime/logs/`
• periodic operation is still intended to be driven by lightweight external scheduling
  through `runtime/periodic_once.sh`
• container-internal cron is still not part of the adopted product design

TASK027 has been completed.

TASK027 result:

• Cursor implementation was adopted
• Copilot implementation was retained for comparison evidence
• a bounded queue-drain execution path was added
• queue-drain reuses the current scrape path with explicit queue-drain-only cap plumbing
• a named per-article response cap was added for queue-drain execution
• success-class terminal outcomes now dequeue queued requests
• unexpected failures now leave queued requests in place
• no broad queue status model was introduced
• `orchestrator.py` was updated
• `storage.py` was updated
• `tests/test_orchestrator.py` was updated
• `tests/test_storage.py` was updated
• both repositories now reflect the same adopted final state on `main`
• convergence was confirmed with `./compare_helix.sh --all`
• post-adoption validation passed in both repositories

Current application structure:

main.py
orchestrator.py
cli.py
archive_read.py
article_resolver.py
http_client.py
parser.py
storage.py
target_list.py

Current test structure includes:

tests/conftest.py
tests/test_basic.py
tests/test_http_client.py
tests/test_main.py
tests/test_orchestrator.py
tests/test_parser.py
tests/test_storage.py
tests/test_target_list.py
tests/test_cli.py
tests/test_article_resolver.py
tests/test_archive_read.py

Additional helper scripts exist:

compare_helix.sh
export_review_snapshot.sh
export_snapshot.sh
sync_architecture_doc.sh
new_task_branches.sh
validate_helix.sh
collect_task_review.sh
export_open_issues.sh

These root scripts are thin wrappers.

Their implementations are stored under:

META/scripts/

compare_helix.sh:
used to confirm convergence between copilot/ and cursor/

export_review_snapshot.sh:
used to export review-oriented comparison snapshots
including untracked / diff information

export_snapshot.sh:
used to regenerate authoritative AI-readable project snapshots

sync_architecture_doc.sh:
used to synchronize META/ARCHITECTURE.md into
copilot/docs/ARCHITECTURE.md and cursor/docs/ARCHITECTURE.md

new_task_branches.sh:
used to create matching task branches for copilot/ and cursor/

validate_helix.sh:
used to run validation in both child repositories

collect_task_review.sh:
used to print review-oriented task information for both child repositories

export_open_issues.sh:
used to export open GitHub issues from the meta repository
into a local text file such as `Issues.txt`

Additional review memory exists:

META/review_log/

This directory stores AI-readable adoption / review logs
for completed tasks.

META/TASK_CYCLE_CHECKLIST.md stores practical task-cycle guidance
for review, adoption, and post-merge synchronization.

Roadmap reference:

For non-authoritative future-direction context, see:

META/ROADMAP_REFERENCE.md

This roadmap reference is for planning continuity only.
It must not be treated as authoritative current state
or as a fixed task order.

Medium-term direction reference:

For stronger near-term planning guidance across the next few tasks, see:

META/MEDIUM_TERM_DIRECTION.md

This medium-term direction is stronger than the roadmap reference,
but weaker than authoritative current-state files.

It is intended to guide likely next-task direction
without becoming a fixed task order
or replacing source-of-truth state restoration.

Copilot meta-assistant note:

A GitHub Copilot-connected AI is currently being used in a limited,
supplementary role for meta-repository information retrieval and
context recovery.

Its role is limited to:
- reading meta-repo source-of-truth files
- summarizing current state
- locating review-memory information
- helping restore context across sessions

It is not used as:
- a product implementation authority
- a review verdict authority
- an adoption decision authority
- a replacement for the human + advisor judgment chain

--------------------------------------------------

NEXT TASK

TASK027 is complete.

A roadmap reference exists for future-direction context only:

META/ROADMAP_REFERENCE.md

A medium-term direction reference also exists for near-term planning continuity:

META/MEDIUM_TERM_DIRECTION.md
