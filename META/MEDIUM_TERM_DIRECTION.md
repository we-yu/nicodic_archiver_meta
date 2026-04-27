# Medium-Term Direction

Planning guidance for the next several tasks.

--------------------------------------------------

## Purpose

This file stores a **medium-term task direction** for the project.

It is intended to reduce repeated planning overhead between adjacent tasks
while keeping task scope bounded, practical, and aligned with
actual product progress.

This file is:

- stronger than the roadmap reference
- weaker than authoritative current-state files
- a planning guide for the next several tasks

This file is **not**:

- the authoritative source of current project state
- a fixed task order
- a guarantee that every listed task will be executed unchanged

Authoritative current state must still be restored from:

- `AI_CONTEXT.md`
- `PROJECT_STATE.md`
- `WORKSPACE.md`
- latest snapshot files

If any conflict exists, prefer the authoritative current-state files.

--------------------------------------------------

## Current planning stance

The project should continue to respect the current module boundaries unless
a later task explicitly changes architecture.

Current baseline:

- `main.py` = CLI entry
- `orchestrator.py` = scraping flow / save-order orchestration
- `archive_read.py` = archive-facing read / export seam
- `http_client.py` = HTTP fetch layer
- `parser.py` = HTML parsing
- `storage.py` = persistence
- `target_list.py` = plain-text target source handling

The bounded Web publication/runtime baseline now exists.

The current near-term planning direction should therefore shift away from
"making the Web app exist" and toward a bounded data/source-of-truth phase.

Priority for the next medium-term phase:

1. preserve already-adopted scrape / archive / Web/runtime correctness
2. migrate the scrape target source of truth away from the provisional
   plain-text target list
3. add bounded operator-facing management / inspection around target state
   and saved archive state
4. defer broader UI polish / extra download-surface expansion until later
   needs become clearer
5. treat log-hygiene / human-friendly logging improvements as a likely
   side-flow area after the next mainline data tasks, unless they require
   product-schema or product-facing interface changes

This means the project should now prefer:

- DB-backed target registry migration
- bounded operator-facing target / archive inspection and management
- keeping SQLite acceptable unless a later task proves a stronger DB change is
  necessary
- later side-flow work for runtime-log hygiene and human-friendly summaries

over:

- keeping the plain-text target list as the long-term source of truth
- premature DB engine replacement
- premature DB containerization as required scope
- premature pgAdmin-like integration as required scope
- premature observability/dashboard/platform expansion
- premature broad UI polish before the next data-handling baseline is in place
- prematurely fixing later mixed-scope polish tasks

--------------------------------------------------

## Near-term task direction

### TASK031 direction
Completed.

Outcome summary:

- the scrape target source of truth was migrated away from the provisional
  plain-text target list and into a bounded SQLite-backed target registry
- the already-adopted archive/save/read/runtime baseline was preserved
- canonical article identity handling was preserved
- the task remained centered on target-registry ownership rather than broad DB
  platform redesign
- SQLite remained acceptable in this task
- PostgreSQL migration was not required
- DB containerization was not required
- pgAdmin-like GUI integration was not required

Interpretation:

- the long-term role of the plain-text target list as source of truth has ended
  in mainline flow
- later operator-facing tooling can now build on the bounded target registry
  baseline rather than on the provisional text file

### TASK032 direction
Bounded operator-facing target / archive management seam.

Interpretation after TASK031 and TASK031B:

- target source-of-truth migration is already complete
- bounded append-only telemetry insertion is already complete
- TASK032 should not re-do either of those
- TASK032 should instead focus on practical operator-facing inspection /
  management over:
  - the DB-backed target registry
  - saved archive state

Expected shape:

- add bounded operator-facing inspection / management capability for:
  - the DB-backed target registry
  - saved archive state
- support practical listing / confirmation / minimal operator actions
- keep the task single-operator-friendly
- allow future GUI inspection compatibility to be considered, but keep external
  GUI / admin tool integration optional and non-authoritative
- do not turn the task into a full admin console
- do not turn the task into broad CRUD-platform design
- do not turn the task into telemetry / dashboard work yet

Preferred direction:

- make the post-TASK031B data model practically inspectable and manageable
- keep the operator seam small and explainable
- preserve the existing Web/runtime/archive boundaries as much as possible
- prepare later observability or export follow-ups without forcing them into
  this task

--------------------------------------------------

## Side-flow note after TASK032

After the mainline reaches the TASK032 baseline, log-hygiene / human-friendly
logging improvements are currently expected to branch as side-flow SubTask work
rather than being treated as the next fixed mainline task.

Expected examples:

- log retention / compression / rotation
- human-friendly runtime-log organization
- helper scripts or derived summaries for operational inspection
- runtime-checkout-local improvements that do not need to become immediate
  product source-of-truth changes

Important:

- this side-flow is not automatically a numbered mainline TASK
- if a later observability design requires product DB schema or product-facing
  interfaces, that part should be reconsidered as a bounded mainline task
- raw logs may remain available even when derived summaries are added

--------------------------------------------------

## Unfixed later-task note

A later task sometimes informally referred to as "TASK034"
should not be fixed yet.

Reason:

- after TASK031 / TASK032 and the later log-side improvements,
  the remaining UI / polish / export-format needs are expected to become
  clearer
- forcing that task shape now would likely produce a mixed-scope task

Current rule:

- do not pre-fix the later UX / polish / extra-download task boundary yet
- re-slice it after the post-TASK032 picture is clearer

--------------------------------------------------

## Next medium-term phase framing

The next medium-term phase should aim to move the product from:

- a bounded DB-backed target-registry baseline
- a bounded append-only telemetry baseline

toward:

- bounded operator-facing target / archive management
- later optional runtime-log side-flow improvements

Target outcome for this phase:

- target identity remains managed through the DB-backed registry
- append-only telemetry remains available as a bounded support layer
- operator-facing inspection / management of targets becomes practical
- saved archive state remains available and inspectable
- the existing Web/runtime/archive behavior remains preserved
- broader UI polish / richer download formats may still remain deferred
- large observability / dashboard / analytics expansion remains deferred

Interpretation note:

- this phase framing is planning guidance, not authoritative current state
- exact task boundaries may still be adjusted if review evidence suggests a
  better bounded split
- keep "operator-facing management next, broader polish later"
  as the main directional rule

--------------------------------------------------

## Planning priority

Recommended working order:

1. `TASK040: canonical URL identity merge`
   - immediate correctness / maintenance task
   - merge duplicate archive identities that share the same `canonical_url`
   - preserve old numeric-identity responses before removing duplicate rows
   - validate on copied DB state before touching runtime DB
   - keep runtime periodic cron paused until migration and smoke checks pass

2. `SUBTASK011: script workflow hygiene and AI reminder helpers`
   - root/meta workflow improvement task
   - add or improve mechanical line-length / EOF helper checks
   - improve discoverability of low-frequency workflow scripts for future AI
     sessions
   - optionally add target selection to frequent root workflow helpers
   - keep this separate from product DB migration work

3. `SUBTASK012: compact scrape progress logging`
   - runtime/logging improvement task
   - compact repetitive successful BBS page progress lines
   - preserve warning/error detail visibility
   - improve long-log readability for both humans and AI review

This order is recommended because:

- current runtime archive state has an active identity split that can cause
  duplicate saved article rows and wasted scrape work
- DB identity merge is more urgent than workflow-polish or log-size work
- script hygiene is useful but should not be mixed with archive migration
- compact logging is valuable but safer after archive identity behavior is
  stable again

--------------------------------------------------

## Planning rules

When defining the next task, prefer:

- small bounded tasks
- source-of-truth hardening before broader polish
- explicit scope / non-goals
- preservation of current architecture unless a task explicitly changes it
- reviewable changes that fit the Double Helix model
- keeping side-flow work separate when it does not need to alter product
  source-of-truth or product-facing interfaces

Avoid:

- cross-layer redesign
- framework-first abstraction
- broad speculative refactors
- silently widening the task after implementation starts
- premature DB engine / platform replacement
- prematurely fixing late-stage UX / polish tasks before the actual pain points
  are clearer

--------------------------------------------------

## Prompt-design implication

For tasks guided by this file:

- strongly define `What`
- keep review criteria explicit
- leave reasonable freedom in `How`

Do not over-fix:

- helper split
- fixture layout
- assertion grouping
- exact naming
- internal implementation shape

The goal is to preserve solution diversity
while still preventing task drift.

--------------------------------------------------

## Review and update rule

This file should be reviewed after each completed task.

Possible outcomes after a task completes:

- keep the current medium-term direction
- reorder upcoming likely tasks
- narrow or widen a future task boundary
- remove items that are no longer useful
- insert a newly needed bounded task between listed items
- move a later concern out of the mainline and into side-flow planning
  if that improves boundedness

The human developer and advisor AI may revise this file when implementation
results or newly observed constraints justify a change.

--------------------------------------------------

## Relationship to the roadmap

`META/ROADMAP_REFERENCE.md` remains the broader and weaker direction document.

This file is closer to actual task planning, but still not authoritative
current state.

A good rule of thumb:

- roadmap = broad reference
- medium-term direction = working near-term plan
- state files + snapshots = authoritative truth
