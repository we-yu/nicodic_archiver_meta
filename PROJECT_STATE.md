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

TASK028 has been completed.

TASK028 result:

• Copilot implementation was adopted
• Cursor implementation was retained for comparison evidence
• a minimal Web-facing archive-check UI was added
• the UI now provides an article-name / article-URL input, a submit button,
  and a bounded result display
• `main.py` now exposes a bounded Web app entrypoint
• `web_app.py` was added
• `archive_read.py` was extended for bounded saved-article summary lookup from
  Web-facing code
• the adopted-side review path included narrow follow-up fixes for title-input
  behavior before close-out
• title-input ordinary misses no longer leak RuntimeError from the title-search
  path
• the archive-check UX now supports local saved-title lookup before falling
  back to broader resolution behavior
• local saved-title lookup now supports a bounded case-insensitive title match
  for visitor-facing parity such as `G123` / `g123`
• representative browser smoke checks succeeded for saved URL/title inputs on
  the adopted-side candidate
• no TXT download or enqueue behavior was added yet
• `tests/test_web_app.py` was added
• archive-read / resolver / main tests were updated
• both repositories now reflect the same adopted final state on `main`
• convergence was confirmed with `./compare_helix.sh --all`
• post-adoption validation passed in both repositories

TASK029 has been completed.

TASK029 result:

• Cursor implementation was adopted
• Copilot implementation was retained for comparison evidence
• the existing minimal Web-facing archive-check UI gained bounded next actions
• saved results can now return a one-article Web TXT download
• unsaved results can now enqueue a request using the existing queue persistence baseline
• duplicate enqueue remains success-class at the user-facing level
• follow-up actions reuse the existing message area
• bounded action-time recheck was added for follow-up actions
• UI changes remained minimal
• `web_app.py` was updated
• `tests/test_web_app.py` was updated
• no auth / account / public-abuse design was introduced
• no CSV / JSON / MD / HTML Web implementation was introduced
• no queue / scheduler / worker redesign was introduced
• no broad runtime / deploy redesign was introduced
• both repositories now reflect the same adopted final state on `main`
• convergence was confirmed with `./compare_helix.sh --all`
• post-adoption validation passed in both repositories

TASK030 has been completed.

TASK030 result:

• Copilot implementation was adopted
• Cursor implementation was retained for comparison evidence
• the existing bounded Web app was packaged into a practical single-operator runtime/publication baseline
• the runtime profile now starts the Web app directly
• the runtime profile now publishes the Web app on a host-visible IP:port
• `main.py` web mode now accepts a bounded target-list-path option
• the runtime profile now wires the Web app to the mounted plain-text target list
• Web-side registration now adds only the canonical article URL to the existing plain-text target list
• Web-side registration does not enqueue work
• Web-side registration does not trigger immediate scrape execution
• actual scrape execution remains delegated to later periodic or batch runs
• saved article TXT download remains available from the Web UI
• `docker-compose.runtime.yml` was updated
• `docs/PERSONAL_RUNTIME.md` was updated
• `main.py` was updated
• `web_app.py` was updated
• `tests/test_main.py` was updated
• `tests/test_web_app.py` was updated
• no target source-of-truth DB migration was introduced
• no `targets.txt` format change was introduced
• no auth / account / public-abuse design was introduced
• no broad deploy / cloud-platform redesign was introduced
• no queue / scheduler / worker redesign was introduced
• both repositories now reflect the same adopted final state on `main`
• convergence was confirmed with `./compare_helix.sh --all`
• post-adoption validation passed in both repositories

TASK031 has been completed.

TASK031 result:

• Copilot implementation was adopted
• Cursor implementation was retained for comparison evidence
• a bounded SQLite-backed target registry was introduced
• the plain-text target list is no longer the long-term mainline source of truth
• the target registry uses:
  - surrogate integer primary key
  - canonical identity based on `article_id + article_type`
  - stored `canonical_url`
  - bounded `is_active`
  - `created_at`
• Web-side registration now writes to the SQLite-backed target registry
• Web-side registration still does not enqueue work
• Web-side registration still does not trigger immediate scrape execution
• actual scrape execution remains delegated to later periodic or batch runs
• periodic / batch / cron now read active targets from the target registry
• a bounded admin-only `targets.txt` import path was added
• the runtime profile and runtime documentation now point to the target registry
  as the active scrape target source of truth
• `docker-compose.runtime.yml` was updated
• `docs/PERSONAL_RUNTIME.md` was updated
• `main.py` was updated
• `runtime/periodic_once.sh` was updated
• `storage.py` was updated
• `target_list.py` was updated
• `web_app.py` was updated
• `tests/test_main.py` was updated
• `tests/test_storage.py` was updated
• `tests/test_target_list.py` was updated
• `tests/test_web_app.py` was updated
• no archive source-of-truth redesign was introduced
• no queue persistence / drain redesign was introduced
• no log schema / observability redesign was introduced
• no GUI admin was introduced
• no PostgreSQL migration was introduced
• no DB containerization was introduced
• both repositories now reflect the same adopted final state on `main`
• convergence was confirmed with `./compare_helix.sh --all`
• post-adoption validation passed in both repositories

TASK031B has been completed.

TASK031B result:

• Cursor implementation was adopted
• Copilot implementation was retained for comparison evidence
• a bounded append-only telemetry layer was introduced
• telemetry is persisted in SQLite-backed `scrape_run_observation`
• telemetry rows record per-run per-article bounded observations
• recorded observation fields include:
  - `run_id`
  - `run_started_at`
  - `run_kind`
  - `skipped`
  - `article_id`
  - `article_type`
  - `canonical_article_url`
  - `saved_response_count_after_run`
  - `latest_total_response_count_ref`
  - `scrape_ok`
  - `scrape_outcome`
  - `observed_at`
• CSV export was added as a read-only derived artifact for human inspection
• current text batch-log baseline was preserved
• target source-of-truth remained unchanged from TASK031
• archive / queue / Web main-flow semantics were not redesigned
• `main.py` was updated
• `orchestrator.py` was updated
• `storage.py` was updated
• `target_list.py` was updated
• `tests/test_main.py` was updated
• `tests/test_orchestrator.py` was updated
• `tests/test_storage.py` was updated
• validation passed on the adopted implementation
• post-adoption convergence and validation were confirmed on `main`

## TASK032
Completed.

Outcome summary:
- a bounded human-usable operator tooling seam was added for single-operator
  target registry and saved archive management
- the first interface is CLI / shell-tooling
- target registry management now includes:
  - list
  - inspect
  - add
  - deactivate
  - reactivate
- saved archive management now includes:
  - list
  - inspect
  - export
- telemetry / CSV export remains a support layer
- existing scrape / batch / periodic / Web / archive main-flow semantics were
  preserved
- the task remained bounded and did not expand into:
  - Web operator UI
  - observability / dashboard work
  - destructive archive or target actions
  - PostgreSQL migration
  - DB containerization

Adoption result:
- Copilot implementation adopted
- Cursor implementation retained as review evidence
- both child repositories were later converged onto the adopted final state

Interpretation:
- the project now has a practical operator-facing management seam over:
  - the SQLite-backed target registry
  - saved archive state
- operator usability is now part of the baseline rather than a deferred idea
- archive delete / requeue / re-fetch remain out of scope
- target delete remains out of scope
- telemetry remains auxiliary rather than the main operator surface

## TASK033
Completed.

Outcome summary:
- a bounded human-friendly verification / smoke tooling seam was added for a
  single operator
- the first interface remains CLI / shell-tooling
- verification helpers reuse existing seams rather than introducing a new
  platform
- verification flow is read-first, human-readable, and bounded
- verification tooling now includes:
  - one-shot verification fetch
  - target registry confirmation helpers
  - one-shot batch verification helpers
  - telemetry CSV verification follow-up helpers
  - verification-focused docs and usage guidance
- the task remained bounded and did not expand into:
  - dashboard / observability platform work
  - Web admin
  - scheduler / retry framework
  - destructive maintenance
  - PostgreSQL migration
  - DB containerization

Adoption result:
- Copilot implementation adopted
- Cursor implementation retained as review evidence
- both child repositories were later converged onto the adopted final state

Interpretation:
- the project now has a practical bounded verification / smoke tooling seam
  layered on top of the existing operator/runtime baseline
- verification remains an operator helper layer rather than a platform

## TASK033B
Completed.

Outcome summary:
- a bounded known-good smoke (KGS) helper was added inside the existing
  TASK033 verification tooling seam
- KGS remains:
  - manual
  - opt-in
  - isolated
  - non-gating
- KGS-specific helper guidance is stdout-only
- the implementation reuses existing seams rather than introducing a new
  execution platform
- verification tooling now supports bounded KGS fetch / batch-style smoke on
  isolated state
- the task remained bounded and did not expand into:
  - CI / PR gating
  - scheduler / retry framework
  - destructive maintenance against the main working state
  - dashboard / observability platform
  - Web admin
  - PostgreSQL migration
  - DB containerization

Adoption result:
- Copilot implementation adopted
- Cursor implementation retained as review evidence
- both child repositories were later converged onto the adopted final state

Interpretation:
- the current verification baseline should be read as TASK033 + TASK033B
- the project now has bounded verification tooling plus a bounded KGS helper
- KGS is part of verification tooling, not a separate platform
- stdout-only KGS guidance and isolated smoke state are now part of the
  working baseline
- richer KGS ergonomics remain optional later work rather than missing current
  state

## SUBTASK001
Completed.

Outcome summary:
- a bounded built-in KGS follow-up trim defect was fixed
- the defect was caused by identity mismatch between:
  - URL-slug-side article identity
  - saved canonical article identity in isolated state
- built-in KGS follow-up trim now resolves the saved canonical article ID
  from isolated DB state before trimming
- bounded KGS debug visibility was added around trim behavior, including:
  - requested drop count
  - trim target identity
  - saved counts before / after
  - selected response numbers
- the work remained bounded and did not expand into:
  - scrape redesign
  - storage schema redesign
  - queue / scheduler work
  - Web / dashboard work
  - destructive maintenance tooling

Adoption result:
- Copilot sideflow result adopted into product `main`
- both child repositories now reflect the same adopted final state on `main`

Interpretation:
- current verification baseline should now be read as:
  - TASK033
  - TASK033B
  - SUBTASK001 built-in KGS follow-up trim correction
- KGS remains:
  - manual
  - opt-in
  - isolated
  - non-gating
- stdout-only human-readable KGS guidance remains part of the working baseline

## SUBTASK002
Completed.

Outcome summary:
- a bounded host-side cron log hygiene layer was added for the provisional
  personal-use runtime
- structured host cron logging now exists at:
  - `runtime/logs/host_cron.log`
- host cron logs now roll over daily on the next run start into:
  - `host_cron.YYYYMMDD.log`
- older daily host cron logs now compact in bounded weekly form into:
  - `host_cron.YYYYMMDD-YYYYMMDD.tar.gz`
- host cron output is now human-readable and run-block oriented
- a small host-cron-specific helper / formatting seam was added in:
  - `host_cron.py`
- the periodic-one-shot runtime path now writes through the host cron log
  formatting path
- existing batch semantics and `batch_*.log` baseline were preserved
- existing telemetry / DB / queue / scheduler / Web semantics were preserved
- validation passed on the adopted implementation, including direct bounded
  observation of:
  - structured `host_cron.log` output
  - `rotate_active_log(...)`
  - `compress_weekly_archives(...)`
  - repo validation / flake8 / pytest on converged `main`

Adoption result:
- Copilot sideflow result adopted into product `main`
- both child repositories now reflect the same adopted final state on `main`

Interpretation:
- current runtime / operations baseline now includes bounded host cron log
  hygiene on top of the existing personal runtime profile
- `host_cron.log` should be read as a host/runtime operations log, distinct
  from `batch_*.log`
- host cron hygiene remains text-log centered and bounded
- no observability platform or scheduler redesign was introduced

## SUBTASK003
Completed.

Outcome summary:
- a bounded batch-log readability improvement was added for `batch_*.log`
- the task center remained single-run readout quality improvement
- `batch_*.log` now has clearer text-log structure for:
  - run start
  - per-target progress
  - failure detail
  - run end summary
- success-side progress visibility now includes bounded minimal verification
  fields:
  - `result`
  - `target_url`
  - `article_title`
  - `collected_response_count`
  - `observed_max_res_no`
- failure-side detail now includes bounded investigation-start fields:
  - `progress`
  - `target_url`
  - `article_title`
  - `failure_page`
  - `failure_cause`
  - `collected_response_count`
  - `observed_max_res_no`
  - `short_reason`
- run end summary now includes:
  - `duration_seconds`
  - `success_targets`
  - `failed_targets`
  - `final_status`
- existing batch semantics were preserved
- existing `host_cron.log` baseline remained distinct
- existing telemetry / DB / queue / scheduler / Web semantics were preserved
- the task remained text-log centered and bounded
- no observability / dashboard platform expansion was introduced

Adoption result:
- Copilot sideflow result adopted into product `main`
- both child repositories now reflect the same adopted final state on `main`

Interpretation:
- current `batch_*.log` baseline should now be read as including bounded
  readability improvement for single-run inspection
- success-side minimal verification visibility is now part of the batch-log
  baseline
- failure-side investigation-start detail is now part of the batch-log baseline
- `batch_*.log` and `host_cron.log` remain distinct log layers

## SUBTASK004
Completed.

Outcome summary:
- a bounded runtime local-env / recreate / permission hardening layer was added
  for provisional runtime operation
- `.env.runtime.local` is now part of the intended local-only runtime config
  shape
- a tracked `.env.runtime.local.example` was added
- `.gitignore` now excludes `.env.runtime.local`
- shared runtime local-env helper behavior was added via:
  - `tools/runtime_env.sh`
- recreate-oriented runtime startup was added via:
  - `bash tools/runtime_up.sh`
- `runtime/periodic_once.sh` now loads the shared runtime env helper before
  invoking the existing periodic-once path
- the runtime hardening now reduces repeat failures caused by:
  - stale baked runtime container code
  - host port clash confusion
  - LOCAL_UID / LOCAL_GID mismatch
  - common writable-path mismatch
- focused runtime-local-ops tests were added
- existing scrape / batch / periodic / DB / queue / scheduler / Web semantics
  were preserved
- the task remained bounded runtime / ops hardening
- no deployment-platform redesign or observability-platform expansion was
  introduced

Adoption result:
- Copilot sideflow result adopted into product `main`
- both child repositories now reflect the same adopted final state on `main`
- `_runtime` sibling checkout also pulled merged `main`
- helper-based recreate and periodic-once were rechecked successfully in the
  `_runtime` checkout

Interpretation:
- current provisional runtime baseline should now be read as including local env
  hardening and recreate guidance
- `bash tools/runtime_up.sh` is now part of the bounded intended runtime
  operation shape
- `.env.runtime.local` remains local-only and should not be committed
- runtime hardening is improved without changing product semantics

## TASK034
Completed.

Outcome summary:
- bounded Web archive-check UX was simplified into a single-submit flow
- page title is now `NicoNicoPedia Archive Checker`
- saved article flow now shows a short saved result and triggers bounded
  auto-download
- unsaved article flow now immediately registers into the target registry and
  returns a short registration result
- bounded short error display replaced the older operator-facing result shape
- previous two-step follow-up action buttons were removed from the main result
  flow
- bounded waiting-state behavior now suppresses repeated submit attempts
- user-facing result display is simplified
- bounded Web action logging was added
- Web action log blocks are human-readable and separated by blank lines
- focused Web tests were updated to protect the adopted flow

Adoption result:
- Double Helix comparison was attempted
- Copilot result was adopted
- Cursor result was not adopted due to weaker practical UI behavior despite
  passing validation
- current product mainline should be read as reflecting the adopted Copilot
  version of TASK034

Interpretation:
- current Web archive-check UX is now single-submit first
- this is a bounded UX refinement only
- product semantics outside the Web interaction flow remain unchanged

## TASK035
Completed.

Outcome summary:
- redirect article pages are now detected as a bounded distinct outcome
- redirect detection handles at minimum meta refresh and location.replace
- redirect source targets are marked redirected and deactivated
- redirect target URLs are handed off into the target registry with duplicate
  suppression
- redirect handoff is treated as success-class in batch handling
- batch logs now include bounded REDIRECT_DETAIL visibility
- archive migration / merge is not performed
- old and new article identities remain separate in saved archive data

Adoption result:
- Double Helix comparison was attempted
- Copilot result was adopted
- Cursor result was preserved as non-adopted comparison evidence
- current product mainline should be read as reflecting the adopted Copilot
  version of TASK035

Interpretation:
- current scrape/runtime behavior now includes bounded redirect target handoff
- this is a bounded mainline behavior change
- archive read semantics and archive identity migration remain unchanged

## TASK036
Completed.

Outcome summary:
- saved responses from 5511090a_ニコニコ大百科:掲示板レス削除依頼 are now
  scanned by a bounded feeder
- explicit NicoNicoPedia URL candidates are extracted from saved response text
- supported URL categories are classified and normalized
- supported categories include:
  - `/a/...`
  - `/id/...`
  - `/b/a/...`
  - `/t/b/a/...`
  - `/t/a/...`
- `/b/a/...` and thread-style article URLs are normalized back to article URL
  input
- `/id/...` is handled by an internal-only helper and is not exposed as a
  user-facing input mode
- normalized candidates are handed off into the existing target registration
  route
- duplicate / invalid / redirect handling remains delegated to existing
  mainline logic
- feeder state tracks `last_processed_res_no`
- batch/periodic shot now runs the feeder once at shot start and appends newly
  queued targets at shot tail
- inspect-delete-request-feed CLI seam exists for stdout-based human
  verification
- normal runtime logging remains tiny-summary only

Adoption result:
- Double Helix comparison was attempted
- Copilot result was adopted
- Cursor result was preserved as non-adopted comparison evidence
- current product mainline should be read as reflecting the adopted Copilot
  version of TASK036

Interpretation:
- current scrape/runtime behavior now includes bounded delete-request feeder
  support
- this is a bounded mainline behavior change
- unsupported URL classes remain rejected for now
- user-facing article ID input remains unsupported

## TASK037
Completed.

Outcome summary:
- a bounded external publication / ops task was completed for the current
  runtime Web surface
- existing host nginx multi-site operation was extended with a third site:
  - `nicoarc-prelim.mimizuku.dev`
- the existing nginx publication style used for:
  - `notes.mimizuku.dev`
  - `sandbox.mimizuku.dev`
  was preserved
- host nginx remains the shared public ingress on:
  - `80`
  - `443`
- the runtime Web backend remains localhost-bound behind nginx at:
  - `127.0.0.1:58001`
- the backend container-side app port remained unchanged behind the host-local
  proxy boundary
- public bind expansion was not introduced
- certbot-managed TLS was added for:
  - `nicoarc-prelim.mimizuku.dev`
- HTTPS browser access to the runtime Web top page was confirmed
- existing sites:
  - `notes.mimizuku.dev`
  - `sandbox.mimizuku.dev`
  remained healthy after the new site was added
- certbot scheduled renewal presence and renewal dry-run success were confirmed
- product semantics were not changed
- scrape / DB / queue / scheduler / Web app behavior were not redesigned

Interpretation:
- current runtime publication baseline now includes bounded nginx front-door
  publication for the preliminary public FQDN:
  - `nicoarc-prelim.mimizuku.dev`
- nginx should be read as the shared ingress layer for current public sites,
  while runtime app backends remain closed behind host-local proxy ports
- this task is an ops/publication task, not a product-feature redesign

## TASK038
Completed.

Outcome summary:
- bounded Web saved-download format selection was added
- current Web saved-download baseline now supports:
  - `txt`
  - `md`
  - `csv`
- default format remains `txt`
- title-input saved flow supports selected format
- decoded article-URL saved flow supports selected format
- percent-encoded article-URL saved flow supports selected format
- CSV export now provides one response per record
- CSV header is bounded and stable:
  - `article_id`
  - `article_type`
  - `article_title`
  - `article_url`
  - `res_no`
  - `poster_name`
  - `poster_id`
  - `posted_at`
  - `content_text`
  - `content_html`
- existing TXT saved-download behavior was preserved
- Markdown export was added in bounded human-readable form
- Markdown rendering was additionally corrected so:
  - leading `>` lines are escaped
  - visible line breaks are preserved in common Markdown preview behavior

Adoption result:
- Double Helix comparison was attempted
- Copilot result was adopted
- Cursor result was preserved as non-adopted comparison evidence
- current product mainline should be read as reflecting the adopted Copilot
  version of TASK038

Interpretation:
- current Web saved-download baseline now includes bounded format selection
  for:
  - `txt`
  - `md`
  - `csv`
- this is a bounded saved-article one-download expansion only
- HTML export is still not part of the adopted baseline
- JSON export is still not part of the adopted baseline
- scrape / queue / scheduler / runtime publication semantics were not redesigned

## SUBTASK006
Completed.

Outcome summary:
- bounded delete-request feeder hardening was added
- candidate sanitize was strengthened for malformed / contaminated inputs
- sanitize now removes:
  - surrounding whitespace
  - embedded CR/LF
  - obvious control-character contamination
  - percent-encoded control contamination
- candidate sanitize is applied both:
  - after normalization during feed scan
  - again at handoff time for bounded self-heal of already-dirty candidates
- malformed or empty candidates are skipped without aborting the feeder run
- candidate-level resolver failures no longer abort the whole feeder run
- candidate-level registration failures no longer abort the whole feeder run
- bounded tiny-summary visibility now includes:
  - `processed_candidates`
  - `registered_candidates`
  - `skipped_invalid_candidates`
  - `skipped_resolution_failures`
  - `skipped_registration_failures`

Adoption result:
- Double Helix comparison was attempted
- Copilot result was adopted
- Cursor result was preserved as non-adopted comparison evidence

Interpretation:
- current bounded delete-request feeder baseline should now be read as
  hardened against malformed candidate input and candidate-level failure
  propagation
- whole batch / periodic shot should no longer be expected to fail merely
  because one delete-request candidate is malformed or transiently fails
- this completion does not imply logging-platform redesign or DB-wide
  cleanup framework addition

## TASK039
Completed.

Outcome summary:
- a bounded registered-article list view was added to the Web app
- the Web top page now links to a read-only registered article list page
- the registered article list is SQLite-backed and displays one row per saved
  / registered article target
- the list includes bounded operational fields such as:
  - `article_type`
  - `title`
  - `canonical_url`
  - `saved_response_count`
  - `latest_scraped_max_res_no`
  - `last_scraped_at` when available
- archive persistence was shifted toward SQLite-centered operation
- new scrape runs no longer perform always-on `data/*.json` archive output
- existing JSON files are treated as historical artifacts only
- existing JSON file physical deletion remains a human/runtime maintenance
  action, not a product-code migration step
- a bounded read-only scrape target summary artifact is now generated as:
  - `runtime/data/scrape_targets.txt`
- an admin-facing on-demand archive extraction helper was added:
  - `tools/show_scraped_res.sh`
- the helper supports:
  - bare title input as the default target interpretation
  - `--title TITLE` for explicit title input, including numeric-only titles
  - `--id ID` for explicit article ID input
  - `--txt`
  - `--md`
  - `--csv`
- helper output keeps archive content on stdout and concise status on stderr
- existing Web saved-download behavior and format selection were preserved
- existing scrape / queue / scheduler / runtime publication semantics were not
  redesigned

Adoption result:
- Double Helix comparison was completed
- Copilot result was adopted
- Cursor result was preserved as non-adopted comparison evidence

Interpretation:
- current archive operation should now be read as SQLite-centered for normal
  product behavior
- `data/*.json` should no longer be treated as a current always-on output
  path
- `tools/show_scraped_res.sh` is now part of the bounded operator helper
  baseline for ad-hoc article export
- registered article visibility is now available from the Web app, but remains
  read-only and intentionally simple
- richer registered-list UI polish, search, sorting, paging, editing, delete
  actions, and auth remain out of scope unless introduced by a later task


## TASK040
Completed.

Outcome summary:
- historical duplicate canonical article identities were merged using
  `canonical_url` as the bounded alias key
- the task specifically addressed `article_type='a'` numeric/slug identity
  splits rather than `article_type='id'` recurrence
- old numeric-side responses were preserved and transferred into the canonical
  slug-side identity when missing
- duplicate response insertion was avoided by bounded `res_no`-based protection
- cleanup of old numeric-side archive rows happened only after safe transfer
  verification
- target handling remained bounded and conservative
- `article_type='id'` rows were not reintroduced
- normal-success page-progress compaction was kept bounded and reviewable
- runtime DB dry-run / apply were validated through a copy-DB-first path before
  runtime apply
- runtime DB apply completed successfully
- runtime post-apply verification confirmed:
  - duplicate canonical URL groups reduced to zero
  - `article_type='id'` rows remained zero in:
    - `articles`
    - `responses`
    - `target`

Adoption result:
- Double Helix comparison was completed
- Cursor result was adopted
- Copilot result was preserved as non-adopted comparison evidence

Interpretation:
- the archive baseline now treats canonical `/a/<title>` identity as the
  practical saved-archive mainline for historical duplicate groups
- runtime archive / registered-article visibility should no longer show the
  old numeric/slug split for the merged canonical groups

## SUBTASK-bbs-page-boundary-resume
Completed.

Outcome summary:
- bounded BBS later-page progression was normalized to page-boundary semantics
- resume start now rounds `max_saved_res_no` to the containing page boundary
- next later-page progression now uses:
  - `current_page_start + BBS_RESPONSES_PER_PAGE`
- partial terminal pages now stop without emitting unnecessary off-boundary
  later-page fetches
- page size was externalized through:
  - `BBS_RESPONSES_PER_PAGE`
- unset or invalid page-size configuration falls back safely to:
  - `30`
- canonical slug identity save / resume flow was preserved
- representative runtime smoke confirmed boundary-aligned behavior for:
  - resumed saved articles
  - a multi-page unsaved article
- previously observed off-boundary later-page URLs such as:
  - `22386-`
  - `38822-`
  - `136212-`
  were not observed after the fix

Adoption result:
- Copilot-only SubTask implementation was adopted
- Cursor was not used for this SubTask

Interpretation:
- current BBS pagination baseline should now be read as boundary-based rather
  than `max_saved_res_no + 1`-style progression
- runtime periodic operation no longer has a known blocker from off-boundary
  later-page URL generation

## SUBTASK007
Completed.

Outcome summary:
- ID-style Nicopedia article URLs are now normalized at target registration
  boundaries.
- Incoming `https://dic.nicovideo.jp/id/<number>` URLs are resolved through
  normal HTTP redirect handling before being persisted as scrape targets.
- If the effective URL is a valid `/a/<title>` article URL, that `/a` URL is
  registered instead of the original `/id` URL.
- Registration and import paths now share the same normalization boundary.
- `parse_target_identity()` remains syntax-only and does not perform network
  access.
- `validate_target_url()` remains syntax-only and does not perform network
  access.
- Existing `/a/<title>` URL behavior is preserved.
- Existing Web, scrape, saved-download, registered-list, and storage schema
  behavior were not redesigned.

Adoption result:
- Copilot-only SubTask implementation was adopted.
- Cursor was not used for this SubTask.

Validation:
- Copilot validation passed.
- Cursor validation passed after main synchronization.
- Container smoke confirmed:
  - `/id/5364158` resolves to the `/a/おそ松さん` URL
  - `register_target_url()` stores the resolved `/a` URL
  - normal `/a` URL registration is unchanged
  - import path normalizes `/id` input through the shared boundary

Non-goals:
- existing runtime DB cleanup
- existing `article_type='id'` row migration
- existing `article_type='id'` target rewrite
- schema migration
- scrape scheduler redesign
- Web UI changes

Follow-up:
- Existing runtime `id` targets and empty `id` article rows should be handled
  by a separate maintenance task after this fix is reflected to runtime.

## SUBTASK008
Completed.

Outcome summary:
- historical runtime `article_type='id'` records were cleaned as a
  maintenance-only SubTask after SUBTASK007
- cleanup was intentionally simple rather than a precise ID-to-A migration
- `article_type='id'` rows were removed from:
  - `responses`
  - `articles`
  - `target`
- delete-request feeder cursor was reset to:
  - `last_processed_res_no = 0`
- queue requests were checked before cleanup:
  - `queue_id_count = 0`
- this allows future delete-request feeder runs to rescan through the corrected
  SUBTASK007 target registration normalization boundary
- no product code was changed
- no schema migration was introduced
- no scrape / feeder / Web behavior was redesigned

Validation:
- before cleanup:
  - `articles_by_type`: `a=77`, `id=12168`
  - `responses_by_type`: `a=1214184`
  - `target_by_type`: `a=82`, `id=12170`
  - all `id` article rows were zero-response rows
- after cleanup:
  - `articles_by_type`: `a=77`
  - `responses_by_type`: `a=1214184`
  - `target_by_type`: `a=82`
  - remaining `id` rows were `0`
  - delete-request feeder cursor was `0`
- runtime Web surface remained reachable
- post-cleanup cron intake increased `/a` targets without immediate `id`
  target re-growth

Runtime note:
- runtime reflection required a local `.dockerignore` hotfix so runtime local
  state would not be baked into Docker images
- a future small task should add this Docker build-context exclusion to
  mainline

Interpretation:
- historical runtime ID-style rows should be treated as discarded bad intake
  artifacts rather than migrated archive data
- future ID-style URL intake should be normalized to effective `/a/<title>`
  targets by the SUBTASK007 registration boundary

## SUBTASK009
Completed.

Outcome summary:
- runtime BBS page scrape pacing was externalized through local runtime
  environment configuration.
- `SCRAPE_PAGE_DELAY_SECONDS` was added as the runtime setting for the delay
  between paginated BBS page fetches.
- the default delay is now `5.0` seconds when the environment value is unset.
- valid decimal values such as `2.5` are accepted.
- invalid, empty, negative, NaN, and infinite values fall back to `5.0`.
- the setting is read by `orchestrator.get_scrape_delay_seconds()`.
- `collect_all_responses()` uses the configured value for page-to-page sleep.
- `.env.runtime.local.example` and `docs/PERSONAL_RUNTIME.md` were updated.
- existing scrape flow, Web behavior, target registration, ID URL
  normalization, saved download behavior, and DB schema were not redesigned.

Adoption result:
- Copilot-only SubTask implementation was adopted.
- Cursor was not used for this SubTask.

Validation:
- Copilot validation passed.
- Cursor validation passed after main synchronization.
- Container smoke confirmed:
  - unset value returns `5.0`
  - `SCRAPE_PAGE_DELAY_SECONDS=2.5` returns `2.5`
  - invalid value falls back to `5.0`

Runtime note:
- changing `.env.runtime.local` may require runtime container recreation before
  the new environment value is visible inside the running container.

## SUBTASK010
Completed.

Outcome summary:
- fixed scrape/archive identity propagation after SUBTASK007
- `/id/<number>` inputs no longer persist archive rows as `article_type='id'`
  when a valid canonical `/a/<title>` URL is available
- `run_scrape()` now carries canonical article URL through:
  - BBS URL generation
  - DB save boundary
  - scrape/archive metadata identity
- legacy tuple-style metadata test seams were preserved
- no DB schema change was introduced
- no Web UI change was introduced
- no feeder redesign was introduced

Validation:
- focused orchestrator tests passed
- full helix validation passed
- runtime smoke with `https://dic.nicovideo.jp/id/654665` fetched `/b/a/...`
- runtime smoke saved as `article_type='a'`
- post-smoke runtime DB showed zero `id` rows in:
  - `articles`
  - `responses`
  - `target`

Runtime note:
- runtime compose needed a local hotfix to pass
  `SCRAPE_PAGE_DELAY_SECONDS` into the container environment
- runtime was verified with `SCRAPE_PAGE_DELAY_SECONDS=2.5`
- this compose forwarding should be mainlined in a small follow-up task

Operational note:
- periodic cron was paused during the investigation
- after SUBTASK010 smoke, cron can be restored and a manual long shot can be
  started
Follow-up:
- `SCRAPE_PAGE_DELAY_SECONDS` forwarding was mainlined in
  `docker-compose.runtime.yml`
- runtime local `.dockerignore` exclusion was also mainlined to prevent local
  state from being baked into Docker images

## TASK041 completed: Registered Articles usability and export

TASK041 was completed with the Cursor implementation adopted.

Summary:
- Added recent-first Registered Articles ordering.
- Added bounded sort, pagination, and search.
- Added clickable canonical URL links.
- Added current-page CSV export.
- Added internal all-record CSV export.
- Improved the top-page Registered Articles link into a button-like affordance.
- Normalized human-facing download/export identity display so raw
  percent-encoded slugs are not shown directly in the TXT ID line.
- Cursor validation passed during review.
- Runtime-copy Web/CSV smoke checks passed.

DHM result:
- Cursor was adopted.
- Copilot was reviewed as a comparison implementation but not adopted.

Known follow-up:
- Numeric NicoNicoPedia article ID display is not fully solved in TASK041.
  For example, article pages may have numeric /id/ values such as 5560706,
  while the current archive identity is the canonical article key / slug.
  Numeric ID capture likely requires parser/storage/backfill work and should
  be handled as TASK041B or a separate SubTask.

Runtime note:
- TASK041 has not been reflected to the runtime checkout while the long shot is
  running. Runtime deployment is deferred to a safe maintenance point.

## TASK042 completed: Restore numeric article_id storage identity

TASK042 was completed with the Cursor implementation adopted.

Summary:
- Restored saved archive identity so canonical NicoNicoPedia articles use the
  numeric NicoNicoPedia article ID as `article_id`.
- Kept `article_type='a'` for normal canonical article saves.
- Kept `canonical_url` as canonical `/a/<slug>` for display and BBS fetching.
- Added save-boundary validation so slug values are rejected for new
  `article_type='a'` saves.
- Preserved legacy slug-row read compatibility in tests by seeding legacy rows
  directly through SQL.
- Existing runtime DB migration was not performed.

DHM result:
- Cursor was adopted.
- Copilot was reviewed as a comparison implementation but not adopted.
- Copilot's non-adopted implementation remained useful comparison evidence,
  but failed validation because legacy slug-row tests still used `save_to_db()`.

Validation:
- Cursor passed repo-local validation during review.
- After adoption and main realignment, both child repos should pass validation.

Known follow-up:
- Existing runtime DB may still contain `article_type='a'` rows whose
  `article_id` is a URL-encoded slug.
- Repairing those rows is intentionally not part of TASK042.
- A later migration-focused task should detect, dry-run, and safely normalize
  those rows using explicit DB paths and copy DB validation.

Runtime note:
- TASK042 has not been reflected to the runtime checkout while the long shot is
  running.
- Runtime deployment is deferred to a safe maintenance point.


## TASK043 completed: Legacy slug article_id repair tooling

TASK043 was completed with the Cursor implementation adopted.

Summary:
- Added a standalone maintenance tool for repairing legacy
  `article_type='a'` rows whose `article_id` is a URL-encoded `/a/<title>`
  slug.
- The tool requires an explicit DB path.
- Dry-run is the default.
- Writes require explicit `--apply`.
- Network metadata resolution requires explicit `--allow-network`.
- Staged operational validation is supported through `--limit`.
- Compact output is supported through `--summary-only`.
- The tool preserves `article_type='a'` and canonical `/a/<slug>` URLs.
- The tool does not create normal `article_type='id'` rows.
- Target rows are normalized by activating numeric targets and deactivating
  legacy slug targets, not by delete-first behavior.

Validation:
- Cursor was adopted.
- Copilot was retained as non-adopted comparison evidence.
- Cursor passed repo-local validation.
- Runtime DB copy validation succeeded for `--limit 10` and `--limit 100`.
- `--limit 100` copy apply preserved total response count and produced
  `missing_after=0`.
- Runtime DB itself was not modified.

Runtime note:
- Runtime remains in long-shot operation.
- Actual runtime DB apply is deferred until a safe maintenance point.

Known follow-up:
- Add soft terminate for periodic/long-shot operation.
- Prepare runtime apply procedure after runtime is safely stopped.
- Optionally perform a full-copy dry-run/apply rehearsal before runtime apply.


## SubTask completed: soft terminate periodic shot

The soft terminate periodic shot SubTask was completed with the Copilot
implementation adopted.

Summary:
- Added file-based controlled stop support via `SOFT_TERMINATE_FILE`.
- Added elapsed one-shot duration bounding via
  `ONESHOT_LIMIT_DURATION_SECONDS`.
- Stop checks occur only at safe article boundaries.
- The current article is allowed to finish before the run stops.
- Controlled stops are success-class when no scrape failure occurred.
- Runtime docs and `.env.runtime.local.example` were updated.
- `runtime/control/.gitkeep` was added so the control directory exists.
- `docker-compose.runtime.yml` now mounts `runtime/control` into the runtime
  container.

Validation:
- Copilot passed repo-local validation.
- Cursor main also passed validation after main convergence.
- `runtime/periodic_once.sh` passed shell syntax validation.
- docker compose config showed the expected soft terminate variables and
  control mount.

Runtime note:
- Runtime DB was not modified.
- TASK043 DB apply was not performed.
- The feature does not affect already-running processes that have not loaded
  this code.
- The current long shot still requires separate manual stop handling if it is
  stopped before natural completion.


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
host_cron.py

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
tests/test_host_cron.py

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

TASK040 is complete.

SubTask-bbs-page-boundary-resume is complete.

Important current interpretation:

- TASK040 canonical URL identity merge is complete and was applied to the
  runtime DB.
- Historical duplicate canonical URL groups were merged safely.
- `article_type='id'` rows remain zero in runtime archive / response / target
  state after the TASK040 apply check.
- BBS later-page progression is now normalized to BBS page boundaries.
- resume start now rounds to the containing page boundary.
- next-page progression now uses boundary + page_size.
- partial terminal pages stop without off-boundary later-page fetch.
- BBS page size is externally configurable through:
  - `BBS_RESPONSES_PER_PAGE`
- unset or invalid page-size configuration falls back safely to:
  - `30`
- runtime smoke confirmed boundary-aligned behavior for representative resumed
  articles and a multi-page unsaved article.
- the previously observed off-boundary later-page URLs such as:
  - `22386-`
  - `38822-`
  - `136212-`
  were not observed in the latest runtime smoke.
- runtime cron is currently paused by operator choice, not because of a known
  remaining blocker in this subtask.

Likely next task:

- Return to current medium-term prioritization after runtime restart.
- A likely near-term follow-up is bounded scrape-progress visibility polish if
  runtime operation shows that further log readability work is still needed.


## 2026-05-08 Runtime DB reset

Runtime DB repair for TASK043-era legacy identity data was abandoned after
copy-DB rehearsal because the remaining historical repair cost outweighed the
value of preserving disposable personal scrape data.

A compressed backup of the old runtime DB was kept, active targets were
exported as canonical URLs, one max-BBS-response-count challenge article was
excluded, and a fresh runtime DB was created with 12149 imported targets.

A 30-minute bounded smoke shot completed successfully:
`articles=40`, `responses=20153`, no `article_type='id'` rows, no legacy slug
article rows, no duplicate response keys, and the excluded article remained
absent.

## 2026-05-08: Registered Articles pending target visibility and encoded search fixes

Completed:
- SubTask: show pending registered targets (#61)
  - Registered Articles now lists active target rows, including unsaved/pending targets.
  - Saved article metadata and response counts are resolved through saved article identity, including canonical_url fallback for target slug vs saved numeric article id cases.
- SubTask-BugFix: search encoded registered targets (#62)
  - Registered Articles search now expands decoded user search terms with URL-encoded variants.
  - Runtime verification confirmed `神谷` search returns 5 rows including `神谷浩史`.

Validation:
- `./validate_helix.sh` passed before merge.
- Runtime checkout updated to main and restarted with `tools/runtime_up.sh`.
- Runtime DB verification confirmed decoded Japanese search works against URL-encoded pending targets.

Operational note:
- Runtime cron remains disabled intentionally. Do not restart periodic collection until the next denylist/ignore-list decision is made.

## 2026-05-09: Target denylist policy seam reflected to runtime

Completed:
- SubTask: target denylist / ignore policy seam
  - Copilot-only bounded SubTask was adopted.
  - `collection_policy.py` now holds the known high-volume denylist seam.
  - Target registration rejects denylisted articles at the common registration
    boundary.
  - Web registration shows:
    `This article is excluded from archive collection.`
  - delete-request feeder and import paths expose denylisted skips.
  - scrape-side `skip_denylist` protection remains in place.
  - response cap behavior was intentionally not changed.
  - no `denylist.txt`, DB-backed denylist table, schema migration, runtime DB
    direct edit, or cron restart was included in the implementation.

Runtime reflection:
- runtime checkout was fast-forwarded to product main commit `359bf50`.
- runtime image rebuild and force-recreate completed successfully.
- runtime Web container started on `127.0.0.1:58001`.
- public preliminary Web surface remained reachable through:
  - `nicoarc-prelim.mimizuku.dev`
- runtime policy smoke confirmed:
  - `/id/480340` maps to denylisted ID `480340`
  - `/a/4294967295` maps to denylisted ID `237789`

Runtime DB state:
- current runtime DB remains disposable / reconstructable.
- current counts after reset and bounded smoke are:
  - `articles=40`
  - `responses=20153`
  - active `target` rows initially around `12149`
- `4294967295` was found as an existing active target that predated the
  policy seam.
- `4294967295` was deactivated through operator target tooling from inside the
  runtime container.
- follow-up check showed:
  - `('4294967295', 'a', 'https://dic.nicovideo.jp/a/4294967295', 0)`
- denylisted saved archive rows were not found for:
  - `480340`
  - `237789`
  - `4294967295`

Operational status:
- runtime cron remains intentionally disabled.
- no periodic / batch process was running during the last pre-cron check.
- cron can be considered for restart after final operator confirmation.

Known UI follow-up:
- Registered Articles currently lists active target rows, including pending
  unsaved targets.
- Pending target rows may display slug/title-like target identity in the
  `Article ID` column until numeric NicoNicoPedia ID is known.
- This is not a denylist blocker and does not imply DB corruption.
- However, the intended Article ID display is the numeric NicoNicoPedia ID
  derived from metadata such as `og:url`.
- A bounded follow-up SubTask should adjust Registered Articles display so
  slug/title-like pending target identity is not presented as numeric
  `Article ID`.
- The default Registered Articles sort is currently `target.created_at DESC`;
  a stable tie-break such as target row id descending may be useful so newly
  submitted items reliably appear first when timestamps collide.

## TASK044 adopted: numeric target identity

- TASK044 was run as a MainTask / DHM.
- Cursor implementation was adopted.
- Copilot implementation is retained as a reference branch.
- `target.article_id` for article_type `a` now semantically means numeric
  NicoNicoPedia article ID.
- New target writes validate that article_type `a` article IDs are non-empty
  digit strings.
- `target.title` was added for pending registered target display.
- Registered Articles now uses numeric Article ID and stored title for pending
  rows.
- Registration resolves `/a/<slug>` and `/id/<digits>` through metadata to
  numeric ID plus canonical `/a/<slug>` URL.
- `resolution_failure` is the canonical resolution failure result key.
- Runtime DB and cron were not changed by TASK044.
- Runtime cron remains disabled pending runtime reflection and smoke checks.


## MainTask completed: Codex adoption planning

MainTask-codex-adoption-planning was completed as a root/meta workflow
planning task.

Added planning files:

- META/CODEX_ADOPTION_PLAN.md
- META/CODEX_TRIAL_CHECKLIST.md
- META/AGENTS_DRAFT.md

Purpose:

- evaluate Codex as a near-term development-process improvement
- reduce repeated editor-prompt and validation-fix overhead
- preserve Human / Advisor adoption judgment
- preserve runtime DB / cron / docker safety boundaries
- keep current Double Helix intent while allowing future tool substitution

Current decision:

- Codex may be investigated soon.
- Codex does not replace Human / Advisor final judgment.
- Codex should not receive runtime DB, cron, docker, heavy scrape, or merge
  adoption authority at this stage.
- AGENTS_DRAFT.md is only a draft and is not yet active AGENTS.md.

Recommended first trials:

- Codex Chrome / in-app browser for Web UI smoke with no repository writes.
- Codex IDE extension for focused child-repo fixes.
- A small product BugFix such as
  SubTask-BugFix-registered-search-like-escape.

Runtime status:

- No runtime DB changes were made.
- No cron changes were made.
- No docker/runtime reflection was performed.
- No product code changes were made.


## Current status: Registered Articles UI polish adopted

The Registered Articles UI polish SubTask has been adopted and reflected to the runtime environment.

Adopted state:

- Product main includes the Registered Articles UI polish changes.
- Copilot implementation branch was merged through GitHub PR flow.
- Cursor main was fast-forwarded to merged product main.
- Copilot and Cursor are converged on the adopted product state.
- Runtime checkout was fast-forwarded to merged main.
- Runtime Web container was rebuilt and recreated with tools/runtime_up.sh.
- Runtime Web now displays the improved Registered Articles page.
- Periodic cron remains active at 3-hour intervals with a 2-hour oneshot limit.

Registered Articles improvements:

- Numeric Article ID sorting.
- Numeric Saved Responses sorting.
- Numeric Max Res No sorting using the current existing read-side value.
- Datetime-like Created At and Last Scraped sorting.
- Default Created At descending sort preserved.
- JST Web display for Created At and Last Scraped.
- Wider search input.
- Reset action.
- Refresh action.
- Pagination above and below the table.
- Improved Title / Canonical URL column layout.
- Canonical URL ellipsis in the Web table.
- Full Canonical URL preserved for href/tooltips and CSV.
- Better horizontal alignment by data type.
- Vertical centering for table headers and row cells.

Validation:

- ./validate_helix.sh passed before adoption.
- Post-merge ./compare_helix.sh --all passed.
- Post-merge ./validate_helix.sh passed.
- Final observed validation:
  - Copilot: 394 tests passed
  - Cursor: 394 tests passed

Runtime / cron:

Periodic cron remains active.

Cron command line:

> 5 */3 * * * cd /home/manage/product/nicodic_archiver_runtime && ONESHOT_LIMIT_DURATION_SECONDS=7200 ./runtime/periodic_once.sh >> /home/manage/product/nicodic_archiver_runtime/runtime/logs/host_cron.log 2>&1

This means:

- Kick every 3 hours.
- Run with a 2-hour oneshot duration limit.
- Existing lock behavior prevents overlap.
- Current article is allowed to finish when the duration limit is reached.

Explicitly not done:

- Max Res No semantic redesign.
- Live board observed max response tracking.
- Scrape run ID / run mark tracking.
- DB schema changes.
- Runtime DB edits.
- Cron policy change.
- Scraper behavior changes.
- Delete feeder behavior changes.
- Response cap changes.

Known follow-up:

The current Max Res No column still represents the existing locally-derived read-side value. It sorts correctly as a number, but it is not yet the live NicoNicoPedia board's observed latest response number.

A future MainTask should handle scrape run identity, short run mark display, target state tracking, invalid target state, and observed max response number semantics.

Near-term task candidates are tracked in:

- META/NEXT_TASK_CANDIDATES.md

## SubTask-BugFix completed: Registered Articles visible-field search

Registered Articles search was corrected so the normal search box targets only
visible user-facing fields:

- Article ID
- Title

Canonical URL, dates, Saved Responses, and Max Res No are not direct search
targets.

This fixes confusing results where Japanese queries could match hidden
canonical URL encodings instead of visible titles.

Validation:

- ./validate_helix.sh passed before adoption.
- Browser smoke was performed against a temporary Copilot Web container using
  runtime data.
- Post-merge ./compare_helix.sh --all passed.
- Post-merge ./validate_helix.sh passed.
- Final observed validation:
  - Copilot: 397 tests passed
  - Cursor: 397 tests passed

Codex trial note:

- This was used as a small Codex single-editor product BugFix trial.
- Codex implementation was useful, but it incorrectly suggested host Python /
  venv-style validation commands.
- Future AGENTS.md should explicitly prefer existing project scripts such as
  validate_helix.sh and runtime_exec.sh over ad-hoc host Python / venv
  workflows unless explicitly instructed.

Runtime reflection:

- Pending until product main is reflected to runtime.

## MetaTask completed: optimizing metadata index

MetaTask-optimizing-metadata was completed as a bounded root/meta repository
organization task.

Added files:

- META/METADATA_INDEX.md
- MetaTask-optimizing-metadata_report.md

Purpose:

- reduce confusion in the growing root/meta repository
- clarify which meta files are authoritative restore context
- clarify which files are workflow guidance, architecture/schema reference,
  historical review memory, Codex planning material, or generated snapshot
  artifacts
- provide a safe index before any future metadata slimming or relocation work

Adopted outcome:

- A metadata index was added.
- A task report was added.
- Existing authoritative files were not rewritten.
- Existing historical logs were not moved.
- PROJECT_STATE.md was not slimmed in this task.
- AGENTS_DRAFT.md remains draft-only and was not promoted to AGENTS.md.
- project_snapshot.txt tracking was not changed.
- product code was not changed.
- runtime files, cron, docker, and DB state were not changed.

Current interpretation:

- The immediate problem was not lack of information, but lack of a readable
  cross-reference for authority level, purpose, and normal edit policy.
- The new metadata index should be used as the first reference when deciding
  where future meta information belongs.
- PROJECT_STATE.md slimming may be useful later, but should be handled as a
  separate bounded task.
- project_snapshot.txt tracking should be revisited only after the restore
  model and generated-artifact policy are explicitly reviewed.
- AGENTS_DRAFT.md should remain draft until Codex operating rules are proven
  through more trials.

Recommended follow-up candidates:

- create a helper script for safe PROJECT_STATE append blocks
- consider a bounded PROJECT_STATE current-summary / historical-log split
- review generated snapshot tracking policy
- decide whether AGENTS_DRAFT.md should become active AGENTS.md after more
  Codex trials

## SubTasks completed: compact scrape logging and OK0 host-log compression

Two bounded runtime logging subtasks were completed and adopted:

- SubTask-compact-shot-heartbeat-log
- SubTask-compact-ok0-host-log

Product adoption:

- SubTask-compact-shot-heartbeat-log was adopted into product main as #67.
- SubTask-compact-ok0-host-log was adopted into product main as #68.
- Copilot implementation was adopted for the OK0 compression task.
- Both child product repos were synced back to main.
- Helix convergence was confirmed.

Validation:

- validate_helix.sh passed after merge.
- copilot: 409 tests passed.
- cursor: 409 tests passed.

Runtime reflection:

- Runtime reflection was performed after confirming no periodic_once lock.
- runtime container was rebuilt/recreated through the standard runtime reflection flow.
- A short periodic-once smoke run was executed with ONESHOT_LIMIT_DURATION_SECONDS=180.

Observed runtime smoke:

- host_cron.log emitted one-line [STEP OK0 🟢] rows for clean no-change targets.
- RUN DIGEST reported hit_targets=0, ok0_targets=146, warn_targets=0,
  fail_targets=0, total_new_responses=0, and [OK0] others=146.
- This confirms the normal no-change path is compressed as intended.
- No WARN / FAIL runtime case appeared in the short smoke run; longer scheduled
  runs are expected to eventually exercise 🟡 / 🔴 cases.

Current logging baseline:

- host_cron.log is now the compact live/tail operations log.
- batch_*.log remains the detailed audit/postmortem log.
- RUN DIGEST is the primary per-run quick summary.
- Clean no-change targets are represented as [STEP OK0 🟢].
- HIT / WARN / FAIL / partial / multi-page / unknown-observed cases remain in
  detailed compact STEP START / PAGE / STEP END form.

Important behavior:

- OK0 compression is intentionally narrow.
- A target is compressed only when it is success, stored_new=0,
  already_up_to_date, exactly one successful PAGE token, known saved/observed
  values, and no WARN/FAIL/status detail.
- Non-qualifying targets fall back to detailed compact logging.
- Board page token display now drops the trailing dash.

Review memory:

- Added META/review_log/SubTask_compact_scrape_logging_20260517.md as the
  future-facing review log for these logging tasks.

Non-goals preserved:

- No DB schema changes.
- No scrape_id / scrape_mark implementation.
- No Delete Feeder detailed logging redesign.
- No parent log / third log stream.
- No JSON logging or observability platform.
- No cron schedule redesign.
- No scrape ordering or response collection semantic changes.
- No Max Res No semantic redesign.

Cron status:

- Existing cron cadence remains active.
- Current periodic cron continues to run every 3 hours with
  ONESHOT_LIMIT_DURATION_SECONDS=8500.

## MainTask completed: direct article title resolution

MainTask-direct-article-title-resolution was completed.

Purpose:

- restore the intended article registration philosophy
- resolve user-entered exact article titles directly as Nicopedia article pages
- remove Nicopedia Search from the normal title resolution path

Adopted behavior:

- URL input continues to resolve directly.
- Non-URL title input now builds and fetches:
  https://dic.nicovideo.jp/a/<URL-encoded title>
- If that exact article page exists, normal canonical/article-id extraction is
  used and the target can be registered.
- If that exact article page does not exist, the resolver returns not_found.
- User typos are not corrected.
- Fuzzy matching, alternate suggestions, and Search fallback were not added.

Adoption:

- Cursor implementation was selected.
- Copilot and Cursor alternatives were both validated before selection.
- Product main was updated.
- copilot and cursor child repos were synced to main.
- Helix convergence was confirmed.
- validate_helix.sh passed after adoption.

Runtime reflection:

- Runtime reflection was performed after the active periodic run was stopped
  cleanly and no periodic_once lock remained.
- reflect_runtime.sh fast-forwarded the runtime checkout to the direct title
  resolution implementation.
- runtime container was rebuilt/recreated through the standard runtime flow.

Runtime Web smoke:

- Web registration of ストローマン論法 succeeded.
- Registered Articles showed article_id=5400838, type=a, title=ストローマン論法.
- This confirms the provisional runtime environment now accepts exact Japanese
  title input without relying on Nicopedia Search.

Development Web note:

- A Cursor child-repo development Web smoke returned an internal error.
- Its DB appeared old / non-runtime-like.
- Direct article page fetch from inside that development container returned
  HTTP 200.
- Final acceptance was therefore based on provisional runtime Web smoke.

Review log:

- Added META/review_log/MainTask_direct_article_title_resolution_20260517.md.

Non-goals preserved:

- No Nicopedia Search fallback.
- No fuzzy matching.
- No typo recovery.
- No alternate title suggestions.
- No DB schema changes.
- No scrape behavior changes.
- No cron/runtime policy changes.
- No Delete Feeder changes.
- No article_type="id".
- No Max Res No semantic redesign.

Follow-up candidate:

- Existing articles with no board responses should be marked as scraped with
  saved responses = 0 and max res no = 0 after the first scrape confirms that
  no responses exist.
- This includes boards with no posts and boards unavailable due platform-side
  or petition-related restrictions.
- Existing archived responses must remain downloadable if a board becomes
  unavailable later.

## SubTask completed: zero-response board scraped state

SubTask-zero-response-board-scraped-state was completed.

Purpose:

- treat completed zero-response scrapes as scraped/checked
- prevent zero-response articles from looking like never-scraped pending rows
  in Registered Articles
- separate scrape/check completion state from saved response count

Adopted implementation:

- Cursor implementation was selected.
- No schema change was introduced.
- Existing articles.latest_scraped_at is used as the scrape/check completion
  signal.
- Registered Articles treats rows as checked when they have saved responses or
  a populated last_scraped_at value.
- Completed zero-response rows show saved responses = 0, Max Res No = 0, and
  populated Last Scraped.
- Pending/not-scraped visual state is now reserved for rows with both
  saved_response_count == 0 and no last_scraped_at.

Archive safety:

- Existing saved responses are not deleted.
- Existing saved responses are not overwritten.
- No fake/dummy responses are inserted.
- A later empty scrape/check does not reset an article with existing responses
  back to zero.
- Existing archived responses remain downloadable even if a later scrape/check
  finds no collectable responses.

Adoption:

- Copilot and Cursor alternatives both passed validation.
- Cursor was adopted because it made the scrape/check completion semantics more
  explicit and kept displayed/sorted Max Res No behavior more consistent.
- Product main was updated.
- copilot and cursor child repos were synced to main.
- Helix convergence was confirmed.
- validate_helix.sh passed after adoption.

Review log:

- Added META/review_log/SubTask_zero_response_board_scraped_state_20260519.md.

Non-goals preserved:

- No response deletion.
- No response overwrite.
- No fake response insertion.
- No broad schema migration.
- No Max Res No full semantic redesign.
- No scrape_id / run mark.
- No target state system redesign.
- No board migration or redirect archive merge.
- No Delete Feeder changes.
- No cron policy changes.

## Runtime reflected: zero-response board scraped state

Runtime reflection for SubTask-zero-response-board-scraped-state was completed.

- reflect_runtime.sh was run after confirming no active periodic_once lock and
  no active scrape process.
- runtime checkout was fast-forwarded to the adopted product main.
- runtime container was rebuilt/recreated through the standard reflection flow.
- Runtime smoke should continue through normal cron observation, especially for
  Registered Articles rows with saved responses = 0, Max Res No = 0, and
  populated Last Scraped.

## MainTask completed: target order modes

MainTask-target-order-modes was completed.

Purpose:

- avoid always starting periodic / batch runs from the beginning of the active
  target list
- make it possible to reach newer / Delete Feeder appended targets earlier
- provide random_rotation for long-term target traversal spreading
- provide a focused start article override for verification

Adopted implementation:

- Copilot implementation was selected.
- Added a bounded target_ordering.py boundary.
- Added TARGET_ORDER_MODE with supported values:
  - default
  - reverse
  - random_rotation
- Added TARGET_ORDER_START_ARTICLE_ID.
- Added CLI options for batch, periodic-once, and periodic:
  - --target-order-mode
  - --target-order-start-article-id
- CLI values override environment values.
- Environment values override default behavior.
- Invalid or unknown configuration falls back to default order without aborting.
- Invalid or not-found start article override falls back to default order.
- Stored numeric article_id values are used for start override, so numeric
  article_id matching works even when canonical_url is /a/<encoded title>.
- One compact [TARGET ORDER] line is emitted near run start and written to
  batch / host-cron-visible logs.

Validation:

- validate_helix.sh passed before adoption.
- Copilot branch reported 437 tests passed.
- Cursor comparison branch reported 429 tests passed.
- After merge, copilot and cursor should be synced to main and full validation
  should be rerun.

Runtime note:

- Runtime reflection is a separate step.
- This task does not change crontab.
- This task does not choose the final scheduling policy.
- Future runtime-operation tuning may use frequent random_rotation runs plus
  occasional reverse runs to reach newly appended targets sooner.

Review log:

- Added META/review_log/MainTask_target_order_modes_20260523.md.

Non-goals preserved:

- No cron changes.
- No Docker compose changes.
- No DB schema changes.
- No scrape semantics changes.
- No response storage changes.
- No Delete Feeder semantics changes.
- No persistent resume cursor.
- No per-target shuffle.
- No scrape_id / run mark.

## Runtime reflected: target order modes

Runtime reflection for MainTask-target-order-modes was completed.

- reflect_runtime.sh was run after confirming no active periodic_once lock and
  no active scrape process.
- runtime checkout was fast-forwarded to the adopted product main.
- runtime container was rebuilt/recreated through the standard reflection flow.
- Current crontab was not changed by this task.
- Existing runtime scheduling policy remains in effect.
- Future scheduling changes such as daily reverse plus frequent random_rotation
  should be handled as a separate runtime-operation task.

## SubTask-BugFix completed: target order runtime wrapper follow-up

SubTask-BugFix-forward-target-order-env-to-runtime-wrapper-followup was completed.

Purpose:

- fix the remaining target-order wrapper issue found during runtime smoke
- ensure empty TARGET_ORDER_START_ARTICLE_ID is treated as no override
- allow TARGET_ORDER_MODE=reverse and TARGET_ORDER_MODE=random_rotation to work
  when no start article override is provided

Root cause:

- TARGET_ORDER_MODE was successfully forwarded to the container.
- However, an empty TARGET_ORDER_START_ARTICLE_ID was also treated as an explicit
  invalid start override.
- This caused reverse/random_rotation runs to fall back to default with
  reason=invalid_start_article_id.

Adopted behavior:

- Empty or whitespace-only TARGET_ORDER_START_ARTICLE_ID is normalized to absent.
- Non-empty invalid start article id still falls back to default.
- Valid stored article_id override still works.
- Host inline TARGET_ORDER_MODE remains effective through runtime/periodic_once.sh.

Runtime branch smoke:

- TARGET_ORDER_MODE=reverse produced effective=reverse.
- TARGET_ORDER_MODE=random_rotation produced effective=random_rotation.
- TARGET_ORDER_START_ARTICLE_ID=5400838 produced effective=start_article_id.
- This confirmed that stored article_id matching and target list start_index are
  separate and not confused.

Validation:

- Focused tests reported 22 passed.
- Full child repo pytest reported 442 passed.
- flake8 reported no output.
- After merge, validate_helix.sh should be rerun from the root meta workspace.

Review log:

- Added META/review_log/SubTask_BugFix_forward_target_order_env_to_runtime_wrapper_followup_20260523.md.

Non-goals preserved:

- No crontab changes.
- No scheduling policy changes.
- No Docker compose topology changes.
- No DB/schema changes.
- No scrape semantics changes.
- No target ordering algorithm changes.

## Thread handoff: runtime DB lock and dev sample DB setup

Current handoff state:

- Product child repos are on main and converged.
- Latest product main includes:
  - MainTask-target-order-modes
  - SubTask-BugFix-forward-target-order-env-to-runtime-wrapper
  - SubTask-BugFix-forward-target-order-env-to-runtime-wrapper-followup
- TARGET_ORDER_MODE supports default, reverse, and random_rotation.
- TARGET_ORDER_START_ARTICLE_ID works through runtime/periodic_once.sh.
- Blank TARGET_ORDER_START_ARTICLE_ID is treated as absent.

Runtime status:

- The target-order cron policy was tried as:
  - 00:05 default
  - 03:05 reverse
  - 06/09/12/15/18/21 random_rotation
- Manual/random runtime smoke confirmed effective=random_rotation and actual target processing.
- During that run, sqlite3.OperationalError: database is locked occurred at:
  - storage.append_scrape_run_observation
  - conn.commit()
- The failure appears to be in scrape_run_observation / telemetry persistence,
  not in target ordering itself.
- Runtime periodic cron lines are currently commented out to prevent automatic
  re-entry while DB lock tolerance is unresolved.
- The stuck periodic process and periodic_once.lock were cleared.
- Runtime is currently expected to be:
  - no periodic_once lock
  - no periodic/batch process
  - Web container alive

Immediate next task:

- RuntimeOps-build-dev-sample-db
- Root branch already created:
  - runtimeops-build-dev-sample-db
- Purpose:
  - build a reusable root/meta helper that creates a compact Dev sample DB from
    the 8.4GB runtime DB
  - install the generated sample DB into copilot/runtime/data/nicodic.db and
    cursor/runtime/data/nicodic.db when the human runs the helper
  - avoid copying the full runtime DB
  - avoid live scraping
  - avoid Delete Feeder mass rebuild behavior

Planned files for RuntimeOps-build-dev-sample-db:

- build_dev_sample_db.sh
- META/scripts/build_dev_sample_db.py
- META/DEV_SAMPLE_DB.md

Important constraints for RuntimeOps-build-dev-sample-db:

- Do not edit copilot/ or cursor/ during helper implementation.
- Do not modify the runtime DB.
- Do not run live scraping.
- Do not copy the full runtime DB.
- Use current product storage.init_db schema creation if practical.
- Copy selected data from runtime DB into a small generated DB.
- Copy the same generated DB to both child repos only when the helper is run.
- Create dev_sample_manifest.json beside each generated DB.
- Create or refresh empty web_action.log beside each generated DB.
- Enforce Delete Feeder guard:
  - sample DB must contain zero responses for article_id=5511090 and
    article_type=a.

Fixed sample article selection:

- Required article_ids, article_type=a:
  - 5512354
  - 5513908
  - 5527590
  - 5523983
  - 5527595
  - 5523746
  - 1919260
  - 5228140
  - 4493425
  - 5535296
  - 5104766
  - 5287728
  - 4897961
  - 5509670
  - 5351038
  - 5501738
  - 4982057
- Optional article_id:
  - 5400838

Follow-up after Dev sample DB:

- SubTask-BugFix-observation-db-lock-tolerance
- Goal:
  - keep archive-critical writes fatal
  - add retry/warn behavior only for scrape_run_observation / telemetry lock
    failures
  - avoid turning telemetry-only database locks into full run FAILs
  - preserve response storage integrity

Later candidate:

- MainTask-sqlite-access-hardening
- Purpose:
  - review and harden SQLite connection timeout / busy_timeout / read/write
    access patterns across storage, archive_read, web_app, target_list, and
    related runtime paths.

## RuntimeOps-build-dev-sample-db completed

RuntimeOps-build-dev-sample-db was completed as a root/meta workflow helper
task.

Added files:

- `build_dev_sample_db.sh`
- `META/scripts/build_dev_sample_db.py`
- `META/DEV_SAMPLE_DB.md`
- `RuntimeOps-build-dev-sample-db_report.txt`

Updated files:

- `.gitignore`
- `project_snapshot.txt`
- `project_knowledge_snapshot.txt`

Purpose:

- avoid copying the full 8GB+ runtime DB into development checkouts
- create a compact Dev sample DB from fixed selected runtime articles
- support explicit distribution to:
  - `copilot/runtime/data/nicodic.db`
  - `cursor/runtime/data/nicodic.db`

Validation:

- helper self-check passed
- Python compile check passed
- staging build from the real runtime DB succeeded
- generated sample DB was about 744 KiB
- generated sample DB contained 17 `article_type='a'` articles
- generated sample DB contained 752 responses
- hard exclusion for `article_id='5511090'`, `article_type='a'` responses
  was confirmed with count zero
- no per-article response cap violations were found
- explicit child distribution succeeded
- child product repositories remained clean after distribution

Safety boundaries:

- runtime DB was treated as read-only input
- no live scraping was performed
- no crontab change was performed
- no Docker or runtime container state change was performed
- existing files under `copilot/` and `cursor/` were not edited

Review log:

- `META/review_log/RuntimeOps_build_dev_sample_db_20260523.md`

Immediate follow-up candidate:

- `SubTask-BugFix-observation-db-lock-tolerance`

Goal:

- keep archive-critical writes fatal
- add bounded retry/warn behavior only for scrape-run observation telemetry
  lock failures
- avoid turning telemetry-only `database is locked` failures into whole-run
  failures
- preserve response storage integrity

Later candidate:

- `MainTask-sqlite-access-hardening`

Goal:

- review and harden SQLite timeout / busy-timeout / read-write access patterns
  across storage, archive read, Web, target registry, and runtime paths.

## 2026-05-27 runtime recovery and periodic-once guidance

Runtime periodic operation was recovered after the observation DB lock incident.

Completed product work:

- `SubTask-BugFix-observation-db-lock-tolerance`
- `SubTask-Improve-periodic-once-host-cron-log-guidance`

Observation DB lock tolerance:

- product main includes `SubTask-BugFix: tolerate observation DB locks (#74)`
- telemetry-only scrape-run observation lock / busy failures are now bounded
  and non-fatal
- archive-critical writes remain fatal
- target registry writes remain fatal
- scrape and response storage semantics were preserved

Periodic-once host log guidance:

- product main includes
  `SubTask: improve periodic-once host log guidance (#75)`
- `runtime/periodic_once.sh` now prints where progress is written before
  Docker Compose exec starts
- the wrapper guidance points to the effective `$HOST_CRON_LOG_PATH`
- the wrapper suggests:
  `tail -f $HOST_CRON_LOG_PATH`
- no automatic tailing was added
- host_cron log format was not changed
- scrape, DB, cron, Docker, and runtime semantics were not changed

Validation:

- both child product repositories were synced to product main
- `./compare_helix.sh` confirmed convergence
- `./validate_helix.sh` passed after adoption
- final observed validation:
  - Copilot: 445 tests passed
  - Cursor: 445 tests passed

Runtime recovery:

- runtime checkout was confirmed clean on main before smoke
- no `runtime/logs/periodic_once.lock` was present
- no scrape-like process was present before smoke
- `bash tools/runtime_up.sh` completed successfully
- a short `periodic_once.sh` smoke completed normally
- `host_cron.log` showed normal run progress and completion
- the three target-order cron patterns were restored:
  - daily default
  - daily reverse
  - frequent random_rotation
- a manual background reverse run was started with:
  - `ONESHOT_LIMIT_DURATION_SECONDS=8500`
  - `TARGET_ORDER_MODE=reverse`
- `host_cron.log` showed reverse-mode scraping progress

Runtime reflection note:

- runtime reflection for the host-log guidance change was intentionally
  deferred because runtime periodic work was active
- this is acceptable because the change is terminal guidance only
- reflect runtime later at a safe maintenance point after the active run ends

Review logs:

- `META/review_log/SubTask_BugFix_observation_db_lock_tolerance_20260527.md`
- `META/review_log/SubTask_improve_periodic_once_host_cron_log_guidance_20260527.md`
- `META/review_log/Runtime_periodic_recovery_20260527.md`

Next likely task:

- Decide whether to do a small runtime reflection later for the wrapper
  guidance after the current active run completes.
- Longer-term SQLite access hardening remains a later candidate, not an
  immediate blocker.

## 2026-05-31 runtime stop and lock ops helper

SubTask-runtime-stop-and-lock-ops-helper was completed and adopted.

Product main includes:

- `SubTask: add runtime stop and lock ops helper (#76)`

Adopted behavior:

- `runtime/control/stop_after_current` keeps the existing safe article-boundary
  soft-terminate behavior.
- Empty, malformed, `0`, or `1` stop-file content is consumed as one soft stop
  and then removed.
- Natural numbers `N >= 2` are consumed once and rewritten as `N - 1`.
- Large stop counts are clamped to `255`.
- Missing stop file preserves the existing non-stop behavior.

New helper:

- `tools/runtime_periodic_ops.sh`

The helper supports bounded operator commands for:

- runtime status
- stop-once
- stop-count
- show-stop
- clear-stop
- guarded clear-lock

Validation:

- both child product repositories were synced to product main
- `./validate_helix.sh` passed after adoption
- final observed validation:
  - Copilot: 456 tests passed
  - Cursor: 456 tests passed

Runtime:

- a live runtime run consumed `runtime/control/stop_after_current`
- the current article was allowed to finish
- the run ended without leaving the stop file behind
- runtime reflection can proceed after confirming no active scrape-like process
  and no `periodic_once.lock`

Autonomous Copilot pilot note:

- this task tested allowing Copilot to create a branch, implement, report,
  commit, and push
- the pilot was mostly successful
- Copilot temporarily created `.vscode/settings.json`; it was removed before
  adoption
- future autonomous prompts should forbid leaving `.vscode/` workspace settings
  behind
- future prompts should prefer container-aware validation for runtime-like
  Python behavior when available

Review log:

- `META/review_log/SubTask_runtime_stop_and_lock_ops_helper_20260531.md`

## 2026-05-31 editor-agent validation and helper guidance

WorkflowTask-editor-agent-validation-and-helper-guidance was completed.

Purpose:

- make validation and review collection more loosely coupled
- help editor AIs validate or inspect a single child repository
- preserve existing root helper no-argument behavior
- add short AI-facing reminders to common review output

Root/meta changes:

- `META/scripts/validate_helix.sh` now accepts an optional target:
  - no argument: validate both child repos as before
  - `copilot`: validate only `copilot/`
  - `cursor`: validate only `cursor/`
- `META/scripts/collect_task_review.sh` now accepts an optional target:
  - no argument: collect both child repos as before
  - `copilot`: collect only `copilot/`
  - `cursor`: collect only `cursor/`
- root collect output now includes short `AI-HINT` reminders
- `NO_AI_HINT=1` suppresses those hints

Child helper additions:

- `validate.sh`
- `collect_repo_review.sh`

The helper scripts are child-repo-local and can be run inside either product
repository after main synchronization.

Validation behavior:

- child-local validation uses the established container-oriented validation
  path
- editor AIs are reminded not to invent host venv or pip-install flows

Adoption / synchronization:

- Copilot received the helper files first through a product PR
- Cursor received the same helper files by pulling product main after adoption
- root/meta helper behavior preserves fallback behavior for child repos without
  local helper scripts

Safety boundaries:

- no product runtime behavior was changed
- no scrape behavior was changed
- no DB, cron, Docker, or runtime checkout was modified
- no existing product code was edited for this workflow task

Review log:

- `META/review_log/WorkflowTask_editor_agent_validation_and_helper_guidance_20260531.md`

## 2026-06-03 dev web smoke sample DB entrypoint

SubTask-dev-web-smoke-sample-db-entrypoint was completed and adopted.

Product main includes:

- `SubTask: add dev web smoke sample DB check (#79)`

Purpose:

- add a child-repo-local read-only helper for checking whether the distributed
  Dev sample DB is suitable for lightweight Web smoke checks
- reduce confusion from stale, missing, oversized, or wrong DBs during
  Web/DB-facing development review
- keep sample DB extraction and distribution owned by root/meta
  `RuntimeOps-build-dev-sample-db`

Adopted helper:

- `tools/dev_web_smoke.sh`

Default DB path:

- `runtime/data/nicodic.db`

Behavior:

- opens the DB read-only
- checks required Web-facing tables
- checks non-zero article, response, target, active target, and titled article
  counts
- checks that `article_id=5511090`, `article_type=a` responses are absent
- checks the per-article response cap expectation
- prints `smoke_ready=yes` when the DB is suitable for smoke checks
- fails with guidance pointing back to root/meta sample DB builder when the DB
  is missing or unsuitable

Safety boundaries:

- no full runtime DB copy
- no production DB backup
- no live scraping
- no schema migration
- no Web behavior redesign
- no runtime checkout edits
- no cron, Docker, or DB modification

Validation:

- Copilot and Cursor were synced to product main after merge
- `./validate_helix.sh` passed
- final observed validation:
  - Copilot: 458 tests passed
  - Cursor: 458 tests passed
- Copilot-side `tools/dev_web_smoke.sh` passed against
  `runtime/data/nicodic.db` with `smoke_ready=yes`

Review log:

- `META/review_log/SubTask_dev_web_smoke_sample_db_entrypoint_20260603.md`

## 2026-06-10 sqlite read boundary and response semantics

MainTask-sqlite-read-boundary-and-response-semantics was completed.

Adopted implementation:

- Cursor

Non-adopted implementation:

- Copilot retained as comparison evidence and pushed to remote branch

Hybrid:

- Not selected because Cursor's final implementation passed validation and no
  Copilot change had a clear additional benefit worth manual integration risk.

Product main includes:

- `MainTask: clarify SQLite read boundaries (#80)`

Purpose:

- clarify SQLite read/write boundaries
- reduce logically read-only paths that call schema-initializing `init_db(...)`
- preserve strict archive-critical writes
- preserve existing telemetry lock-tolerance behavior
- make current Registered Articles response-count semantics honest

Adopted behavior:

- selected read-like paths now use a read-only SQLite helper
- write paths remain on `init_db(...)`
- current Registered Articles saved-row `MAX(res_no)` is labeled
  `Saved Max Res No`
- current `Saved Max Res No` remains derived from saved `responses` rows
- true board-observed Max Res No persistence is deferred

Important semantic note:

The future desired user-facing model is:

- `Saved Responses`: how far the archive has actually saved board responses
- `Max Res No`: the latest/final response number observed on the board when the
  article top or scrape path observed board state

That future `Max Res No` is not yet implemented because it needs an explicit
persistence seam and likely schema evolution.

Validation completed:

- `compare_helix.sh --all`: PASS
- `validate_helix.sh`: PASS
- Copilot: 464 tests passed
- Cursor: 464 tests passed
- Copilot and Cursor converged on product main commit `05777fa`

Review log:

- `META/review_log/MainTask_sqlite_read_boundary_and_response_semantics_20260610.md`

Runtime reflection:

- allowed after confirming no periodic lock, no soft stop file, and no
  scrape-like process

## 2026-06-23 registered list page-first query

SubTask-BugFix-registered-list-page-first-query was completed and adopted.

Product main includes:

- `294fdfc SubTask-BugFix: speed up registered list page query (#81)`

Purpose:

- fix production-sized DB latency on `/registered`
- avoid full `responses` aggregation before pagination for non-aggregate sorts
- restore runtime usability of Registered Articles without schema migration

Adopted behavior:

- `created_at`, `last_scraped_at`, `title`, and `article_id` sorts use a
  page-first query shape
- response stats are fetched only for displayed page identities on fast-path
  sorts
- `saved_response_count` and `saved_max_res_no` sorts remain correctness-first
  aggregate sorts
- true observed-board Max Res No remains deferred

Validation:

- `compare_helix.sh --all`: PASS
- `validate_helix.sh`: PASS
- Copilot: 468 tests passed
- Cursor: 468 tests passed

Runtime reflection:

- soft terminate succeeded before reflection
- runtime checkout updated to `294fdfc`
- runtime container recreated
- web root `/` returned HTTP 200
- text download succeeded
- `/registered` rendered in browser
- Registered Articles page showed count 12235 and rows 1-100

Known limitation:

- local curl with 30 second timeout still timed out during immediate
  post-reflection probes
- browser rendering remains slow
- this is a successful usability recovery, not the final DB performance solution

Review log:

- `META/review_log/SubTask_BugFix_registered_list_page_first_query_20260623.md`

Follow-up:

- materialized saved response summary remains a future DB task
- Registered Articles latency should continue to be improved

## 2026-06-23 runtime scrape cron tuning

Runtime scrape cron schedule was adjusted after the archive had largely
converged.

New schedule:

- 00:05 default, 1200 seconds
- 01:05 reverse, 8400 seconds
- 04/07/10/13/16/19:05 random_rotation, 8400 seconds

Reasoning:

- default pass is now a light daily check
- reverse pass is used to pick up recently registered targets
- random_rotation continues smoothing the archive through the day
- 03:05 random was avoided because 01:05 reverse may run until about 03:25

No product code or runtime DB changes were made.

Review log:

- `META/review_log/Runtime_cron_scrape_schedule_tuning_20260623.md`

Future candidate:

- DeleteFeeder-prioritized scrape mode for existing articles that receive delete
  requests

## 2026-06-24 WorkflowTask: streamline adoption-runtime-meta-ops procedure

Purpose:

- reduce recurring operational mistakes in the adoption → runtime reflection →
  META record workflow
- document the full end-to-end procedure in one local reference

What changed:

- added `META/procedures/adoption_runtime_meta_ops.md`
  - covers Cursor-only SubTask, WorkflowTask, DHM MainTask adoption
  - covers non-adopted candidate branch push as evidence
  - covers child repo synchronization after product PR merge
  - covers compare_helix / validate_helix timing
  - covers runtime reflection pre-check
  - covers soft terminate usage and common mistakes
  - covers runtime checkout pull / runtime_up
  - covers web smoke checks
  - covers cron-only runtime operations and when to record in META
  - covers META review log creation
  - covers PROJECT_STATE append (root repo only)
  - covers export_snapshot
  - covers META commit/push
  - covers final clean status check
  - includes explicit warnings for all recently observed mistake patterns

No product code, runtime, DB, cron, or child repo files were modified.

## 2026-06-25 MainTask048 materialized article response summary

MainTask048-materialized-article-response-summary was completed.

Adopted implementation:

- Cursor

Non-adopted implementation:

- Copilot was retained and pushed as comparison evidence.

Hybrid:

- Not selected because the key difference was semantic design, not a narrow
  isolated implementation detail.

Product behavior:

- added `article_response_stats` as a materialized saved-response summary table
- Registered Articles reads saved response stats from summary data
- `saved_response_count` and `saved_max_res_no` sorts use summary data
- `save_to_db` maintains per-article saved response summary
- operator rebuild/backfill command added

Operator command:

- `python main.py operator stats rebuild-response-summary --db PATH`
- `python main.py operator stats rebuild-response-summary --db PATH --apply`

Semantic decision:

- Saved Responses = number of saved response rows
- Saved Max Res No = raw max saved `res_no`
- no saved rows means NULL at storage level
- checked-zero display behavior remains read/display policy
- true observed-board Max Res No remains deferred

Validation:

- sample DB rebuild dry-run/apply succeeded
- sample rehearsal DB was removed
- post-merge `compare_helix.sh --all` passed
- post-merge `validate_helix.sh` passed
- copilot: 484 tests passed
- cursor: 484 tests passed

Runtime:

- runtime reflection completed after confirming no active scrape work
- runtime checkout fast-forwarded to product main
- runtime container recreated with `tools/runtime_up.sh`
- runtime DB rebuild dry-run completed
- runtime DB rebuild apply completed
- post-apply summary rows: 12109
- post-apply articles: 12235
- post-apply responses: 13131174

Runtime Web result:

- browser verification succeeded for Registered Articles default view
- browser verification succeeded for Saved Max Res No descending sort
- local curl with 30 second timeout still timed out
- browser rendering was roughly 20 to 30 seconds by human observation
- this is functional for personal use but still a performance follow-up area

Operational note:

- no full runtime DB backup was created for this task
- the operation wrote derived/rebuildable summary data only
- no temporary rehearsal DB or backup DB remained after the work

Review log:

- `META/review_log/MainTask048_materialized_article_response_summary_20260625.md`

Follow-up:

- inspect Registered Articles query plan and possible indexes
- add summary drift diagnostics
- later implement true observed-board Max Res No persistence

## 2026-06-26 MainTask049 registered articles latency

MainTask049-registered-articles-latency-index-and-query-shape was completed.

Adopted implementation:

- Copilot

Non-adopted implementation:

- Cursor was retained and pushed as comparison evidence.

Hybrid:

- Not selected.

Product behavior:

- added `idx_articles_type_canonical_url_id`
  - `articles(article_type, canonical_url, id)`
- added `idx_target_active_created_at_id`
  - `target(is_active, created_at, id)`
- replaced the correlated canonical URL fallback lookup with a
  `url_fallback_articles` CTE
- preserved deterministic earliest-row fallback with `MIN(id)`
- added a no-search count fast path:
  - `SELECT COUNT(*) FROM target WHERE is_active = 1`
- preserved Registered Articles labels and public behavior
- preserved `Saved Responses` / `Saved Max Res No` saved-response semantics
- did not implement true observed-board Max Res No

Validation:

- pre-adoption Copilot validation passed
  - 486 tests passed
- pre-adoption Cursor validation passed
  - 492 tests passed
- post-merge `compare_helix.sh --all` passed
- post-merge `validate_helix.sh` passed
  - copilot: 486 tests passed
  - cursor: 486 tests passed

Runtime reflection:

- runtime reflection completed after confirming no active scrape work
- runtime checkout fast-forwarded to product main
- runtime container recreated with `tools/runtime_up.sh`
- explicit runtime `init_db('/app/data/nicodic.db')` was required to create the
  new indexes on the existing runtime DB

Runtime EXPLAIN result:

- `articles` changed from scan to:
  - `SEARCH articles USING COVERING INDEX idx_articles_type_canonical_url_id`
- `target` changed from scan to:
  - `SEARCH target USING INDEX idx_target_active_created_at_id`

Runtime Web timing after reflection:

- default Registered Articles:
  - `http=200`
  - `time=0.106639`
- Saved Max Res No descending:
  - `http=200`
  - `time=0.094546`
- Saved Responses descending:
  - `http=200`
  - `time=0.072703`

Result:

- before MainTask049, Registered Articles took roughly 20 to 30 seconds and
  curl with a 30 second timeout could fail
- after MainTask049, default and aggregate sort views returned in about 0.1
  seconds
- browser display and sorting were confirmed by the user to feel effectively
  instant

Operational note:

- no full runtime DB backup was created
- no `responses` table index was added
- no archive-critical data rewrite was performed
- runtime final status had no lock, no soft-stop, and no scrape-like process

Review log:

- `META/review_log/MainTask049_registered_articles_latency_index_and_query_shape_20260626.md`

Follow-up:

- true observed-board Max Res No semantics
- optional operator/runtime schema ensure command for future schema/index changes
- optional Registered Articles EXPLAIN diagnostics

## 2026-06-26 MainTask050 observed board max response number

MainTask050-observed-board-max-res-no-persistence-and-display was completed.

Adopted implementation:

- Cursor with one hybrid adjustment from Copilot

Non-adopted implementation:

- Copilot was retained and pushed as comparison evidence.

Hybrid adjustment:

- Cursor was used as the base implementation.
- Copilot's `saved_rows_fallback` behavior was ported into the already-up-to-date scrape path.

Product behavior:

- added target-side observed board max response number persistence
- added nullable target columns:
  - `observed_max_res_no`
  - `observed_max_res_no_at`
  - `observed_max_res_no_source`
- article registration can persist observed max from article top preview
- scrape flow persists observed max from BBS page responses
- already-up-to-date scrape flow persists saved rows max as a lower-bound observation
- update rule is monotonic and never lowers stored observed max
- Registered Articles UI replaced `Saved Max Res No` with `Observed Max Res No`
- Registered Articles page CSV replaced `saved_max_res_no` with `observed_max_res_no`
- `saved_max_res_no` remains internal in `article_response_stats`
- `article_response_stats` saved-response semantics were preserved

Validation:

- Cursor branch validation after hybrid adjustment passed
  - 513 tests passed
- post-merge `compare_helix.sh --all` passed
- post-merge `validate_helix.sh` passed
  - copilot: 513 tests passed
  - cursor: 513 tests passed

Runtime reflection:

- runtime reflection completed after confirming no active scrape work
- runtime checkout fast-forwarded to product main
- runtime container recreated with `tools/runtime_up.sh`
- explicit runtime `init_db('/app/data/nicodic.db')` was required to add the new target columns to the existing runtime DB

Runtime schema verification:

- `observed_max_res_no`
- `observed_max_res_no_at`
- `observed_max_res_no_source`

Runtime Web verification:

- default Registered Articles returned in about 0.09 seconds
- `observed_max_res_no` descending sort returned in about 0.09 seconds
- legacy `saved_max_res_no` sort alias returned in about 0.09 seconds
- UI displayed `Observed Max Res No`
- UI no longer displayed `Saved Max Res No`
- CSV header included `observed_max_res_no`
- CSV header no longer included `saved_max_res_no`

Runtime data observation:

- existing targets initially had NULL observed max values, as expected
- a newly registered Linux article immediately showed `Observed Max Res No = 207`
- this confirmed the article-top preview registration path in practice
- periodic random-start scraping should gradually populate existing targets

Operational note:

- no full runtime DB backup was created
- no 20GB-class DB copy was made
- no `responses` table index was added
- no archive-critical data rewrite was performed
- runtime final status had no lock, no soft-stop, and no scrape-like process

Review log:

- `META/review_log/MainTask050_observed_board_max_res_no_20260626.md`

Follow-up:

- after the next periodic scrape cycle, verify that existing target observed values begin filling
- optional bounded operator to initialize NULL observed max from saved summary rows
- optional coverage ratio display or operator inspection for observed source/timestamp

## 2026-06-27 SubTask: meta report and snapshot artifact policy cleanup

Purpose:

- make root/meta artifact policy consistent (Option A)
- raw editor task reports are temporary working artifacts, not long-term memory
- durable task memory lives in META/review_log, PROJECT_STATE.md, and curated
  META files
- generated advisor handoff snapshots remain locally generatable but are no
  longer Git-tracked

Changes:

- root .gitignore now ignores generated snapshots and root-level raw reports:
  - /project_snapshot.txt
  - /project_knowledge_snapshot.txt
  - /review_snapshot*.txt
  - /*_report.txt
  - /*_report.md
- META/TASK_CYCLE_CHECKLIST.md: added authoritative "Raw report and
  generated-snapshot artifact policy (Option A)" section
- META/procedures/adoption_runtime_meta_ops.md: stop instructing humans to
  commit generated snapshot files; commit only source-of-truth META files

Git tracking cleanup (working tree retained for snapshots only):

- git rm --cached project_snapshot.txt project_knowledge_snapshot.txt
  (local files kept; now gitignored)
- git rm of root-level tracked raw reports:
  - MetaTask-optimizing-metadata_report.md
  - RuntimeOps-build-dev-sample-db_report.txt
  - WorkflowTask-editor-agent-validation-and-helper-guidance_report.md
  - WorkflowTask-streamline-adoption-runtime-meta-ops_report.txt

Boundaries:

- only root/meta files touched
- copilot/, cursor/, runtime checkout, runtime DB, runtime logs, Docker, and
  cron were not touched

## 2026-06-27 - SubTask-runtime-batch-log-digest-default

Product main adopted `5039445` / PR #86, making batch run logs digest-first by default.

Operational impact:
- default batch logs no longer emit per-target `[PROGRESS = i/n]` blocks;
- `BATCH_LOG_VERBOSE=1` restores legacy verbose progress blocks for debugging;
- batch digest counters use compact `H/OK0/W/F/S/NEW/UOBS` keys;
- host_cron `[RUN DIGEST]` now includes `B`, `dur`, `end`, compact counters, and `P/T/R` when totals are available;
- host_cron OK0 per-target logging, heartbeat behavior, rotation, scraping semantics, and runtime DB behavior were intentionally unchanged.

Validation/adoption:
- `compare_helix.sh --all`: PASS;
- `validate_helix.sh`: PASS, 514 tests passed in both child repos;
- runtime checkout reflected to `5039445`;
- runtime container rebuilt and restarted;
- post-reflection runtime status showed no periodic lock and no scrape-like process.

Notes:
- The host `tools/verify.sh` currently fails with `python: command not found`; this was not considered a blocker for this task because product validation passed through the repo validation path.
- Existing batch logs generated before reflection still show the old long digest keys; new behavior starts with the next runtime run.

Next likely tasks:
- `SubTask-runtime-host-cron-ok0-heartbeat`;
- `SubTask-runtime-batch-runs-retention`;
- optional `SubTask-runtime-batch-digest-one-line`.

## 2026-06-28 - SubTask-runtime-host-cron-ok0-sum

Product main adopted `2ca9f8c`, summarizing host_cron clean OK0 output by default.

Operational impact:
- clean host_cron OK0 targets are now emitted as bounded `[OK0 SUM 🟢]` aggregate lines;
- per-target `[STEP OK0 🟢]` is suppressed by default;
- `HOST_CRON_OK0_MODE=line` restores legacy per-target OK0 output for debugging;
- `HOST_CRON_OK0_SUM_EVERY` controls count-based summary flushing and defaults/falls back to `250`;
- pending OK0 summaries flush before HIT/WARN/FAIL detail and before run end;
- HIT/WARN/FAIL diagnostic detail remains individually logged;
- RUN DIGEST counts remain available;
- batch log behavior, scraping semantics, runtime DB behavior, and host_cron rotation/retention were intentionally unchanged.

Validation/adoption:
- `compare_helix.sh --all`: PASS;
- `validate_helix.sh`: PASS;
- copilot: 519 tests passed;
- cursor: 519 tests passed;
- runtime checkout reflected to `2ca9f8c`;
- runtime container rebuilt/recreated through the standard reflection flow;
- runtime logs confirmed real `[OK0 SUM 🟢]` output.

Observed behavior:
- `[OK0 SUM 🟢]` entries may have `cnt` below the configured threshold when flushed before non-OK detail. This is expected and preserves chronological context.
- recent batch logs are now much smaller after the previous digest-first task, while failure and digest detail remain available.

Next likely task:
- `SubTask-runtime-batch-runs-retention` to archive/compress historical `runtime/logs/batch_runs/batch_*.log` files by mtime.

## 2026-06-28 - SubTask-runtime-batch-runs-retention completed

Product main adopted `20659af`, adding weekly archive/compression for old
`runtime/logs/batch_runs/batch_*.log` files aligned with the existing
host_cron log hygiene model.

Operational impact:
- recent batch run logs remain plain for readability;
- older batch run logs are grouped by calendar week using file mtime;
- archives are written as `runtime/logs/batch_runs/batch_runs.YYYYMMDD-YYYYMMDD.tar.gz`;
- original `.log` files are removed only after successful archive creation;
- compressed archives are retained indefinitely for now;
- existing host_cron daily/weekly rotation behavior remains unchanged.

Digest usability:
- runtime log hygiene now maintains `runtime/logs/README.log`;
- runtime log hygiene now maintains `runtime/logs/batch_runs/README.log`;
- these files contain `DIGEST EXP` lines explaining compact keys such as B/dur/end/H/OK0/W/F/S/NEW/UOBS/P/T/R;
- this keeps `grep DIGEST *.log` useful even after the compact key meanings are forgotten.

Validation/adoption:
- `compare_helix.sh --all`: PASS;
- `validate_helix.sh`: PASS;
- copilot: 526 tests passed;
- cursor: 526 tests passed;
- runtime checkout reflected to `20659af`;
- runtime container rebuilt/recreated through the standard reflection flow;
- runtime log hygiene confirmed README.log digest explanations after reflection;
- batch_runs weekly archives were created for eligible historical logs.

Boundaries:
- no scrape behavior change;
- no batch log emission behavior change;
- no host_cron rotation policy change;
- no cron/Docker config change;
- no runtime DB or runtime/data cleanup.

Next likely tasks:
- optional archive-expiry policy for old `.tar.gz` files;
- zero-page unknown success classification;
- manual cleanup of stale local/generated root files such as `Issues.txt`.

## 2026-06-30 SubTask-hotword-target-feeder

Purpose:
- Add a bounded feeder for recent "今週のニコニコ大百科 HOTワード" best3 article URLs.

Adopted behavior:
- Cursor-only implementation adopted.
- Adds `hotword_feeder.py`.
- Extracts only recent best3 data-row rank-cell article links.
- Uses default recent-week bound of 12.
- Deduplicates candidates in first-seen order.
- Reuses the existing target registration boundary.
- Does not directly insert into target tables.
- Integrates near the existing Delete Feeder shot-start feeder phase.
- Adds bounded scan-only inspect command `inspect-hot-word-target-feed`.

Validation:
- Pre-adoption `./validate_helix.sh cursor`: PASS, 538 passed.
- Post-adoption convergence/validation: to be filled after main sync.

Runtime reflection:
- Not yet performed in this step.

Review log:
- META/review_log/SubTask_hotword_target_feeder_20260630.md

## 2026-06-30 SubTask-compact-zero-response-bbs-ok0

Purpose:
- Reduce host_cron log noise from successful zero-response BBS checks.

Adopted behavior:
- Cursor-only implementation adopted.
- Product main commit: 501617a496cff38a3cb2284eddfa2a44070fe32b
- Adds explicit `zero_response_checked` reason for successful first-time zero-response BBS checks.
- Folds explicit `zero_response_checked` results into OK0 SUM in host_cron compact mode.
- Keeps existing `already_up_to_date` strict OK0 behavior unchanged.
- Keeps generic `reason=ok` visible.
- Keeps later-page interruption as WARN/partial.
- Keeps stored_new>0 as HIT.
- Does not skip future scraping; reopened boards or newly posted responses remain collectible.

Validation:
- `compare_helix.sh --all`: PASS.
- `validate_helix.sh`: PASS.
- Test count: 541 passed for copilot and 541 passed for cursor.

Runtime reflection:
- Not yet performed for this SubTask.

Review log:
- META/review_log/SubTask_compact_zero_response_bbs_ok0_20260630.md
