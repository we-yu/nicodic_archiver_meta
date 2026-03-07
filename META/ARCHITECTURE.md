# Architecture

This document is the canonical architecture description
for the nicodic_archiver project.

This file is the source-of-truth architecture document.

Copies of this file may be synchronized to:

- `copilot/docs/ARCHITECTURE.md`
- `cursor/docs/ARCHITECTURE.md`

Those copies exist for repository-local readability,
but this root file is the canonical version.

--------------------------------------------------

Project purpose

The project archives comment threads from the NicoNicoPedia BBS.

Goal:

- preserve comments locally
- keep access even if original comments are deleted
- store static information only

Stored data includes:

- response number
- poster name
- poster ID hash
- posted timestamp
- comment text
- comment HTML

Excluded data includes:

- GOOD / BAD counts
- other dynamic metrics

--------------------------------------------------

Current architecture

main.py
    CLI entry point

orchestrator.py
    Coordinates scraping flow and persistence order

http_client.py
    Handles HTTP requests

parser.py
    Extracts response data from HTML

storage.py
    Handles SQLite and JSON persistence

cli.py
    Provides inspect command output

tests/conftest.py
    Supports pytest import resolution

tests/test_main.py
    Covers CLI dispatch behavior

tests/test_orchestrator.py
    Covers orchestration helper behavior

--------------------------------------------------

Current responsibility split

main.py
    CLI argument parsing
    inspect branch
    dispatch to orchestration

orchestrator.py
    article metadata fetching
    BBS base URL generation
    paginated response collection
    JSON save + SQLite save flow

http_client.py
    HTTP fetch layer

parser.py
    HTML parsing layer

storage.py
    persistence layer

cli.py
    DB inspection output

tests/
    minimal unit-test layer protecting post-TASK002 boundaries

--------------------------------------------------

Status after TASK003

- main.py is thinner than before
- orchestration has been extracted to orchestrator.py
- minimal unit tests now exist for main.py and orchestrator.py
- tests/conftest.py supports pytest import resolution
- production behaviour is intended to remain unchanged

--------------------------------------------------

Design principles

- keep CLI compatibility
- prefer small, explainable refactors
- preserve behavior unless a task explicitly changes it
- prefer stability over novelty
- keep module responsibilities clear
- compare AI implementations before adoption

--------------------------------------------------

Refactoring guidance

Good refactors:

- reduce responsibility overlap
- make main.py thinner without changing CLI behavior
- add focused tests around existing behavior
- improve workflow tooling when review friction is observed

Avoid by default:

- redesigning multiple layers at once
- expanding task scope silently
- introducing configuration systems without clear need
- changing behavior during structure-only tasks

--------------------------------------------------

Workflow context

This project uses a Double Helix Development Model.

For one task:

- Copilot implementation is produced in `copilot/`
- Cursor implementation is produced in `cursor/`
- both are reviewed
- one is adopted, or a hybrid is adopted
- both repos are then realigned to the same final state

For practical workflow steps, refer to:

- `WORKSPACE.md`
- `META/TASK_CYCLE_CHECKLIST.md`

For adoption history, refer to:

- `META/review_log/`

--------------------------------------------------

Future note

Unless a later task explicitly changes architecture,
this document should be treated as the post-TASK003 baseline.

