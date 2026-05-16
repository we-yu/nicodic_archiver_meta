# Metadata Index

Conservative index for the root meta repository.

Purpose:

- improve discoverability for humans and AI agents
- make authoritative vs reference vs historical vs generated roles explicit
- reduce accidental over-reading of large historical files
- prepare for later Codex or AGENTS.md adoption without activating it now

Scope:

- root meta repository only
- no product-repo implementation guidance beyond repository boundaries
- no runtime-operation instructions beyond existing guardrails

## How to use this index

Read the smallest authoritative set that matches the task.

For basic context recovery, start with:

1. `AI_BOOTSTRAP.md`
2. `AI_CONTEXT.md`
3. `_AI_RULES.md`
4. `PROJECT_STATE.md`
5. `WORKSPACE.md`
6. `project_snapshot.txt` only when a broader restore snapshot is needed

Use `META/` files as targeted supplements, not as a default full read.

## Authoritative restore context

| File or group | Purpose | Status | When to read | Normally edit? |
| --- | --- | --- | --- | --- |
| `AI_BOOTSTRAP.md` | Startup order for AI context restoration. Points to the primary restore files. | Authoritative | First read for a fresh AI session in the root repo. | Yes, but only when bootstrap order or restore policy changes. |
| `AI_CONTEXT.md` | Behavioral context, project purpose, memory model, and meta-level operating assumptions. | Authoritative | Read early when you need project identity, AI role, or memory-system meaning. | Yes, conservatively. |
| `_AI_RULES.md` | Harder operational rules and persistent guidance for AI behavior. | Authoritative | Read when deciding what an AI may or may not do. | Yes, conservatively. |
| `_AI_EXECUTION_PROTOCOL.md` and `_AI_DEVELOPMENT_MODEL.md` | Project-level execution and Double Helix workflow interpretation. | Authoritative | Read when the task concerns workflow or task execution expectations. | Yes, conservatively. |
| `PROJECT_STATE.md` | Long-running current-state and task-history memory. Still used as authoritative state memory, but now historically dense. | Authoritative, historically heavy | Read for current state, latest direction, and task history when summaries are not enough. Prefer targeted reading over full rereads. | Yes, but avoid broad rewrites in routine tasks. |
| `WORKSPACE.md` | Repository layout, ownership, synchronization, and operational workspace notes. | Authoritative | Read when deciding repository scope, ownership, or post-adoption workflow. | Yes, conservatively. |
| `project_snapshot.txt` | Generated aggregate restore snapshot combining authoritative and supporting context. | Generated but authoritative for broad restore snapshots | Read when a single large restore artifact is needed, or when an AI needs broad passive context quickly. | No manual editing; regenerate through the snapshot workflow. |
| `project_knowledge_snapshot.txt` | Smaller generated knowledge-oriented snapshot. | Generated reference snapshot | Read when the lighter knowledge snapshot is sufficient. | No manual editing; regenerate through the snapshot workflow. |

## Workflow guidance

| File or group | Purpose | Status | When to read | Normally edit? |
| --- | --- | --- | --- | --- |
| `META/README.md` | High-level description of the `META/` directory and its subareas. | Reference | Read when orienting inside `META/`. | Yes, when `META/` structure changes. |
| `META/TASK_CYCLE_CHECKLIST.md` | Practical Double Helix task-cycle checklist and review/report conventions. | Authoritative workflow guidance | Read before defining, executing, or closing a task cycle. | Yes, when workflow practice changes. |
| `META/EDITOR_PROMPT_TEMPLATE.md` | Reusable structure for editor-facing implementation prompts. | Reference workflow guidance | Read when drafting prompts for child-repo editor agents. | Yes, when prompt structure needs refinement. |
| `META/REPO_BOUNDARY_GUARDRAILS.md` | Hard ownership boundaries between root meta repo, child repos, and runtime checkout. | Authoritative guardrail | Read before any task that could confuse root/product/runtime ownership. | Yes, conservatively. |
| `META/DEVELOPMENT_ENVIRONMENT.md` | Development environment reference for the workspace. | Reference | Read when environment assumptions matter. | Yes, as environment facts change. |
| Root helper wrappers such as `export_snapshot.sh`, `publish_snapshots.sh`, `compare_helix.sh`, `validate_helix.sh`, `collect_task_review.sh`, `prepare_task_evidence.sh`, `new_task_branches.sh`, `export_open_issues.sh` | Thin root entrypoints for recurring workflow operations. | Operational helper layer | Read or run when performing the corresponding workflow task from the root repo. | Yes, but treat behavior changes as workflow changes, not casual cleanup. |
| `META/scripts/` | Implementations behind root helper wrappers. Includes snapshot and review export logic. | Operational helper implementation | Read when a wrapper is insufficient and the implementation behavior matters. | Yes, but only for intentional workflow/tooling changes. |
| `META/scripts/append_project_state_block.py` | Small helper for safely appending headed blocks to `PROJECT_STATE.md` from standard input. Skips duplicate headings by default. | Operational helper implementation | Use when recording bounded root/meta state updates. Regenerate snapshots after use. | Yes, when PROJECT_STATE append practice changes. |

## Architecture and schema reference

| File or group | Purpose | Status | When to read | Normally edit? |
| --- | --- | --- | --- | --- |
| `META/ARCHITECTURE.md` | Canonical architecture reference for the project. | Authoritative reference | Read when architecture meaning or component relationships matter. | Yes, when architecture meaning changes. |
| `META/DB_SCHEMA.md` | Canonical database schema reference. | Authoritative reference | Read for DB structure understanding or schema review. | Yes, when schema meaning changes. |
| `META/ROADMAP_REFERENCE.md` | Future-direction context. Explicitly not current-state authority. | Reference-only | Read when discussing medium-term direction, not current commitments. | Yes, but keep it clearly non-authoritative. |
| `META/MEDIUM_TERM_DIRECTION.md` and `META/NEXT_TASK_CANDIDATES.md` | Planning and candidate follow-up work. | Reference-only planning | Read when selecting or framing future work. | Yes, as planning evolves. |

## Review logs and historical memory

| File or group | Purpose | Status | When to read | Normally edit? |
| --- | --- | --- | --- | --- |
| `META/review_log/*.md` | Task adoption logs, subtask review records, and historical decision memory. | Historical | Read when reconstructing why a decision was made or how a prior task closed. | Normally no; treat existing logs as preserved history. |
| `Issues.txt` | Exported issue snapshot for planning and review reference. | Generated planning artifact | Read when issue context is needed offline. | No manual editing in normal flow; regenerate from the helper. |
| Existing `*_report.txt` and similar task-local report artifacts in child repos | Local historical evidence from earlier task executions. Useful context, but not root-meta authority. | Historical | Read only when a specific past task report is directly relevant. | Normally no. |

## Codex and future AI-agent guidance

| File or group | Purpose | Status | When to read | Normally edit? |
| --- | --- | --- | --- | --- |
| `META/AGENTS_DRAFT.md` | Draft candidate for future `AGENTS.md` guidance. Not active instruction today. | Draft | Read when evaluating whether Codex or AGENTS-based guidance is mature enough to activate. | Yes, but only as a draft refinement. |
| `META/CODEX_ADOPTION_PLAN.md` | Process plan for phased Codex introduction. | Draft/planning | Read when discussing adoption strategy, trial surfaces, or role boundaries. | Yes, as planning evolves. |
| `META/CODEX_TRIAL_CHECKLIST.md` | Checklist for running and reviewing Codex trials. | Draft workflow guidance | Read before or after a Codex trial. | Yes, as trials teach better constraints. |

Current assessment:

- `META/AGENTS_DRAFT.md` should remain draft for now.
- It already captures useful guardrails, but activation would be premature while root metadata roles are still being clarified and no approved placement strategy has been finalized.
- Promote it only after the root/meta index, read-order, and repository-local scope conventions feel stable in practice.

## Generated snapshot and export artifacts

| File or group | Purpose | Status | When to read | Normally edit? |
| --- | --- | --- | --- | --- |
| `project_snapshot.txt` | Broad generated restore snapshot used as a source-of-truth restore bundle. | Generated, operationally authoritative | Read for full restore context; do not use it as the first file if a narrower source will do. | No manual editing. |
| `project_knowledge_snapshot.txt` | Smaller generated knowledge bundle. | Generated | Read when broad restore context is useful but the full snapshot is unnecessary. | No manual editing. |
| `META/out/review_snapshot.txt` and `META/out/review_snapshot_*.txt` | Review-only generated outputs. | Generated review artifact | Read only for comparison or review sessions. | No manual editing. |
| `META/out/` more broadly | Staging area for generated review outputs. | Generated | Read only when the specific export artifact is needed. | No manual editing. |

Tracking note:

- `project_snapshot.txt` is currently tracked and repeatedly referenced as the restore snapshot of record.
- Because multiple authoritative documents and helper scripts explicitly depend on it, changing tracking policy now would create avoidable inconsistency.
- Near-term recommendation: keep it tracked for now.
- Future follow-up should review whether a slimmer authoritative snapshot, partial snapshots, or a clearer regenerate-on-demand policy can reduce churn without breaking restore expectations.

## Practical editing rules by file type

- Authoritative files: edit only when meaning or workflow truly changes.
- Reference-only files: edit when explanatory clarity needs improvement.
- Historical files: preserve; append new history elsewhere rather than rewriting old records.
- Draft files: refine cautiously, but do not silently activate them.
- Generated files: do not hand-edit; update the generator or regeneration flow instead.

## Follow-up recommendations

### `PROJECT_STATE.md`

Do not perform destructive slimming as a casual cleanup.

Recommended future approach:

1. keep `PROJECT_STATE.md` authoritative
2. extract older completed-task detail into a clearly historical companion or archive section/file
3. leave a shorter current-state summary near the top
4. preserve cross-references from review logs and snapshots

The current file is still useful, but at more than 2000 lines it is carrying both active state and long-term historical memory.

### `project_snapshot.txt`

Revisit tracking later, not now.

Reasoning:

- it is generated, but it is also explicitly treated as a restore artifact of record
- many existing docs and helpers assume its presence in git
- untracking it before narrowing the restore model would create more AI confusion, not less

### `AGENTS_DRAFT.md`

Keep draft status for now.

Reasoning:

- guidance quality is already useful
- activation criteria are not yet fully stabilized
- repository-local placement strategy is still underdefined
- this metadata index should be exercised first as the lighter structural fix
