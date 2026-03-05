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

Both Copilot and Cursor environments are identical.

--------------------------------------------------

NEXT TASK

TASK001

Refactor main.py into modules.

Suggested modules:

scraper.py
parser.py
storage.py
cli.py

main.py should become a thin entrypoint.

--------------------------------------------------

AI RULE

When starting a new AI session:

1 read AI_CONTEXT.md
2 read PROJECT_STATE.md
3 read project_snapshot.txt

