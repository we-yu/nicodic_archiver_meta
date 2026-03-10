# TASK006 storage-tests adoption log

## Task
- Task ID: TASK006
- Title: storage-tests

## Purpose
`storage.py` の既存 production behavior を、
focused unit tests によって保護する。

特に以下を対象とする:

- `init_db()`
- `save_to_db()`
- `save_json()`

DB 保存と JSON 保存の両責務を、
cross-layer refactor なしでテスト保護することを目的とした。

## Scope
- Primary target:
  - `tests/test_storage.py`
- Behavior under protection:
  - SQLite DB 初期化
  - `articles` / `responses` テーブル生成
  - article / responses の保存
  - `INSERT OR IGNORE` による重複増殖防止
  - `content` -> `content_text` の保存
  - `content_html` -> `content_html` の保存
  - JSON 出力
  - `collected_at`
  - `response_count`
  - filename sanitize (`/` -> `／`, `\` -> `＼`)

## Non-goals
- No redesign of `storage.py`
- No cross-layer refactor
- No architecture change
- No parser / orchestrator / CLI scope expansion
- No behavior change to production code unless directly required for test establishment

## Compared results
### Copilot side
- Added `tests/test_storage.py`
- Covered DB initialization and persistence behavior
- Covered JSON output behavior
- Included fixed-time verification for `collected_at`

### Cursor side
- Added `tests/test_storage.py`
- Covered DB initialization and persistence behavior
- Covered JSON output behavior
- Test responsibilities were slightly more review-friendly and easier to judge independently

## Adopted result
- Adopted base: Cursor
- Adoption type: Hybrid minimal integration
- Integrated element from Copilot:
  - fixed-time verification for `collected_at` in JSON output test

Final adopted file:
- `tests/test_storage.py`

Production code impact:
- none

## Why this result was selected
- Preserved current production behavior without changing `storage.py`
- Kept TASK006 as a tests task rather than a redesign task
- Covered both DB persistence and JSON output responsibilities
- Maintained safe temp-dir / temp-DB isolation
- Produced a review-friendly structure while also strengthening `collected_at` verification
- Matched project priority:
  1. stability
  2. correctness
  3. maintainability
  4. AI comparison

## Behavior now protected by tests
- `init_db()` creates `data/` and initializes SQLite DB
- `articles` table exists
- `responses` table exists
- `save_to_db()` persists one article and multiple responses
- repeated `save_to_db()` calls do not grow duplicate rows
- `response["content"]` is stored as `content_text`
- `response["content_html"]` is stored as `content_html`
- `save_json()` writes output under `data/`
- JSON output includes:
  - `article_id`
  - `article_type`
  - `article_url`
  - `title`
  - `collected_at`
  - `response_count`
  - `responses`
- `save_json()` sanitizes filename characters:
  - `/` -> `／`
  - `\` -> `＼`
- `collected_at` is verified through fixed-time monkeypatching

## Validation
Validation was run through the helix workflow helper.

### Command
`./validate_helix.sh`

### Result
- `copilot`: PASS
- `cursor`: PASS

Additional convergence check:

### Command
`./compare_helix.sh`

### Result
- `copilot/` and `cursor/` matched for selected files
- helix convergence confirmed

## Repository / history note
- TASK006 was adopted into `nicodic_archiver.git` main
- `cursor/main` was advanced first
- `copilot/main` was then realigned to the same adopted state
- no production-code changes were required
- authoritative snapshots were regenerated after convergence

## Final repository state
- `copilot/main` aligned to `origin/main`
- `cursor/main` aligned to `origin/main`
- TASK006 content present on `main`
- `tests/test_storage.py` exists in the product repository
- no remaining child-repo working tree changes

## Conclusion
TASK006 is complete.

The project now has focused storage tests that protect current storage-layer behavior while preserving the current architecture and avoiding unnecessary production-code changes.

