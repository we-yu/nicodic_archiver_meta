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

TASK033 and TASK033b are complete.

A roadmap reference exists for future-direction context only:

META/ROADMAP_REFERENCE.md

A medium-term direction reference also exists for near-term planning continuity:

META/MEDIUM_TERM_DIRECTION.md

Important:

- this planning guidance is not authoritative current state
- authoritative current state must still be restored from:
  - AI_CONTEXT.md
  - PROJECT_STATE.md
  - WORKSPACE.md
  - latest snapshot files
