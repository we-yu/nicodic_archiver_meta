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

If the single-article scraping path becomes sufficiently stable, a natural next direction may be:

- target-list definition
- batch scrape command
- periodic execution / scheduler integration
- scrape status / log recording

Notes:

- This is a plausible future direction, not a fixed plan.
- Ordering may change depending on real implementation pressure.
- Other operational or test tasks may be inserted between these items.

## Long-term possible direction

After batch and periodic execution become stable, a possible later direction may be:

- export layer for archived content
- availability / queue-insertion logic
- Web/API layer for retrieval and request intake

Notes:

- This section is the most speculative part of the roadmap.
- Treat this as high-level product direction only.
- Do not treat this as current architecture.

## Goal framing

### First goal
Be able to save bulletin-board comments correctly for a broad range of Nico Nico Pedia articles.

This includes appropriate handling for cases such as:

- article does not exist
- no bulletin-board responses
- other edge or failure cases that should be handled explicitly

### Second goal
Based on a separately defined target list, periodically scrape listed articles every few hours.

### Final goal
Turn the system into a Web application where:

- if a requested article is already scraped, the archived result can be returned
  in formats such as txt / html / md / csv
- if a requested article is not yet scraped, it is added to future scrape targets

## Maintenance note

When future tasks are defined, prefer:

- small, bounded tasks
- clear repository ownership
- explicit scope / non-goals
- preserving current architecture unless the task explicitly changes it

If this roadmap becomes outdated, revise it rather than silently relying on old assumptions.


