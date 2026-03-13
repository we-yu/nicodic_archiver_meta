# Medium-Term Direction

Planning guidance for the next few tasks.

--------------------------------------------------

## Purpose

This file stores a **medium-term task direction** for the project.

It is intended to reduce repeated planning overhead between adjacent tasks
while keeping task scope bounded and practical.

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

The current near-term goal is still aligned with the first product goal:

> save bulletin-board comments correctly for a broad range of Nico Nico Pedia articles

This includes explicit handling for cases such as:

- article not found
- no bulletin-board responses
- other bounded edge or failure cases

--------------------------------------------------

## Near-term task direction

### TASK009 direction
Bounded orchestration-flow hardening for:

- article not found
- no-BBS / zero-response
- representative edge-case handling

Expected shape:

- `orchestrator.py` centered production hardening
- focused tests
- clear scope / non-goals
- no redesign

Current intended scope:

Included:
- explicit handling for article not found
- explicit handling for no-BBS / zero-response
- `orchestrator.py` centered flow hardening
- focused tests

Excluded:
- large-thread cutoff / block policy
- malicious content sanitization policy
- parser redesign
- storage redesign
- full failure-classification design

### TASK010 direction
Bounded follow-up on failure-result handling, only if still needed after TASK009.

Expected shape:

- small cleanup of flow-level result handling
- no frameworkization
- no broad abstraction layer
- keep current architecture intact

### TASK011 direction
Large-thread / high-volume handling policy, if real implementation pressure still exists.

Expected shape:

- bounded operational protection
- explicit thresholds or stop conditions only if justified
- no scheduler or batch expansion yet

### TASK012 direction
Representative regression protection strengthening, after the main single-article path is stable.

Expected shape:

- focused regression coverage
- no test-only drift
- tied directly to already-adopted production behavior

--------------------------------------------------

## Planning rules

When defining the next task, prefer:

- small bounded tasks
- production-facing progress over abstract cleanup
- explicit scope / non-goals
- preservation of current architecture
- reviewable changes that fit the Double Helix model

Avoid:

- cross-layer redesign
- framework-first abstraction
- broad speculative refactors
- turning every follow-up into a test-only task
- silently widening the task after implementation starts

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
or newly observed risks justify a change.

--------------------------------------------------

## Relationship to the roadmap

`META/ROADMAP_REFERENCE.md` remains the broader and weaker direction document.

This file is closer to actual task planning, but still not authoritative current state.

A good rule of thumb:

- roadmap = broad reference
- medium-term direction = working near-term plan
- state files + snapshots = authoritative truth


