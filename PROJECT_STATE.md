# PROJECT STATE

Current stage of development.

--------------------------------------------------

PROJECT

nicodic_archiver

--------------------------------------------------

ENVIRONMENT

Docker based development

Python 3.12
requests
beautifulsoup4
lxml

pytest
flake8

--------------------------------------------------

WORKSPACE STRUCTURE

workspace
  copilot/
  cursor/

Both are independent git repositories.

--------------------------------------------------

CURRENT STATUS

Environment setup complete.

Docker build works.
pytest works.
flake8 works.

TASK001 has been completed.

TASK001 result:

• Copilot implementation was adopted
• Cursor implementation was retained for comparison
• Both repositories were later aligned again at the same code state

TASK002 has been completed.

TASK002 result:

• Copilot implementation was adopted
• Cursor implementation was retained for comparison
• Both repositories were later aligned again at the same code state
• main.py was reduced to a CLI-focused entrypoint
• orchestration logic was moved to orchestrator.py

TASK003 has been completed.

TASK003 result:

• Cursor implementation was adopted
• Copilot implementation was retained for comparison
• Both repositories were later aligned again at the same code state
• minimal unit tests were added for main.py and orchestrator.py
• tests/conftest.py was added for pytest import-path support
• production code remained unchanged

TASK004 has been completed.

TASK004 result:

• focused parser tests were added
• parser behavior protection was strengthened without changing production code
• both repositories were later aligned again at the same code state

TASK005 has been completed.

TASK005 result:

• root workflow helper scripts were added
• new_task_branches.sh was added as a root helper wrapper
• validate_helix.sh was added as a root helper wrapper
• collect_task_review.sh was added as a root helper wrapper
• helper script implementations were added under META/scripts/
• WORKSPACE.md was updated to reflect the workflow additions
• META/README.md was updated to reflect the workflow additions
• snapshot regeneration has already been performed

TASK006 has been completed.

TASK006 result:

• Cursor-based hybrid adoption was selected
• Copilot contributed the fixed-time `collected_at` verification idea
• `tests/test_storage.py` was added
• production code remained unchanged
• both repositories were realigned again at the same code state
• snapshot regeneration has already been performed

TASK007 has been completed.

TASK007 result:

• Cursor implementation was adopted
• Copilot implementation was retained for comparison evidence
• `tests/test_orchestrator.py` was expanded to protect orchestration flow more broadly
• production code remained unchanged
• both repositories were realigned again at the same code state
• snapshot regeneration has already been performed

TASK008 has been completed.

TASK008 result:

• Copilot implementation was adopted
• Cursor implementation was retained for comparison evidence
• `http_client.py` was hardened within the HTTP fetch layer
• minimal timeout-centered request-boundary protection was added
• `tests/test_http_client.py` was added
• both repositories were realigned again at the same code state
• convergence was confirmed with `./compare_helix.sh --all`
• post-adoption validation passed in both repositories

TASK009 has been completed.

TASK009 result:

• Copilot implementation was adopted
• Cursor implementation was retained for comparison evidence
• `orchestrator.py` was hardened to handle article-not-found and no-BBS / zero-response cases more explicitly
• `tests/test_orchestrator.py` was expanded to protect the new edge-case behavior
• both repositories were realigned again at the same code state
• convergence was confirmed with `./compare_helix.sh --all`
• post-adoption validation passed in both repositories

TASK010 has been completed.

TASK010 result:

• Cursor-based minimal hybrid adoption was selected
• Copilot contributed the later-page interruption page-level observability line
• `orchestrator.py` was hardened to distinguish later-page interruption from empty-result handling
• partial responses are now preserved and saved when later-page interruption occurs
• `tests/test_orchestrator.py` was expanded to protect the new interruption-handling behavior
• both repositories were realigned again at the same code state
• convergence was confirmed with `./compare_helix.sh --all`
• post-adoption validation passed in both repositories

TASK011 has been completed.

TASK011 result:

• Cursor implementation was adopted
• `orchestrator.py` was hardened with bounded high-volume handling policy
• known high-volume article IDs are now skipped before collection and save flow
• a fixed response cap was added for unknown high-volume articles
• capped results are preserved and saved as partial results
• `tests/test_orchestrator.py` was expanded to protect the new high-volume policy behavior
• both repositories were realigned again at the same code state
• convergence was confirmed with `./compare_helix.sh --all`
• post-adoption validation passed in both repositories

TASK012 has been completed.

TASK012 result:

• Copilot implementation was adopted
• `tests/test_orchestrator.py` was strengthened with representative regression coverage for the already-adopted single-article scrape path
• representative save-path behavior is now more explicitly protected for:
  - normal save path
  - no-BBS / zero-response empty-result save path
  - later-page interruption partial-save path
  - response-cap reached partial-save path
• representative skip-path behavior is now more explicitly protected for:
  - article-not-found
  - known high-volume skip
• production code remained unchanged
• both repositories were realigned again at the same code state
• convergence was confirmed with `./compare_helix.sh --all`
• post-adoption validation passed in both repositories

TASK013 has been completed.

TASK013 result:

• Copilot implementation was adopted
• a provisional plain-text file-based target source was introduced
• `target_list.py` was added to provide bounded target-list loading
• `main.py` gained a bounded CLI/application entry for target-list loading
• `tests/test_target_list.py` was added
• `tests/test_main.py` was updated to protect the new bounded entry behavior
• batch scrape behavior was not introduced
• production changes remained limited to bounded functional expansion for target loading
• both repositories were realigned again at the same code state
• convergence was confirmed with `./compare_helix.sh --all`
• post-adoption validation passed in both repositories

TASK014 has been completed.

TASK014 result:

• Cursor implementation was adopted
• Copilot implementation was retained for comparison evidence
• a bounded batch scrape command was added using the target list
• batch execution remains serial and CLI-centered
• existing single-article scrape flow is reused for each target
• continue-on-error behavior was added at the batch layer
• final non-zero exit is returned when any target fails
• target-level success / failure visibility was added to CLI output
• single-article save semantics were not redesigned
• `main.py` was updated
• `orchestrator.py` was minimally extended to support batch-facing success signaling
• `tests/test_main.py` and `tests/test_orchestrator.py` were updated
• both repositories were realigned again at the same code state
• convergence was confirmed with `./compare_helix.sh --all`
• post-adoption validation passed in both repositories

TASK015 has been completed.

TASK015 result:

• Cursor implementation was adopted
• Copilot implementation was retained for comparison evidence
• minimal batch-run logging / status recording was added
• logging is batch-only
• run logs are stored as text `.log` files
• each batch run records:
  - a start marker
  - an end summary
  - failure-only detail entries
• success targets are not individually persisted in run logs
• final status is recorded as:
  - `success`
  - `partial_failure`
  - `failure`
• `main.py` was updated
• `tests/test_main.py` was updated
• no parser / storage / http_client redesign was introduced
• no scheduler / overlap / retry-backoff expansion was introduced
• both repositories were realigned again at the same code state
• convergence was confirmed with `./compare_helix.sh --all`
• post-adoption validation passed in both repositories

Current application structure:

main.py
orchestrator.py
cli.py
http_client.py
parser.py
storage.py

Current test structure includes:

tests/conftest.py
tests/test_basic.py
tests/test_http_client.py
tests/test_main.py
tests/test_orchestrator.py
tests/test_parser.py
tests/test_storage.py

Additional helper scripts exist:

compare_helix.sh
export_review_snapshot.sh
export_snapshot.sh
sync_architecture_doc.sh
new_task_branches.sh
validate_helix.sh
collect_task_review.sh
export_open_issues.sh

These root scripts are thin wrappers.

Their implementations are stored under:

META/scripts/

compare_helix.sh:
used to confirm convergence between copilot/ and cursor/

export_review_snapshot.sh:
used to export review-oriented comparison snapshots
including untracked / diff information

export_snapshot.sh:
used to regenerate authoritative AI-readable project snapshots

sync_architecture_doc.sh:
used to synchronize META/ARCHITECTURE.md into
copilot/docs/ARCHITECTURE.md and cursor/docs/ARCHITECTURE.md

new_task_branches.sh:
used to create matching task branches for copilot/ and cursor/

validate_helix.sh:
used to run validation in both child repositories

collect_task_review.sh:
used to print review-oriented task information for both child repositories

export_open_issues.sh:
used to export open GitHub issues from the meta repository
into a local text file such as `Issues.txt`

Additional review memory exists:

META/review_log/

This directory stores AI-readable adoption / review logs
for completed tasks.

META/TASK_CYCLE_CHECKLIST.md stores practical task-cycle guidance
for review, adoption, and post-merge synchronization.

Roadmap reference:

For non-authoritative future-direction context, see:

META/ROADMAP_REFERENCE.md

This roadmap reference is for planning continuity only.
It must not be treated as authoritative current state
or as a fixed task order.

Medium-term direction reference:

For stronger near-term planning guidance across the next few tasks, see:

META/MEDIUM_TERM_DIRECTION.md

This medium-term direction is stronger than the roadmap reference,
but weaker than authoritative current-state files.

It is intended to guide likely next-task direction
without becoming a fixed task order
or replacing source-of-truth state restoration.

Copilot meta-assistant note:

A GitHub Copilot-connected AI is currently being used in a limited,
supplementary role for meta-repository information retrieval and
context recovery.

Its role is limited to:
- reading meta-repo source-of-truth files
- summarizing current state
- locating review-memory information
- helping restore context across sessions

It is not used as:
- a product implementation authority
- a review verdict authority
- an adoption decision authority
- a replacement for the human + advisor judgment chain

--------------------------------------------------

NEXT TASK

TASK015 is complete.

Next task is not yet fixed.

A roadmap reference exists for future-direction context only:

META/ROADMAP_REFERENCE.md

--------------------------------------------------

AI RULE

When starting a new AI session:

1 read AI_CONTEXT.md
2 read PROJECT_STATE.md
3 read WORKSPACE.md
4 read project_snapshot.txt
5 read project_knowledge_snapshot.txt (From project 'Knowledge')

If relevant review history exists, the AI may also read:

META/review_log/*.md

If workflow guidance is needed, also read:

META/TASK_CYCLE_CHECKLIST.md
META/EDITOR_PROMPT_TEMPLATE.md
META/REPO_BOUNDARY_GUARDRAILS.md

If the next few tasks are being planned, also read:

META/MEDIUM_TERM_DIRECTION.md
