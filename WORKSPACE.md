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

- review logs
- workflow guidance
- canonical architecture documentation
- task-cycle workflow guidance
- editor-prompt design guidance
- AI-readable review logs
- helper script implementations
- review-only generated outputs


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

Additional workflow helpers:

./new_task_branches.sh
./validate_helix.sh
./collect_task_review.sh
./export_open_issues.sh

These helpers support routine Double Helix operations:

- `./new_task_branches.sh`
  creates matching task branches in `copilot/` and `cursor/`

- `./validate_helix.sh`
  runs `flake8` and `pytest` in both child repositories and prints a summary

- `./collect_task_review.sh`
  collects branch / status / diff-stat / recent-log information for review

- `./export_open_issues.sh`
  exports open GitHub issues from the meta repository into a local text file
  such as `Issues.txt`

Like other root helper scripts, these are thin wrappers.
Their implementations are stored under:

Prompt-design guidance:

- `META/EDITOR_PROMPT_TEMPLATE.md`

This file provides a reusable structure for editor-AI implementation prompts
used in `copilot/` and `cursor/`.

It is workflow guidance, not authoritative current state.


META/scripts/

--------------------------------------------------

OPERATIONAL NOTES

Workspace root vs child repositories:
- The workspace root (`nicodic_archiver/`) and the child repositories (`copilot/`, `cursor/`) are separate git contexts.
- Do not assume they share the same push or branch-protection behavior.
- The workspace root repository may allow direct push to `main` depending on current remote settings.
- `copilot/` and `cursor/` may enforce stricter repository rules on `main`.
- In particular, do not assume merge commits to child-repo `main` are pushable.
- When integrating an adopted result, follow the repository rules actually enforced by the target repository.

Architecture document handling:
- `META/ARCHITECTURE.md` is the canonical architecture document.
- `copilot/docs/ARCHITECTURE.md` and `cursor/docs/ARCHITECTURE.md` are synchronized local copies.
- Those child-repo copies exist for readability, not as source-of-truth files.
- Avoid mixing architecture-copy synchronization noise into unrelated task commits.
- If architecture-copy handling repeatedly creates status noise, treat that as a separate workflow issue and review it explicitly.

--------------------------------------------------

TASK COMPLETION FLOW

After a task is completed:

1. compare Copilot and Cursor implementations
2. choose winner or hybrid result
3. prepare and commit task evidence in the child repos as needed
4. push the adopted implementation branch
5. push the non-adopted implementation branch if it should remain as evidence
6. if used, push the optional adopted marker branch
7. integrate the adopted result into child-repo `main`
   using the repository-compliant method
8. in both `copilot/` and `cursor/`, checkout `main` and pull
9. confirm convergence using compare_helix.sh

- In this project, post-adoption synchronization should normally happen
  by integrating the adopted result into child-repo `main`
  and then pulling `main` in both child repos.
- Do not treat manual file copying between `copilot/` and `cursor/`
  as the standard completion path.
  
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

Prompt design for Double Helix:
- In Double Helix tasks, the human developer and advisor AI should mainly control:
  - task definition
  - scope / non-goals
  - acceptance criteria
  - review criteria
  - adoption judgment
- Implementation details should not be over-constrained unless necessary.
- The purpose is to preserve independent solution diversity between `copilot/` and `cursor/`.
- Over-specifying implementation structure can reduce comparison value and make both editor AIs converge too early.
- Practical rule:
  - be strict about `What`
  - be lighter about `How`
