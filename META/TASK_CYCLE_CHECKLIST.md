# Task Cycle Checklist

Practical checklist for one Double Helix task cycle.

--------------------------------------------------

## Recommended branch naming

Use matching task numbers in both repositories.

Recommended format:

- `taskNNN-short-topic-copilot`
- `taskNNN-short-topic-cursor`

Examples:

- `task003-tests-copilot`
- `task003-tests-cursor`

Keep the topic short, clear, and implementation-neutral.

--------------------------------------------------

## 1. Define the task

- Write the task goal in one sentence.
- Record the scope and non-goals.
- State whether the task affects product code, tests, workflow, or docs.
- Define acceptance criteria before implementation starts.

### Prompt design note for Double Helix tasks
- The human developer and advisor AI should strongly define:
  - task goal
  - scope / non-goals
  - acceptance criteria
  - review criteria
  - production-code change policy
- They should NOT over-specify implementation shape unless truly necessary.
- In particular, avoid fixing too much of:
  - test split structure
  - helper / fixture layout
  - exact assertion grouping
  - internal implementation shape
- The purpose of Double Helix is not only correctness but also solution diversity.
- If prompts over-constrain `How`, Copilot and Cursor may converge too early and comparison value may be lost.
- Preferred rule:
  - define `What` and review criteria clearly
  - leave reasonable freedom in `How`

For a reusable editor-prompt structure, also see:

- `META/EDITOR_PROMPT_TEMPLATE.md`

Use that file as workflow guidance for editor-facing implementation prompts.
It complements this checklist, but does not replace task-specific definition work.

### Optional editor-report artifact note

When editor-AI copy/paste overhead becomes annoying,
the human + advisor side may instruct the editor AI to write its final report
to a child-repo-local text file such as:

- `TASKNNN_report.txt`

This should remain:
- optional
- child-repo-local
- report-only

Do not treat such files as authoritative project memory.
Do not instruct editor AIs to write them into root/meta locations.

### Evidence-commit exclusion rule for review/report artifacts

When preparing evidence commits with `./prepare_task_evidence.sh`,
do not include review-only or report-only artifacts via `--include-file`
unless there is an explicit, task-specific decision to preserve them
as committed evidence.

Default rule:

- do NOT include `TASKNNN_report.txt`
- do NOT include `META/out/review_snapshot*.txt`
- do NOT include other review-only comparison artifacts

Treat the following as the normal `--include-file` targets instead:

- newly created product tests that must be committed
- newly created product fixtures that must be committed
- other newly created child-repo-local product files that are part of
  the implementation result

Practical interpretation:

- `TASKNNN_report.txt` is child-repo-local and useful for review,
  but is report-only by default
- `META/out/review_snapshot*.txt` is comparison material only by default
- if either artifact should be committed in an exceptional case,
  the human + advisor side must state that exception explicitly
  before giving the command

### Execution-boundary note for editor AI prompts

- Prompts for editor AIs in `copilot/` and `cursor/` should normally avoid requiring ad-hoc execution.
- Do not ask editor AIs to create virtual environments.
- Do not default to direct commands such as `python3 -m pytest ...` or raw `pytest ...`.
- Validation should normally be handled by the human developer using established project workflow commands from the workspace root.
- If repo-local checking is mentioned, keep it soft and repo-contained:
  - "confirm within this repo if already available"
  rather than
  - "run these shell commands now"

## 2. Create branches

- Create one branch in `copilot/`.
- Create one branch in `cursor/`.
- Use the same task number and topic in both branch names.
- Confirm both branches start from the intended `main` baseline.

## 3. Implement in both repos

- Implement the task independently in `copilot/`.
- Implement the task independently in `cursor/`.
- Keep changes focused on the task.
- Avoid unrelated cleanup unless explicitly required.

## 4. Validate both implementations

- Run the task-specific validation in each repo.
- Run the normal project checks that matter for the task.
- Confirm acceptance criteria are met in both repos.
- Note any behavioral differences before review.

### Validation execution boundary

- Validation ownership belongs primarily to the human developer / reviewer side.
- Prefer workspace-root helper scripts and established workflow commands.
- Editor AIs working inside child repos should not be prompted to create or manage environments.
- Avoid relying on ad-hoc shell execution proposed by editor AIs unless explicitly requested by the human.

### Review note on validation failures

- A validation failure should not automatically end comparison review.
- First distinguish:
  - implementation-quality issues
  - submission-quality issues such as lint, formatting, or minor test-expression mistakes
  - manual-fix mistakes that do not reflect the underlying implementation quality
- If a failure appears small, localized, and easy to correct without changing task scope,
  review the implementation substance before rejecting the branch.
- Immediate rejection is more appropriate when the failure indicates:
  - task-scope violation
  - architecture-boundary break
  - unstable production behavior
  - broad or unclear rework requirement
- In Double Helix review, preserve comparison value when a branch is still substantively useful.
- submission-quality issues should also include avoidable style failures such as:
  - overlong lines introduced in touched code
  - unnecessary patch / mock setup that does not correspond to the execution path under test

## 5. Export a review snapshot

- Run `./export_review_snapshot.sh` from the workspace root.
- Use a named output file if multiple reviews are active.
- Treat the review snapshot as comparison material only.
- Do not treat it as the authoritative restore snapshot.
- As the default rule, do not commit `META/out/review_snapshot.txt` as part of authoritative workflow memory unless there is a specific reason to preserve that exact review artifact.

## 6. Decide adoption

- Compare Copilot and Cursor results.
- Choose one of:
  - adopt Copilot
  - adopt Cursor
  - adopt a hybrid result
- Prefer the most correct and conservative result.
- Write down the reasons for the decision.

### Minimal hybrid note

- A hybrid result does not always require a branch-to-branch merge.
- A valid low-friction option is:
  - adopt one side as the base result
  - manually incorporate a very small, reviewable improvement from the other side
- Use this only when the borrowed change is narrow, explainable, and does not widen task scope.
- Prefer this over a heavier merge when the practical difference is only one or a few lines.
- Record the borrowed adjustment explicitly in the review log.

## 6.5 Confirm repository ownership before integration

Before giving any commit, merge, or push instruction,
explicitly confirm all of the following:

- which repository owns the adopted file(s)
- whether the adopted file(s) are meta assets or product assets
- which repository should receive the adopted result
- which `main` branch is the intended destination
- which remote will receive the push

Hard rule:

- the workspace root repository is for meta files, review logs, snapshots, and workflow wrappers
- `copilot/` and `cursor/` are product repositories
- product code and tests must never be adopted into the root meta repository
- if repository ownership is unclear, stop and resolve it before continuing

### Evidence-commit reminder for newly created files

When using `./prepare_task_evidence.sh`, explicitly think about newly created
child-repo files before execution.

If the task created new files that must be part of the evidence commit
(example: new focused tests), the human + advisor side should present the
command with explicit include arguments for those files.

Example shape:

- `--include-file copilot:tests/test_xxx.py`
- `--include-file cursor:tests/test_yyy.py`

Do not assume newly created files will be committed automatically unless they
are explicitly included by the workflow helper's supported mechanism.

## 7. Commit and push

- Commit the selected implementation in the adopted repo.
- Push the adopted branch.
- Push the non-adopted branch if it should remain as review evidence.
- Do not mix unrelated changes into the task commit.

## 8. Merge to `main`

- Merge the adopted result into `main`.
- Keep the merge explanation aligned with the adoption decision.
- Confirm `main` now represents the chosen final state.

### Operational notes for `main`
- For the workspace root repository, direct push to `main` may be possible depending on the current remote settings.
- For `copilot/` and `cursor/`, do not assume direct `main` push or merge-commit push is allowed.
- In particular, do not assume `git merge --no-ff` into child-repo `main` will be pushable.
- Follow the repository rules actually enforced by each child repository.
- If child-repo `main` rejects merge commits, use a repository-compliant integration method instead.
- Record any such repository-rule friction in the review log when it affects task completion.

### Operational notes for architecture sync copies
- `META/ARCHITECTURE.md` is the canonical architecture document.
- `copilot/docs/ARCHITECTURE.md` and `cursor/docs/ARCHITECTURE.md` are synchronized copies for repository-local readability.
- Do not treat those child-repo copies as the source of truth.
- Do not mix architecture-copy sync noise into unrelated task commits.
- If architecture-copy handling causes repeated workflow friction, record it and consider a separate workflow task rather than changing task scope silently.

### Optional adoption marker branch

- After the adoption decision, an additional clearly named branch may be pushed for review clarity.
- Recommended format:
  - `adopted/taskNNN-topic`
- This branch is only a marker for the selected result.
- Do not use it to replace the normal Double Helix implementation branches:
  - `taskNNN-topic-copilot`
  - `taskNNN-topic-cursor`
- Keep the original implementation branches for comparison evidence.

## 9. Sync both child repos from `main`

- Do not describe post-adoption synchronization as manual file copying.
- The normal Double Helix completion path is:
  1. push the adopted implementation branch
  2. push the non-adopted implementation branch if it should remain as evidence
  3. if used, push the optional adopted marker branch
  4. integrate the adopted result into child-repo `main`
     using the repository-compliant method
  5. in both `copilot/` and `cursor/`, checkout `main`
  6. pull the updated `main`
- Treat this `main` pull step as the normal way to bring both child repos
  to the same adopted final state.
- Avoid instructing the user to manually copy adopted product files
  between `copilot/` and `cursor/` as the standard post-adoption method.
- After both child repos have pulled the adopted `main`,
  confirm that the post-task baseline is shared.

## 10. Run convergence check

- After both child repos have switched to `main` and pulled,
  run `./compare_helix.sh --all`.
- Confirm `copilot/` and `cursor/` match on the adopted final state.
- Treat any unexpected drift after `main` pull as a workflow issue
  to investigate.

## 11. Update review memory

- Add or update a log under `META/review_log/`.
- Record the task purpose.
- Record the adopted implementation.
- Record why the other option or hybrid was not selected.
- Record validation and convergence results.

## 12. Regenerate the authoritative snapshot

- Update root workflow/meta files if the task changed project state.
- Run `./export_snapshot.sh` from the workspace root.
- Keep `project_snapshot.txt` as the source-of-truth restore snapshot.
- Do not rely on review snapshot files for authoritative context restore.

--------------------------------------------------

## Common failure points

- Branch names do not match the same task number.
- One repo started from a different baseline than the other.
- Validation was run in only one repo.
- Review snapshot was mistaken for the authoritative snapshot.
- Review log was skipped after adoption.
- Repos were not realigned after merge.
- `compare_helix.sh --all` was not rerun after realignment.
- `PROJECT_STATE.md` or `WORKSPACE.md` was left stale.
- `project_snapshot.txt` was not regenerated after workflow-memory edits.
- The adopted file ownership was not confirmed before integration.
- The wrong repository `main` was treated as the merge destination.
- Product files were almost committed into the meta repository.
- Remote / repository destination was not checked before push instructions.

--------------------------------------------------

## Rule of thumb

Finish the task only after:

1. adoption is decided
2. merge to `main` is complete
3. both repos are realigned
4. convergence passes
5. review memory is updated
6. authoritative snapshot is regenerated
