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
• snapshot generation scripts
• comparison utilities
• review logs for adoption decisions

Example:

review_log/
  TASK002_adoption.md


--------------------------------------------------

TASK COMPLETION FLOW

After a task is completed:

1. compare Copilot and Cursor implementations
2. choose winner or hybrid result
3. merge the chosen result into main
4. realign copilot/ and cursor/ to the same final state
5. confirm convergence using compare_helix.sh

After adoption, a short AI-readable review log may be stored
under review_log/ for future sessions.

