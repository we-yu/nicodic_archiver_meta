# Codex Adoption Planning

This document records a near-term process-improvement plan for introducing
Codex into the Nicodic Archiver development workflow.

This is a planning document, not an immediate migration order.

## Purpose

The purpose is not to preserve the current Copilot / Cursor / Terminal
workflow for its own sake.

The purpose is to keep the personal-use NicoNicoPedia archive stable and
maintainable while lowering human operational burden.

Desired outcomes:

- reduce repeated editor-prompt overhead
- reduce validation-fix round trips
- improve Web UI smoke checking
- preserve human adoption judgment
- preserve runtime DB / cron / docker safety
- keep product changes bounded and reviewable

## Current workflow baseline

Current practical roles:

- Browser ChatGPT / Advisor-AI:
  - task framing
  - design review
  - Double Helix comparison support
  - runtime operation judgment
  - project memory restoration from meta files and snapshots

- Copilot repo:
  - product implementation candidate
  - often used for single-editor bounded SubTasks

- Cursor repo:
  - product implementation candidate
  - often used as Double Helix comparison implementation

- Mac / host terminal:
  - root meta repository operations
  - child repo validation helpers
  - runtime checkout operations
  - DB backup / smoke / runtime reflection
  - cron and docker final execution judgment

This workflow is effective but verbose.

## Codex candidate roles

### Browser ChatGPT / Advisor-AI

Keep:

- purpose and scope decisions
- task design
- prompt review
- adoption judgment support
- runtime operation judgment support
- review of Codex outputs

Advisor-AI should not become the runtime executor.

### Codex Cloud / Codex app

Candidate use:

- bounded product implementation
- test addition
- focused bug fix
- validation failure repair
- branch / worktree / PR candidate creation
- parallel implementation variants

Not yet trusted for:

- runtime DB modification
- cron restart / schedule policy
- docker runtime final operation
- heavy scraping decisions
- merge adoption judgment

### Codex IDE extension

Candidate use:

- local focused code edits
- reviewing touched diffs
- fixing small validation failures
- checking line length and EOF newline issues
- assisting in VS Code or Cursor

This is a good early trial surface because it is close to the existing
editor workflow.

### Codex Chrome / in-app browser

Candidate use:

- Web UI smoke support
- Registered Articles search / sort / pagination checks
- saved download checks
- CSV link checks
- denylist reject checks
- public preliminary Web surface sanity checks

Not a replacement for:

- DB inspection
- cron inspection
- docker process inspection
- runtime log interpretation

### Codex CLI

Candidate use:

- later local terminal-based coding agent trials
- local repo inspection
- small product or meta edits in a selected directory

This should be deferred until AGENTS.md guidance and sandbox expectations
are clear.

## Double Helix interpretation after Codex

Double Helix is not about preserving Copilot and Cursor as mandatory tools.

The core purpose is:

- avoid overtrusting a single AI implementation
- compare implementation strategies
- reduce AI bias
- preserve human adoption judgment
- improve correctness and maintainability

Possible future Codex-style Double Helix:

- Codex Task A:
  - minimal-change implementation
  - existing structure preserving

- Codex Task B:
  - semantic-seam or refactor-oriented implementation
  - broader but still bounded

Advisor-AI and Human compare the outputs.

Important:

- two identical Codex prompts are not independent enough
- if Codex is used for comparison, initial task constraints should be
  intentionally different
- comparison purpose must remain explicit

## Recommended introduction phases

### Phase 1: Browser / Web smoke support

Use Codex Chrome or in-app browser for low-risk Web UI smoke.

Candidate smoke targets:

- Registered Articles search
- sort
- pagination
- CSV current-page export
- Reset / Refresh
- saved article download flow
- denylist rejection display

Runtime DB, cron, and docker remain Human / Advisor controlled.

### Phase 2: IDE extension focused support

Use Codex IDE extension in VS Code or Cursor for local, focused assistance.

Candidate tasks:

- line length check
- EOF newline check
- unused import check
- small validation failure repair
- narrow test adjustment

No runtime DB edits.
No cron changes.
No root/meta edits unless explicitly requested.

### Phase 3: Single-editor small SubTask trial

Give Codex one bounded SubTask that does not touch runtime DB or cron.

Good candidate:

- Registered Articles search LIKE escape bug fix
- compact log formatting test-only check
- small UI or read-side correction

Requirements:

- branch must be clear
- changes must be bounded
- tests must be focused
- report must state validation actually run or not run
- Human / Advisor still review and decide adoption

### Phase 4: AGENTS.md adoption

Promote AGENTS_DRAFT.md into real AGENTS.md files after review.

Candidate locations:

- root AGENTS.md
- copilot/AGENTS.md
- cursor/AGENTS.md

Root AGENTS.md should cover meta repo boundaries.
Child AGENTS.md should cover product repo coding rules.

### Phase 5: Codex parallel task / Double Helix substitute trial

Try two Codex tasks with intentionally different strategies.

Example:

- Task A: minimal patch
- Task B: semantic seam first

Human / Advisor compare the result.

Copilot / Cursor fixed DHM may be reduced if Codex proves better, but the
comparison and adoption-judgment purpose remains.

## Safe first trial recommendation

The first actual Codex use should be one of:

1. Web UI smoke support with no repository writes
2. IDE extension focused validation-fix support
3. small product BugFix with no runtime reflection until Human review

Recommended first product-code trial:

- SubTask-BugFix-registered-search-like-escape

Reason:

- bounded
- easy to test
- no schema change
- no runtime DB mutation
- directly tied to observed UI search behavior

## Explicit boundaries

Codex may be allowed to:

- read product repo files
- edit product repo files in a task branch
- add focused tests
- run repo-local validation when explicitly allowed
- prepare a report
- propose PR candidates
- assist Web UI smoke

Codex must not autonomously:

- edit runtime DB
- reset or migrate runtime DB
- restart cron
- change crontab
- run long scraping
- run docker runtime reflection
- decide merge adoption
- push to main without Human instruction
- edit root/meta files unless the task is explicitly a meta task

## Success criteria for adoption experiments

Codex introduction is useful if it:

- reduces repeated prompt overhead
- reduces validation failure loops
- produces bounded diffs
- respects repo boundaries
- improves smoke-check reliability
- keeps Human / Advisor decision quality high

Codex introduction is not useful if it:

- causes broad uncontrolled edits
- blurs runtime and product boundaries
- overstates validation
- creates opaque branch / worktree state
- increases review burden

## Current decision

Codex should be investigated soon.

It should not replace Human / Advisor final judgment.

It should not receive runtime DB, cron, docker, or heavy scrape authority at
this stage.

