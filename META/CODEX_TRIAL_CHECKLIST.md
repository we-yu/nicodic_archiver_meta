# Codex Trial Checklist

Use this checklist before and after a Codex trial.

## Pre-trial

Confirm task type:

- Web smoke only
- IDE focused fix
- Codex Cloud implementation
- Codex CLI local trial
- meta/documentation planning

Confirm repository:

- root meta repo
- copilot product repo
- cursor product repo
- runtime checkout

Confirm allowed write scope:

- no writes
- child repo only
- root meta only
- documentation only
- tests only
- product code and tests

Confirm forbidden actions:

- no runtime DB edits
- no cron edits
- no docker recreate
- no long scrape
- no merge adoption decision
- no push to main unless explicitly instructed

Confirm validation ownership:

- Human-run validation
- Codex may run focused repo-local validation
- Codex may not run commands

Confirm report requirement:

- files changed
- tests added / updated
- validation run or not run
- known limitations
- model/tool information if available

## During trial

Watch for:

- broad unrelated edits
- root/product boundary mistakes
- runtime checkout modifications
- invented validation claims
- task-scope drift
- destructive commands
- hidden generated files

## Post-trial review

Collect:

- git status
- git diff stat
- changed files
- test summary
- Codex report
- any browser smoke notes

Decide:

- adopt
- reject
- request focused fix
- split into smaller task
- preserve as comparison evidence only

## First recommended trials

Trial 1:

- Codex Chrome / in-app browser
- Web UI smoke only
- no repository writes

Trial 2:

- Codex IDE extension
- focused validation failure or style fix
- child repo only

Trial 3:

- Codex implementation
- small SubTask-BugFix
- no runtime DB / cron / docker

## Candidate first product task

SubTask-BugFix-registered-search-like-escape

Purpose:

- fix SQL LIKE wildcard behavior in Registered Articles search

Expected risk:

- low

Runtime impact:

- product code only until adoption
- runtime reflection only after Human review

