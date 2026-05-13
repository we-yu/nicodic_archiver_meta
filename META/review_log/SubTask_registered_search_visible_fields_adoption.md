# SubTask-BugFix: Registered Articles visible-field search adoption

## Summary

Registered Articles search was corrected so the normal search box matches only
visible, user-understandable fields:

- Article ID
- Title

Canonical URL, Created At, Last Scraped, Saved Responses, and Max Res No are no
longer direct search targets.

This fixes confusing search results where a Japanese query such as "艦" could
return rows whose visible Title did not contain the searched term, likely due to
hidden canonical URL or encoded URL matching.

## Implementation summary

Adopted behavior:

- Search matches visible Article ID by partial text match.
- Search matches visible Title by partial text match.
- Canonical URL-only matches are excluded.
- SQL LIKE wildcard characters in user input are treated literally.
- Percent sign, underscore, and backslash are escaped for LIKE.
- Legacy/pending encoded identity rows are searched by visible display values,
  not raw DB encoded values.

## Codex trial note

This was the first small product BugFix attempted as a Codex IDE/Copilot style
single-editor trial.

Outcome:

- Codex produced a mostly correct bounded implementation.
- A focused reprompt was needed after validation found legacy/pending encoded
  identity failures.
- After the focused fix, Human validation passed.
- Codex suggested host Python / venv-style validation commands, which were
  rejected because this project validates through existing project scripts and
  container-aware workflows.

Process lesson:

- Codex is usable for bounded product fixes.
- Codex still needs explicit project-environment guidance.
- Future AGENTS.md should state that host Python / venv test suggestions are
  not the default workflow and existing scripts such as validate_helix.sh and
  runtime_exec.sh should be preferred unless explicitly told otherwise.

## Validation

Human validation before merge:

- ./validate_helix.sh
- Copilot branch: PASS
- Cursor main: PASS
- Copilot branch collected 397 tests and passed all tests.
- Cursor main collected 394 tests and passed all tests.

Post-merge validation:

- ./compare_helix.sh --all: PASS
- ./validate_helix.sh: PASS
- Copilot main collected 397 tests and passed all tests.
- Cursor main collected 397 tests and passed all tests.

## Browser smoke

Human launched the Copilot branch as a temporary Web container using runtime
data and checked Registered Articles behavior in a browser.

Confirmed:

- /registered rendered.
- q=99 matched visible Article ID and visible Title values.
- Search behavior appeared consistent with the new visible-field semantics.
- The search placeholder was corrected to remove Canonical URL from the visible
  search description.
- The temporary Web container and image were removed after smoke.

## Files changed in product repo

- archive_read.py
- web_app.py
- tests/test_archive_read.py
- SubTask-registered-search-visible-fields_report.txt

Note:

- tests/test_web_app.py was not changed in the final product diff.
- web_app.py was changed only for the visible search placeholder wording.

## Product commit / merge

Product branch:

- subtask-bugfix-registered-search-visible-fields-codex

Product main merge:

- merged on GitHub
- product main commit observed after merge: ca12fe7

## Runtime note

Runtime reflection is separate.

No runtime DB, cron, or docker production changes were part of the product
implementation itself.

Runtime reflection remains pending until the runtime checkout is safely updated.

