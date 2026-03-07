# META Directory

This directory stores workflow-supporting metadata and tooling.

The repository root remains the entry layer for authoritative
bootstrap / state restoration.

META/ stores:

- canonical architecture documentation
- task-cycle workflow guidance
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



