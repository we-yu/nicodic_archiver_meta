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

Current application structure:

main.py
orchestrator.py
cli.py
http_client.py
parser.py
storage.py

Additional helper script exists:

compare_helix.sh

This script is used to compare copilot/ and cursor/
after convergence at the end of a task.

Additional review memory exists:

review_log/

This directory stores AI-readable adoption / review logs
for completed tasks.

--------------------------------------------------

NEXT TASK

TBD

TASK002 is complete.
The next task has not yet been fixed in this file.

--------------------------------------------------

AI RULE

When starting a new AI session:

1 read AI_CONTEXT.md
2 read PROJECT_STATE.md
3 read WORKSPACE.md
4 read project_snapshot.txt

If relevant review history exists, the AI may also read:

review_log/*.md


