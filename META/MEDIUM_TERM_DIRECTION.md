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
- `http_client.py` = HTTP fetch layer
- `parser.py` = HTML parsing
- `storage.py` = persistence

The current near-term product direction remains:

> save bulletin-board comments correctly for a broad range of Nico Nico Pedia articles

The next planning phase should now shift from repeated single-article hardening
toward **bounded functional expansion**.

Priority for the next medium-term phase:

1. preserve already-adopted single-article correctness
2. move into practical user-facing functionality
3. support real operational usage
4. preserve Double Helix comparison value
5. avoid endless infrastructure-first hardening

This means the project should now prefer:

- representative regression protection
- target-list based operation
- batch execution
- run visibility
- periodic execution entrypoints
- usable archive readout / export

over:

- broad frameworkization
- large retry/backoff systems
- full failure-taxonomy expansion
- heavy scheduler design
- speculative security/platform work not yet required
- premature Web/API formalization

--------------------------------------------------

## Near-term task direction

### TASK012 direction
Representative regression protection strengthening for the
already-adopted main single-article path.

Expected shape:

- focused regression coverage
- tied directly to already-adopted production behavior
- centered mainly on `tests/test_orchestrator.py`
- no test-only drift
- no broad redesign

Main representative coverage should include:

- article not found
- no-BBS / zero-response
- later-page interruption
- known high-volume skip
- response-cap reached
- normal save path

### TASK013 direction
Target-list definition and loading.

Expected shape:

- introduce a minimal target-list format for practical use
- keep the format simple and human-editable
- support bounded loading into the current CLI/application flow
- no general config framework yet
- no scheduler expansion yet

Preferred direction:

- start with a small file-based target list
- keep required fields minimal
- favor practical operation over abstract flexibility

### TASK014 direction
Batch scrape command.

Expected shape:

- bounded multi-target execution using the target list
- reuse the existing single-article scrape flow
- no parallel/distributed execution yet
- no retry framework expansion yet
- keep behavior reviewable and CLI-centered

Preferred direction:

- add a practical batch entrypoint
- keep execution flow simple
- preserve child-repo reviewability under Double Helix

### TASK015 direction
Scrape run logging / status recording.

Expected shape:

- minimal run-level recordkeeping
- enough visibility for practical repeated usage
- no heavy observability framework
- no logging subsystem redesign

Preferred direction:

- store only the minimum useful run facts
- make later inspection practical
- support future periodic execution without overbuilding

### TASK016 direction
Periodic execution entrypoint.

Expected shape:

- provide a stable entrypoint for repeated execution
- remain compatible with lightweight external scheduling
- do not expand into a large scheduler framework
- do not turn this task into deployment architecture work

Preferred direction:

- support “run this set regularly”
- keep implementation bounded and CLI-oriented
- defer complex scheduling policy

### TASK017 direction
Archive export / readout command.

Expected shape:

- make saved data easier to use directly
- provide one or more practical export/readout forms
- no Web UI requirement yet
- no presentation-layer framework yet

Preferred direction:

- improve actual usability of saved archives
- support human inspection and downstream use
- keep scope bounded and output-focused

### TASK018 direction
Target intake / add-target minimal command.

Expected shape:

- provide a minimal way to add future scrape targets
- remain bounded and file/CLI-based at first
- no queue system yet
- no request platform yet

Preferred direction:

- support real project usage
- keep target management simple
- defer generalized intake systems

### TASK019 direction
Bounded interface preparation for later Web/API expansion.

Expected shape:

- prepare cleaner seams for later external interfaces
- remain strictly pre-Web and pre-API
- do not introduce a full application framework yet
- do not start platform expansion prematurely

Preferred direction:

- clarify boundaries that future interfaces will need
- keep current architecture stable
- do only the minimum preparation justified by preceding tasks

--------------------------------------------------

## Planning priority

Recommended working order:

1. `TASK012` representative regression protection strengthening
2. `TASK013` target-list definition and loading
3. `TASK014` batch scrape command
4. `TASK015` scrape run logging / status recording
5. `TASK016` periodic execution entrypoint
6. `TASK017` archive export / readout command
7. `TASK018` target intake / add-target minimal command
8. `TASK019` bounded interface preparation for later Web/API

This order is recommended because it:

- closes the main single-article path first
- moves quickly into practical functionality
- supports real usage before platform expansion
- preserves bounded task size
- remains compatible with the Double Helix workflow

--------------------------------------------------

## Planning rules

When defining the next task, prefer:

- small bounded tasks
- production-facing progress over abstract cleanup
- explicit scope / non-goals
- preservation of current architecture
- reviewable changes that fit the Double Helix model
- practical functionality before platform expansion

Avoid:

- cross-layer redesign
- framework-first abstraction
- broad speculative refactors
- turning every follow-up into a test-only task
- silently widening the task after implementation starts
- endless hardening before useful features exist

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

The human developer and advisor AI may revise this file when implementation results
or newly observed constraints justify a change.

--------------------------------------------------

## Relationship to the roadmap

`META/ROADMAP_REFERENCE.md` remains the broader and weaker direction document.

This file is closer to actual task planning, but still not authoritative current state.

A good rule of thumb:

- roadmap = broad reference
- medium-term direction = working near-term plan
- state files + snapshots = authoritative truth


