# META Directory

This directory stores workflow-supporting metadata and tooling.

The repository root remains the entry layer for authoritative
bootstrap / state restoration.

META/ stores:

- canonical architecture documentation
- task-cycle workflow guidance
- editor-prompt design guidance
- AI-readable review logs
- helper script implementations
- review-only generated outputs

Subdirectories:

- `META/review_log/`
- `META/scripts/`
- `META/out/`

Important:

- `project_snapshot.txt` and `project_knowledge_snapshot.txt`
  remain at repository root
- root helper scripts are thin wrappers that call implementations
  under `META/scripts/`


Helper script examples:

- `./compare_helix.sh`
- `./export_review_snapshot.sh`
- `./sync_architecture_doc.sh`
- `./new_task_branches.sh`
- `./validate_helix.sh`
- `./collect_task_review.sh`
- `./export_open_issues.sh`

Prompt-design guidance:

- `META/EDITOR_PROMPT_TEMPLATE.md`

This file defines a reusable prompt structure for editor AIs
working inside child product repositories.

It is intended to:
- stabilize prompt quality across sessions
- preserve Double Helix comparison value
- keep editor AI work within child-repo execution boundaries


Recent additions:

- `./new_task_branches.sh`
  creates matching task branches for `copilot/` and `cursor/`

- `./validate_helix.sh`
  runs `flake8` and `pytest` in both child repositories and reports pass/fail per repo

- `./collect_task_review.sh`
  prints review-oriented git information for both child repositories

- `./export_open_issues.sh`
  exports open GitHub issues from the meta repository into a local text file
  for planning / review reference
