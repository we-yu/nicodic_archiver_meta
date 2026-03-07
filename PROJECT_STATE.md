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

Current application structure:

main.py
cli.py
http_client.py
parser.py
storage.py

Additional helper script exists:

compare_helix.sh

This script is used to compare copilot/ and cursor/
after convergence at the end of a task.

--------------------------------------------------

NEXT TASK

TASK002

Refactor orchestration logic out of main.py.

Suggested new module:

core/archiver.py

Goal:

• keep behaviour unchanged
• move orchestration logic from main.py
• make main.py thinner
• preserve CLI compatibility

--------------------------------------------------

AI RULE

When starting a new AI session:

1 read AI_CONTEXT.md
2 read PROJECT_STATE.md
3 read project_snapshot.txt

