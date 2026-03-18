# Roadmap Reference (Non-Authoritative)

## Purpose

This file stores a **reference-only roadmap** for the project.

It is intended to help future review sessions and future AI threads keep sight of
the likely medium-term and long-term direction of the project.

This file is **not** the authoritative source of current status.
This file is **not** a committed execution plan.
This file is **not** a fixed task order.

Authoritative current state should still be restored from:

- `AI_CONTEXT.md`
- `PROJECT_STATE.md`
- `WORKSPACE.md`
- latest snapshot files

## Interpretation Rule

Use this file as:

- directional context
- planning support
- continuity aid across threads

Do **not** treat every item here as fixed.
Do **not** assume later tasks are already approved.
Do **not** override current source-of-truth documents with this file.

## Current understanding

The project currently has a responsibility split roughly like:

- `main.py` = CLI entry
- `orchestrator.py` = scraping flow and save-order orchestration
- `http_client.py` = HTTP fetch layer
- `parser.py` = HTML parsing
- `storage.py` = persistence

This roadmap assumes that future work should continue to respect those module boundaries
unless a later task explicitly changes architecture.

## Near-term likely direction

### Short-term main line
Likely and natural near-term direction:

1. `http_client.py` bounded hardening
2. failure classification / fetch-result handling
3. zero-response / no-BBS / edge-case handling
4. regression-fixture strengthening

Notes:

- This is the strongest part of the roadmap and is closest to the current codebase state.
- These items are still proposals, not commitments.
- Scope should remain bounded and explainable.

## Medium-term possible direction

With target-list loading, batch execution, run logging, periodic execution,
archive export/readout, and add-target intake now established in bounded form,
a natural next medium-term direction may be:

- whole-archive export / archive listing
- provisional personal-use runtime separation from development workflow
- practical repeated operation against a manually maintained target list
- bounded seam preparation for later Web/API expansion

Notes:

- This is a plausible future direction, not a fixed plan.
- Ordering may still change depending on review evidence and implementation pressure.
- The main medium-term objective should be:
  **personal-use practicality before actual Web/API implementation**.
- Keep tasks bounded and explainable.

## Long-term possible direction

After the personal-use operational phase becomes sufficiently practical,
a possible later direction may be:

- Web/API layer for retrieval and request intake
- richer export surface for archived content
- availability / queue-insertion logic for not-yet-scraped articles
- broader deployment/runtime formalization beyond the provisional profile

Notes:

- This section remains speculative.
- Treat this as high-level product direction only.
- Do not treat this as current architecture.
- Web/API work should be informed by the bounded seams clarified in the
  preceding personal-use phase.

## Goal framing

### First goal
Be able to save bulletin-board comments correctly for a broad range of Nico Nico Pedia articles.

This includes appropriate handling for cases such as:

- article does not exist
- no bulletin-board responses
- other edge or failure cases that should be handled explicitly

### Second goal
Based on a manually maintained target list, repeatedly collect listed articles
every few hours in a practical personal-use runtime, with results accumulating
in the current SQLite-centered store.

### Final goal
Turn the system into a Web application where:

- if a requested article is already scraped, the archived result can be returned
  in formats such as txt / html / md / csv
- if a requested article is not yet scraped, it can be added to future scrape targets
- the Web/API-facing behavior is built on bounded archive-read/export and
  target-intake seams prepared earlier

## Maintenance note

When future tasks are defined, prefer:

- small, bounded tasks
- clear repository ownership
- explicit scope / non-goals
- preserving current architecture unless the task explicitly changes it

If this roadmap becomes outdated, revise it rather than silently relying on old assumptions.


