# TASK039 Registered Article List Management Adoption Log

## Task
TASK039

Add bounded registered-article list management and display.

## Purpose
Make the current SQLite-backed target / archive state easier for a single
operator and public Web visitor to inspect, while shifting normal archive
operation away from always-on JSON file output.

The task centered on:
- a read-only registered article list view in the Web app
- SQLite-centered archive operation
- stopping new always-on `data/*.json` output
- an admin-facing ad-hoc export helper for saved article contents

## Decision
Adopted: Copilot

Alternative reviewed:
- Cursor implementation was retained as non-adopted comparison evidence

Hybrid:
- considered but not selected

## Final adopted shape
Changed / added product areas in the adopted result:
- `archive_read.py`
- `main.py`
- `operator_cli.py`
- `orchestrator.py`
- `web_app.py`
- `tools/show_scraped_res.sh`
- focused tests around archive read, Web behavior, operator export, and
  orchestration behavior

## What changed
The adopted result added a bounded read-only registered article list page.

The Web top page now links to a registered article list page.
The list is simple and intentionally does not include:
- search UI
- sort UI
- paging UI
- edit UI
- delete UI
- auth / permission behavior

The registered article list is derived from SQLite-backed saved / registered
state and presents one row per article-like entry.

The adopted result also stopped new always-on archive JSON output.
Normal scrape persistence is now SQLite-centered.
Existing JSON files are treated as historical artifacts and are not removed by
product code.

A read-only human-facing summary artifact is now produced as:
- `runtime/data/scrape_targets.txt`

The adopted result added an admin-facing helper:
- `tools/show_scraped_res.sh`

The helper supports:
- bare title input as the default interpretation
- `--title TITLE`
- `--id ID`
- `--txt`
- `--md`
- `--csv`

Default output format is txt.

The helper keeps archive content on stdout and emits concise status on stderr,
so operators can redirect stdout into a temporary file.

## Practical validation
Both Copilot and Cursor eventually passed validation.

Practical runtime-like container checks were performed for both implementations
using the saved article:

- title: `あかり先生`
- article ID: `5560706`

For both implementations, the following were confirmed:
- TXT export worked
- Markdown export worked
- CSV export worked
- article content was emitted to stdout
- concise status did not contaminate redirected output files
- the Web top page included a registered article list link
- the registered article list page rendered successfully
- the list displayed saved registered article rows

## Why Copilot was adopted
Copilot was adopted because it fit the existing project shape better.

Primary reasons:
1. It integrated the ad-hoc export path through the existing operator-oriented
   command shape rather than creating a more separate tooling island.
2. It added `tools/show_scraped_res.sh` as a thin operator wrapper, matching the
   existing practical tooling style.
3. It removed JSON writing from the scrape path more directly, matching the
   task intent to move toward SQLite-centered archive operation.
4. It kept the implementation aligned with existing archive read and operator
   helper seams.
5. Practical CLI and Web checks passed.

## Why Cursor was not adopted
Cursor was valid and useful as comparison evidence.

Observed strengths:
- clean dedicated `admin_export.py` separation
- stable validation behavior
- functioning registered article list and export behavior

Reasons it was not selected:
- the dedicated admin export module created a more separate tooling path than
  the current operator helper style needs
- the root-level helper placement was less aligned with the existing `tools/`
  helper convention
- keeping JSON output as a no-op compatibility seam was less direct than
  removing it from the active scrape persistence path for this task

## Why hybrid was not selected
Hybrid was not selected because no Cursor element provided a narrow enough
improvement to justify mixing implementations.

The useful Cursor ideas were either:
- broader structural alternatives, or
- not clearly better than the coherent Copilot shape.

A small future subtask may still polish:
- registered list wording
- table header readability
- last-scraped timestamp availability
- warning visibility for summary-artifact write failures

## What did not change
This task did not introduce:
- registered article search UI
- registered article sort UI
- registered article paging
- registered article edit / delete actions
- auth / permission behavior
- PostgreSQL / MySQL migration
- DB server containerization
- S3 archival
- scrape scheduler redesign
- queue redesign
- runtime publication redesign

## Interpretation
Current archive operation should now be read as SQLite-centered.

`data/*.json` should no longer be treated as a current always-on archive output
path.

Existing JSON files may still exist in runtime data as historical artifacts.
Their physical removal is a human maintenance action, not part of TASK039
product-code behavior.

`tools/show_scraped_res.sh` is part of the current bounded operator helper
baseline for ad-hoc export of saved article data.

The Web registered article list is intentionally simple and read-only.

## Repository outcome
- adopted implementation: Copilot
- non-adopted comparison evidence: Cursor
- product `main` should be updated with the Copilot result
- both child repositories should then be realigned to adopted `main`
- runtime checkout should be reflected after adopted `main` is available

## Meta note
This log is AI-readable review memory.
It is not authoritative current state by itself.

Authoritative restore still depends on:
- `AI_CONTEXT.md`
- `PROJECT_STATE.md`
- `WORKSPACE.md`
- `project_snapshot.txt`


