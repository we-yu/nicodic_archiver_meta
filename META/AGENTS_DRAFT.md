# AGENTS.md Draft for Nicodic Archiver

This is a draft for future AGENTS.md files.

Do not treat this draft as active Codex instruction until it is copied to an
actual AGENTS.md location.

## Project purpose

Nicodic Archiver archives static NicoNicoPedia BBS response data for
personal use.

Store static response information only:

- response number
- poster name
- poster ID hash
- posted timestamp
- comment text
- comment HTML

Do not collect dynamic GOOD / BAD counts.

## Repository boundaries

This workspace has multiple git contexts.

Root repository:

- meta files
- review logs
- workflow helpers
- snapshots
- planning docs

Child product repositories:

- copilot/
- cursor/

Runtime checkout:

- /home/manage/product/nicodic_archiver_runtime

Product code changes belong in child product repositories, not in the root
meta repository.

Runtime checkout is provisional dogfooding / operation state, not the normal
development workspace.

## Coding rules

- Python line length hard limit: 88 characters.
- Ensure trailing newline at EOF for every edited or new file.
- Keep changes bounded to the requested task.
- Do not introduce unrelated cleanup.
- Do not claim tests or lint passed unless actually run.
- Tests must not use live network unless explicitly approved for a smoke
  task.
- Do not introduce article_type='id' as a normal persisted article target.
- Keep target/article identity semantics explicit.

## Runtime safety

Do not do these unless explicitly instructed:

- edit runtime DB
- reset runtime DB
- migrate runtime DB
- change crontab
- restart cron
- recreate runtime docker container
- run long scraping
- change nginx / certbot / public deployment

Runtime-facing checks should prefer container execution or existing runtime
helpers.

## Validation honesty

Reports must distinguish:

- tests actually run
- tests not run
- static inspection only
- browser smoke only
- validation attempted but failed

Never report validation as passing unless it actually passed.

## Task reports

When asked to create a task report, keep it repo-local.

Include:

- summary
- files touched
- tests added or updated
- validation attempted or not attempted
- known limitations
- editor AI model/tool information if available

## Double Helix / comparison

The purpose of comparison is not to preserve any specific tool.

The purpose is:

- reduce AI bias
- compare implementation strategy
- preserve Human / Advisor adoption judgment
- improve stability and maintainability

If asked to provide an alternative implementation, intentionally follow the
requested strategy rather than converging to the same solution.

