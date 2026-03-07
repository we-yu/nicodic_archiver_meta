# TASK002 Adoption Log

## Task
TASK002

Refactor orchestration logic out of `main.py` while keeping behavior unchanged and preserving CLI compatibility.

## Decision
Adopted: **Copilot implementation**

Alternative reviewed:
- Cursor implementation was retained as comparison evidence
- Hybrid was considered but not selected

## Final adopted shape
- `main.py` was reduced to a CLI-focused entrypoint
- non-CLI orchestration was moved out of `main.py`
- adopted extracted module name: `orchestrator.py`
- adopted orchestration entry function: `run_scrape(article_url)`

## What changed in the adopted result
Moved out of `main.py` into `orchestrator.py`:
- `build_bbs_base_url(article_url)`
- `fetch_article_metadata(article_url)`
- `collect_all_responses(bbs_base_url)`
- `run_scrape(article_url)`

Kept in `main.py`:
- CLI argument parsing using `sys.argv`
- inspect command branch
- `inspect_article(...)` dispatch
- normal scrape command dispatch to orchestration layer
- usage messages
- exit behavior

## Behavior requirements for TASK002
The following were required to remain unchanged:
- CLI compatibility
  - `python main.py <article_url>`
  - `python main.py inspect <article_id> <article_type> [--last N]`
- inspect usage and behavior
- visible print output
- `sleep(1)` timing
- pagination flow
- save order: JSON first, SQLite second
- existing responsibilities of:
  - `http_client.py`
  - `parser.py`
  - `storage.py`
  - `cli.py`

## Why Copilot was adopted
Primary reasons:
1. The implementation matched the task intent more directly.
   - TASK002 was specifically about moving orchestration logic out of `main.py`
   - `orchestrator.py` expressed that responsibility clearly

2. The refactor scope was conservative and easy to explain.
   - one new module
   - `main.py` made thinner
   - no redesign of parser/storage/cli/http layers

3. The result fit project priorities well.
   Priority order in this project:
   1. stability
   2. correctness
   3. maintainability
   4. AI comparison

4. Review cost was low.
   - responsibility split was obvious
   - behavior-preservation reasoning was simple
   - rollback/review difficulty was low

## Why Cursor was not adopted
Cursor implementation was valid and useful as comparison material.

Observed strengths:
- `scrape_article()` is a clear and intuitive function name
- light module/function docstrings were helpful
- overall direction was correct

Reasons it was not selected:
- the file/module naming (`scraper.py`) was slightly less aligned with the exact task framing than `orchestrator.py`
- difference was mostly naming/presentation rather than a superior technical result
- no strong enough advantage was found to outweigh the more task-direct Copilot version

## Why Hybrid was not selected
Hybrid was considered, especially:
- keeping `orchestrator.py`
- optionally adopting a name like `scrape_article()`

Hybrid was not selected because:
- the practical difference between the two implementations was small
- merge-for-the-sake-of-merge was not necessary
- Copilot already satisfied the task with minimal change
- preserving a simple adoption decision was better than introducing a cosmetic merge

## Validation performed
Confirmed during review:
- runtime smoke validation via `rrr.sh`
- `flake8` passed in Docker
- `pytest` passed in Docker
- response count and DB count matched in runtime check
- visible scrape flow remained consistent

Observed runtime sample:
- pages collected correctly
- 404 termination behavior remained intact
- JSON save succeeded
- SQLite save succeeded

## Repository outcome
- adopted branch was merged into `main`
- Cursor comparison branch was also preserved remotely as review evidence
- after merge, both `copilot/` and `cursor/` were realigned to the same final state
- convergence was confirmed with `compare_helix.sh`

## Convergence result
Confirmed:
- adopted final state exists in both repos
- helix convergence check passed after realignment

## Notes for future AI sessions
Important interpretation:
- TASK002 is complete
- accepted architecture after TASK002 includes `orchestrator.py`
- do not reopen TASK002 unless there is a concrete defect or a new refactor goal
- if discussing future cleanup, treat this result as the post-TASK002 baseline

## Meta note
This log is for AI-readable review memory.
It is not the authoritative project state by itself.
Authoritative context should still be restored from:
- `AI_CONTEXT.md`
- `PROJECT_STATE.md`
- `WORKSPACE.md`
- `project_snapshot.txt`

