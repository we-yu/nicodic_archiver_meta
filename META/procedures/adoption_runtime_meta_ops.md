# Adoption → Runtime Reflection → META Record Procedure

Concise end-to-end procedure for the adoption and operational closeout workflow.
Covers Cursor-only SubTask, editor-agent-managed WorkflowTask, DHM MainTask,
runtime reflection, META recording, and snapshot regeneration.

This procedure is root/meta-local. Commands run from the workspace root unless
noted otherwise.

---

## WARNINGS — Read Before Starting

**W1. Do not run `append_project_state_block.py` from the runtime checkout.**
It resolves `PROJECT_STATE.md` relative to the current directory.
Run it only from the root/meta repository root.

```
# CORRECT
cd /home/manage/product/nicodic_archiver
python3 META/scripts/append_project_state_block.py --heading "..." <<'EOF'
...
EOF
```

**W2. `runtime_periodic_ops.sh` accepts exactly one subcommand.**
`status stop-once` is NOT valid. It runs `status` and ignores the rest.
Use two separate calls when both are needed.

```
# WRONG — only runs status, does NOT create the stop file
bash tools/runtime_periodic_ops.sh status stop-once

# CORRECT — two separate calls
bash tools/runtime_periodic_ops.sh status
bash tools/runtime_periodic_ops.sh stop-once
```

**W3. Do not run `runtime_up.sh` while periodic scraping is active.**
Always confirm no lock and no scrape-like process first (see §8).

**W4. Do not use host raw Python for runtime DB work.**
Use container exec via `./runtime_exec.sh` or equivalent.

**W5. Do not touch runtime DB or cron unless the task explicitly says so.**

**W6. Do not modify `copilot/` or `cursor/` during root/meta WorkflowTasks
unless the task explicitly requires it.**

**W7. If `export_snapshot.sh` creates snapshot-only diffs before task work
starts, either intentionally include them at the end or restore them before
beginning task work.** Snapshot-only diffs added before actual task work will
appear in the task commit unless removed.

---

## Step 1 — Task Adoption Type

Identify which adoption path applies:

| Type | Description |
|------|-------------|
| **Cursor-only SubTask** | Single editor; no DHM comparison needed |
| **WorkflowTask (editor-agent-managed)** | Root/meta improvement; editor AI works in root repo |
| **DHM MainTask** | Copilot vs Cursor comparison; adoption judgment required |

For **Cursor-only SubTask**: skip DHM comparison steps (§3–§5). Proceed from §2.

For **WorkflowTask**: the working repository is root/meta only.
Do not modify `copilot/` or `cursor/` unless the task explicitly requires it.

For **DHM MainTask**: follow all steps in order.

---

## Step 2 — Cursor-Only SubTask Adoption (if applicable)

```
# Confirm adopted branch
git -C cursor branch --show-current

# Merge into cursor main (use repository-compliant method)
git -C cursor checkout main
git -C cursor merge --ff-only <branch>

# Push
git -C cursor push origin main
```

Then sync both child repos from their updated `main` (see §6).

---

## Step 3 — DHM: Non-Adopted Candidate Branch Push as Evidence

Push the non-adopted branch so it remains available as review evidence.

```
git -C copilot push origin <non-adopted-branch>
# or
git -C cursor push origin <non-adopted-branch>
```

---

## Step 4 — DHM: Child Repo Synchronization After Product PR Merge

After the adopted result is merged into child-repo `main`:

```
git -C copilot checkout main
git -C copilot pull --ff-only origin main

git -C cursor checkout main
git -C cursor pull --ff-only origin main
```

Both child repos must be on the same adopted `main` state before convergence
check.

---

## Step 5 — compare_helix / validate_helix Timing

Run convergence and validation after both child repos have pulled adopted `main`.
Do not run before both repos are aligned.

```
./compare_helix.sh --all
./validate_helix.sh
```

Treat any unexpected drift after `main` pull as a workflow issue to investigate
before proceeding.

---

## Step 6 — Runtime Reflection Pre-Check

Before any runtime reflection, confirm all of the following. Use the
root-level helper so the preflight is not forgotten:

```
./reflect_runtime.sh
```

What `reflect_runtime.sh` checks automatically:
- runtime dir exists
- no `runtime/logs/periodic_once.lock` directory
- no `python main.py batch|periodic|periodic-once` process in the container

If you need to check status manually (without proceeding to pull/recreate):

```
cd /home/manage/product/nicodic_archiver_runtime
bash tools/runtime_periodic_ops.sh status
```

**Do not run `runtime_up.sh` if the lock exists or a scrape-like process is
active.**

---

## Step 7 — Soft Terminate Usage and Common Mistakes

To request a graceful stop after the current scrape completes:

```
cd /home/manage/product/nicodic_archiver_runtime
bash tools/runtime_periodic_ops.sh stop-once
```

To check the current stop-file state:

```
bash tools/runtime_periodic_ops.sh show-stop
```

To clear the stop file if no longer needed:

```
bash tools/runtime_periodic_ops.sh clear-stop
```

**Common mistake:** Passing `status stop-once` as a single call — only `status`
runs. Always issue subcommands separately (see W2 above).

Wait for the lock to clear before proceeding to runtime reflection. Confirm
with:

```
bash tools/runtime_periodic_ops.sh status
```

---

## Step 8 — Runtime Checkout Pull / runtime_up

After confirming no active scrape work, update and recreate the runtime:

```
./reflect_runtime.sh
```

This runs `git pull --ff-only origin main` and `bash tools/runtime_up.sh`
inside the runtime checkout, then confirms the container is running.

If manual steps are needed:

```
cd /home/manage/product/nicodic_archiver_runtime
git pull --ff-only origin main
bash tools/runtime_up.sh
docker ps --format 'table {{.Names}}\t{{.Status}}\t{{.Ports}}' | grep nicodic_archiver_runtime
```

---

## Step 9 — Web Smoke Checks

After the container is running:

```
curl -s -o /dev/null -w "%{http_code}" http://localhost:<port>/
curl -s -o /dev/null -w "%{http_code}" http://localhost:<port>/registered
```

Expected: HTTP 200 for both. Also confirm the target route renders in the
browser if practical. Record actual HTTP response codes in the review log.

---

## Step 10 — Cron-Only Runtime Operations

Cron schedule changes and cron-only tuning are operational decisions that do not
touch product code or the runtime DB schema.

When to record in META:
- whenever cron schedule or runtime operational parameters are changed
- even if no product code changes occurred

Record in:
- `META/runtime_maintenance_log.md` — for operational context
- `PROJECT_STATE.md` — for a concise project-state entry (see §12)
- a review log under `META/review_log/` if the change warrants it (see §11)

**Do not modify cron or runtime Docker unless the task explicitly says to.**

---

## Step 11 — META Review Log Creation

Create a review log under `META/review_log/` for every adopted task or
significant operational change.

Naming convention: `<TaskName>_<YYYYMMDD>.md`

Example:

```
META/review_log/SubTask_BugFix_example_20260624.md
```

Minimum content:

```markdown
# <Task Name> adoption log

- task: <task description>
- adopted: <Cursor | Copilot | hybrid | N/A>
- non-adopted: <...>
- reason: <...>
- validation:
  - compare_helix.sh --all: <PASS|SKIP|N/A>
  - validate_helix.sh: <PASS|SKIP|N/A>
  - Copilot: <N tests passed>
  - Cursor: <N tests passed>
- runtime note: <...>
```

**Do not skip the review log if a PROJECT_STATE update was already committed.**
They serve different purposes.

---

## Step 12 — PROJECT_STATE Append (root repo only)

**Always run from the root/meta repository root.**

```
cd /home/manage/product/nicodic_archiver

python3 META/scripts/append_project_state_block.py \
  --heading "YYYY-MM-DD <Task summary>" <<'EOF'
Purpose:
- ...

Adopted behavior:
- ...

Validation:
- compare_helix.sh --all: PASS
- validate_helix.sh: PASS
- Copilot: N tests passed
- Cursor: N tests passed

Runtime reflection:
- ...

Review log:
- META/review_log/<filename>.md
EOF
```

Dry-run first if unsure:

```
python3 META/scripts/append_project_state_block.py \
  --heading "YYYY-MM-DD <Task summary>" \
  --dry-run <<'EOF'
...
EOF
```

---

## Step 13 — export_snapshot

After all META edits are complete:

```
cd /home/manage/product/nicodic_archiver
./export_snapshot.sh
```

This regenerates `project_snapshot.txt` and `project_knowledge_snapshot.txt`
as local advisor-handoff files. These generated files are gitignored and must
NOT be committed; regenerate them as needed instead.

If only root/meta files changed and a faster update is acceptable:

```
./export_snapshot.sh --meta-only
```

---

## Step 14 — META Commit / Push

Stage only intended root/meta changes. Confirm before committing:

```
cd /home/manage/product/nicodic_archiver
git diff --check
git status --short
git diff --stat
```

Confirm:
- no files under `copilot/` or `cursor/` are staged
- no runtime files are staged
- only intended source-of-truth META and PROJECT_STATE files are staged
- generated snapshot files and raw report files are NOT staged
  (they are gitignored advisor-handoff / working artifacts)

Then commit (commit only the source-of-truth META files that changed):

```
git add META/review_log/<file>.md
git add META/procedures/<file>.md   # if applicable
git add PROJECT_STATE.md
git commit -m "Meta: <concise description>"
git push origin main
```

Note on generated snapshots:
- run/export snapshots when useful for advisor handoff (`./export_snapshot.sh`)
- do not commit generated snapshot files
  (`project_snapshot.txt`, `project_knowledge_snapshot.txt`,
  `review_snapshot*.txt`); they are local/generated and gitignored

---

## Step 15 — Final Clean Status Check

```
cd /home/manage/product/nicodic_archiver
git status --short
git diff --check
```

Expected: clean working tree with no unintended changes.

Also confirm child repos are clean and on `main`:

```
git -C copilot status --short
git -C cursor status --short
```

---

## Quick Reference — Command Checklist

```
# 1. adoption / child repo sync
git -C cursor checkout main && git -C cursor pull --ff-only origin main
git -C copilot checkout main && git -C copilot pull --ff-only origin main

# 2. convergence check
./compare_helix.sh --all
./validate_helix.sh

# 3. runtime pre-check (from root/meta)
./reflect_runtime.sh

# 4. soft terminate (from runtime checkout)
cd /home/manage/product/nicodic_archiver_runtime
bash tools/runtime_periodic_ops.sh status
bash tools/runtime_periodic_ops.sh stop-once   # separate call

# 5. META review log
# create META/review_log/<TaskName>_<YYYYMMDD>.md manually

# 6. PROJECT_STATE (from root/meta only)
cd /home/manage/product/nicodic_archiver
python3 META/scripts/append_project_state_block.py --heading "..." <<'EOF'
...
EOF

# 7. snapshot
./export_snapshot.sh

# 8. final check and commit
git diff --check
git status --short
git add <intended files>
git commit -m "Meta: ..."
git push origin main
```

## Runtime DB backup / temporary DB discipline

As of 2026-06, the main runtime SQLite DB is close to 20GB.

Do not suggest or perform a full DB copy merely "just in case".

A full DB backup is allowed, but only after considering:

- whether the operation writes archive-critical tables
- whether the operation can be safely rerun
- whether the operation only touches derived or rebuildable tables
- available disk space
- expected copy time
- whether the backup can be deleted promptly after successful verification

Temporary DBs and copied DBs must be planned with cleanup from the start.

Any command sequence that creates a temporary DB or backup DB must also include:

- the expected temporary file path
- the removal command
- a verification command confirming the file no longer exists

For commands that may take more than about 10 seconds, mention the duration risk
before showing the command so the operator does not mistake normal waiting for a
hang.

A 20GB-class runtime DB backup is not forbidden, but it is not a default safety
gesture. It is an explicit operational decision.

## Existing runtime DB schema/index application

Runtime container recreation alone does not guarantee that compatibility ALTERs
or newly added indexes have been applied to an existing runtime SQLite DB.

After reflecting product code that adds schema columns or indexes, explicitly
run the normal runtime-facing schema initialization seam against the runtime DB:

- `init_db('/app/data/nicodic.db')`

Use the root/meta runtime helper rather than calling a missing helper from the
runtime checkout itself.

Example:

- run from `/home/manage/product/nicodic_archiver`
- use `./runtime_exec.sh "python -c \"from storage import init_db; c=init_db('/app/data/nicodic.db'); c.close(); print('init_db_ok')\""`

Then verify the expected columns or indexes with a read-only PRAGMA check.

This is especially important for additive SQLite changes such as:

- `ALTER TABLE ... ADD COLUMN`
- `CREATE INDEX IF NOT EXISTS ...`

Do not use a full runtime DB copy merely to apply additive schema/index changes.
Check runtime lock/process state first, apply the schema seam, then verify.
