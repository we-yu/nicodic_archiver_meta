# REPO BOUNDARY GUARDRAILS

This document defines hard repository-boundary rules for the nicodic_archiver workspace.

--------------------------------------------------
REPOSITORY ROLES
--------------------------------------------------

Root workspace:
- repository type: meta repository
- purpose:
  - project memory
  - AI context
  - review logs
  - snapshots
  - workflow helper wrappers
  - operational documentation

Child repositories:
- `copilot/`
- `cursor/`

Both child repositories are product repositories.

They contain:
- application code
- tests
- product-facing docs inside the product repo

--------------------------------------------------
HARD OWNERSHIP RULES
--------------------------------------------------

Meta repository owns:
- `AI_CONTEXT.md`
- `PROJECT_STATE.md`
- `WORKSPACE.md`
- `_AI_RULES.md`
- `_AI_EXECUTION_PROTOCOL.md`
- `META/`
- `project_snapshot.txt`
- `project_knowledge_snapshot.txt`
- root helper wrapper scripts

Product repositories own:
- `main.py`
- `orchestrator.py`
- `cli.py`
- `http_client.py`
- `parser.py`
- `storage.py`
- `tests/`
- product-level docs and implementation files

Hard rule:
- product code and tests must never be committed into the meta repository
- meta files must not be treated as product repository deliverables

--------------------------------------------------
ADOPTION / INTEGRATION RULE
--------------------------------------------------

When a task result is adopted:

1. determine which repository owns the adopted file(s)
2. merge or fast-forward into the correct repository `main`
3. validate inside the product repositories as needed
4. realign the sibling repository
5. update meta review logs / state / snapshots in the meta repository

"merge into main" is repository-relative.
It must never be interpreted without first identifying the correct repository.

--------------------------------------------------
MANDATORY PREFLIGHT CHECK
--------------------------------------------------

Before any commit / merge / push instruction, confirm:

- current working repository
- target file path
- target file ownership
- target branch
- target remote

If any of these are unclear, stop and resolve the ambiguity first.

--------------------------------------------------
INCIDENT LESSON
--------------------------------------------------

A previous near-miss occurred when a product test file
(`tests/test_storage.py`) was almost adopted into the meta repository.

That must not happen again.

The lesson is:

- reading project memory is not enough
- repo-boundary rules must be explicitly applied before integration steps
- repository ownership must be treated as a hard stop condition

