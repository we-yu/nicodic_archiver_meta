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

Current application structure:

main.py
orchestrator.py
cli.py
http_client.py
parser.py
storage.py

Current test structure includes:

tests/conftest.py
tests/test_main.py
tests/test_orchestrator.py
tests/test_parser.py
tests/test_storage.py

Additional helper scripts exist:

compare_helix.sh
export_review_snapshot.sh
sync_architecture_doc.sh
new_task_branches.sh
validate_helix.sh
collect_task_review.sh


These root scripts are thin wrappers.

Their implementations are stored under:

META/scripts/

compare_helix.sh:
used to confirm convergence between copilot/ and cursor/

export_review_snapshot.sh:
used to export review-oriented comparison snapshots
including untracked / diff information

sync_architecture_doc.sh:
used to synchronize META/ARCHITECTURE.md into
copilot/docs/ARCHITECTURE.md and cursor/docs/ARCHITECTURE.md

new_task_branches.sh:
used to create matching task branches for copilot/ and cursor/

validate_helix.sh:
used to run validation in both child repositories

collect_task_review.sh:
used to print review-oriented task information for both child repositories

Additional review memory exists:

META/review_log/

This directory stores AI-readable adoption / review logs
for completed tasks.

META/TASK_CYCLE_CHECKLIST.md stores practical task-cycle guidance
for review, adoption, and post-merge synchronization.

--------------------------------------------------

NEXT TASK

TASK006 is complete.

Next task is not yet fixed.

Preferred immediate direction:

• perform TASK006 incident review and guardrail analysis
• update operational rules for repo-boundary safety
• keep future task selection separate from the incident-analysis task

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
META/REPO_BOUNDARY_GUARDRAILS.md
