# Workspace

This directory is a development workspace.

Actual repositories:

copilot/
cursor/

Both directories contain independent git repositories.

The project uses a "Double Helix Development Model":

Each task is implemented twice:

taskXXX-copilot
taskXXX-cursor

Both implementations are compared and one of the following is chosen:

• adopt Copilot implementation
• adopt Cursor implementation
• adopt a hybrid merge proposal

These outcomes are equally valid.

The goal is not to force a merge every time.

--------------------------------------------------

CURRENT PRACTICE

The human developer and Advisor AI review both implementations.

Implementation work is mainly performed in:

copilot/
cursor/

The workspace root mainly stores:

• project meta files
• AI memory files
• authoritative snapshot outputs
• thin wrapper scripts

Operational workflow assets are grouped under:

META/

This includes:

• review logs
• workflow guidance
• canonical architecture document
• helper script implementations
• review-only generated outputs

Example:

META/review_log/
  TASK002_adoption.md
  TASK003_tests_adoption.md

META/TASK_CYCLE_CHECKLIST.md
META/ARCHITECTURE.md

Review-only tooling:

./export_review_snapshot.sh

This helper is for review snapshots only.
It does not replace project_snapshot.txt.

--------------------------------------------------

TASK COMPLETION FLOW

After a task is completed:

1. compare Copilot and Cursor implementations
2. choose winner or hybrid result
3. merge the chosen result into main
4. realign copilot/ and cursor/ to the same final state
5. confirm convergence using compare_helix.sh

After adoption, a short AI-readable review log may be stored
under META/review_log/ for future sessions.

Use META/TASK_CYCLE_CHECKLIST.md as the practical reference
for the full per-task workflow.

If comparison is still in progress, a review-oriented snapshot
may be generated with:

./export_review_snapshot.sh

Its implementation is stored at:

META/scripts/export_review_snapshot.sh

--------------------------------------------------

RECOMMENDED BRANCH NAMING

Use clear task-scoped branch names in each repository:

• taskNNN-short-topic-copilot
• taskNNN-short-topic-cursor

Examples:

• task003-tests-copilot
• task003-tests-cursor

Keep the task number identical across both repos.
Keep the topic short and implementation-neutral.

--------------------------------------------------

META LAYOUT RULE

The repository root is the entry layer.

Authoritative bootstrap/state files remain at root.

Operational workflow assets are grouped under:

META/

This includes:

• review logs
• workflow guidance
• canonical architecture document
• helper script implementations
• review-only generated outputs

