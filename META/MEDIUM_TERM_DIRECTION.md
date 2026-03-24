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

The current near-term product direction should now shift from
personal-use CLI/runtime practicality toward a **bounded Web publication phase**.

Priority for the next medium-term phase:

1. preserve already-adopted scrape / archive correctness
2. reuse the current scrape and archive-read seams rather than redesign them
3. enable a minimal Web-facing request / retrieval flow
4. keep the phase practical and single-operator-friendly first
5. defer broader public-platform concerns until after bounded Web publication exists

This means the project should now prefer:

- article-input resolution
- non-CLI reuse of archive-read / export behavior
- minimal request queue persistence
- bounded queue-drain execution reusing current scrape flow
- minimal Web UI / frontend
- saved-article TXT download
- bounded Web runtime / publication packaging

over:

- broad frameworkization before the core flow exists
- auth / account systems
- multi-tenant or public-abuse policy design
- immediate multi-format export expansion
- storage redesign
- advanced scheduler / worker-platform design
- speculative platform abstraction not yet required

--------------------------------------------------

## Near-term task direction

### TASK024 direction
Article input resolution seam.

Expected shape:

- define a bounded resolution path from human input to a canonical article target
- support the future Web input shape:
  - article name text input
  - article URL input
- normalize successful resolution into data that existing scrape/read paths can use
- keep the task centered on resolution semantics rather than Web UI implementation
- do not turn the task into broad search-platform design

Preferred direction:

- make exact or practical bounded article resolution possible
- keep the output shape explainable and reusable
- prepare for later Web input without starting the Web app yet

### TASK025 direction
Archive-read / export reuse for non-CLI consumers.

Expected shape:

- make the already-adopted archive-read behavior easier to call outside the CLI
- support bounded checks such as:
  - is this article already saved?
  - if saved, return bounded TXT export content for one article
- keep the task centered on reuse of the current read seam
- do not broaden into multi-format export yet

Preferred direction:

- reuse `archive_read.py` more cleanly from later Web-facing code
- make saved-article TXT retrieval practical
- stay pre-frontend and pre-route for this task

### TASK026 direction
Minimal request queue persistence.

Expected shape:

- introduce a bounded persistence path for not-yet-saved article requests
- keep queue state minimal and explainable
- handle duplicate-enqueue concerns in bounded form
- keep the task small and avoid turning it into a job platform

Preferred direction:

- support “unsaved article → queue request” as a concrete next capability
- preserve the current architecture as much as possible
- defer advanced queue policy

### TASK027 direction
Queue-drain execution path.

Expected shape:

- provide a bounded way to drain queued article requests
- reuse the current scrape path for actual collection
- remain single-process / bounded in behavior
- do not introduce distributed worker design
- do not expand into scheduler-framework design

Preferred direction:

- make the queue operational rather than conceptual
- keep execution flow explainable
- preserve current scrape semantics

### TASK028 direction
Minimal Web app skeleton and frontend.

Expected shape:

- introduce a minimal Web-facing UI / frontend
- include:
  - article-name / article-URL input
  - submit button
  - bounded result display
- keep the UI practical and simple
- do not turn this into full design-system work
- do not introduce auth / account / public-product concerns yet

Preferred direction:

- make the product visibly usable as a Web app
- keep the frontend/operator flow very small
- defer visual polish and broader productization

### TASK029 direction
Saved → TXT download / unsaved → enqueue end-to-end flow.

Expected shape:

- implement the main bounded Web UX:
  - if already scraped, return TXT download
  - if not yet scraped, enqueue the request
- keep output format to `txt` only in this phase
- provide bounded user feedback for both outcomes
- do not expand into CSV / JSON / MD / HTML selection yet

Preferred direction:

- complete the core request/result loop
- keep the phase focused on one practical end-to-end behavior
- preserve boundedness over feature breadth

### TASK030 direction
Bounded Web runtime / publication packaging.

Expected shape:

- package the minimal Web app into a practical runtime/publication baseline
- support a small deployable shape for the current single-operator phase
- keep the deployment/runtime story concrete and explainable
- do not turn this into cloud-platform abstraction
- do not turn this into heavy ops/platform design

Preferred direction:

- make the bounded Web app actually publishable
- preserve the current project scale
- defer broader production-platform formalization until later

--------------------------------------------------

## Next medium-term phase framing

The next medium-term phase should aim to make the system
**publishable as a bounded Web application**.

Target outcome for this phase:

- a minimal Web app exists
- the UI includes an article-name or article-URL input path
- the UI includes a submit action
- if the requested article is already saved, the archive can be returned as
  a `txt` download
- if the requested article is not yet saved, the request can be queued
- queued requests can be drained using a bounded execution path that reuses
  the adopted scraping baseline
- the published runtime remains small, explainable, and operator-friendly
- broader third-party/public policy questions may remain undecided
- richer export formats such as `md`, `json`, `csv`, or simple `html`
  remain deferred until after the bounded Web baseline exists

Interpretation note:

- this phase framing is planning guidance, not authoritative current state
- exact task boundaries may still be adjusted if review evidence suggests a
  better bounded split
- keep “bounded Web publication first, broader platform concerns later”
  as the main directional rule

--------------------------------------------------

## Planning priority

Recommended working order:

1. `TASK024` article input resolution seam
2. `TASK025` archive-read / export reuse for non-CLI consumers
3. `TASK026` minimal request queue persistence
4. `TASK027` queue-drain execution path
5. `TASK028` minimal Web app skeleton and frontend
6. `TASK029` saved → TXT download / unsaved → enqueue flow
7. `TASK030` bounded Web runtime / publication packaging

This order is recommended because it:

- reuses the already-adopted CLI/runtime/archive baseline
- prepares Web behavior by seam and flow rather than by premature framework-first work
- delivers a usable Web app in bounded increments
- preserves bounded task size
- remains compatible with the Double Helix workflow

--------------------------------------------------

## Planning rules

When defining the next task, prefer:

- small bounded tasks
- production-facing progress over abstract cleanup
- explicit scope / non-goals
- preservation of current architecture unless a task explicitly changes it
- reviewable changes that fit the Double Helix model
- practical Web-facing functionality before broader platform expansion

Avoid:

- cross-layer redesign
- framework-first abstraction
- broad speculative refactors
- silently widening the task after implementation starts
- premature public-platform hardening before the bounded Web baseline exists
- multi-format feature expansion before the saved→TXT / unsaved→queue flow exists

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
