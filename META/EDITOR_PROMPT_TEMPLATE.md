# Editor Prompt Template

Template for implementation prompts sent to editor AIs working inside child product repositories.

Purpose:
- keep task prompts stable across sessions
- preserve Double Helix comparison value
- strongly define `What`
- avoid over-fixing `How`
- keep editor AI work inside child-repo execution boundaries

--------------------------------------------------

## Core rule

Editor prompts should:

- strongly define:
  - task goal
  - scope / non-goals
  - production-code change policy
  - acceptance criteria
  - validation ownership
- avoid over-defining:
  - helper shape
  - naming details
  - exact internal implementation shape
  - test split structure
  - assertion grouping
  - micro-level wording choices

Good prompt principle:

- fix `What`
- constrain task drift
- leave reasonable implementation freedom

--------------------------------------------------

## Fixed execution-boundary rules

These rules are normally included with little or no change.

- The editor AI works only inside the target child repository.
- The editor AI is not a judge / reviewer / adoption decider.
- The editor AI should focus on file editing and repo-local consistency.
- Do not instruct the editor AI to read root/meta restore files.
- Do not ask the editor AI to edit root/meta files.
- Do not ask the editor AI to create virtual environments.
- Do not ask the editor AI to run shell commands.
- Do not ask the editor AI to run pytest / python / validation commands.
- Do not instruct the editor AI to interrupt work for validation proposals.
- Validation ownership remains on the human side.
- The human will run the established validation workflow separately.

--------------------------------------------------

## Prompt sections

A good editor prompt should usually contain the following sections.

### 1. Target repository
Purpose:
- define where the AI is working

Freedom level:
- almost fixed

Recommended form:
- `copilot/`
- `cursor/`

### 2. Role
Purpose:
- define the editor AI as bounded implementation support only

Freedom level:
- almost fixed

Should include:
- bounded implementation editor
- not judge / adoption decider
- avoid task drift
- focus on minimal implementation + tests

### 3. Task name
Purpose:
- identify the task number and label

Freedom level:
- task-specific

Should include:
- `TASKNNN`

### 4. Task goal
Purpose:
- define the one-sentence production goal

Freedom level:
- task-specific, strongly fixed

Should include:
- target module / layer
- intended behavioral change
- boundedness
- architecture preservation when relevant

### 5. Background intent
Purpose:
- explain why this task exists now

Freedom level:
- task-specific, moderately fixed

Should include:
- relation to previous task(s)
- why this task matters
- reminder that the task is bounded production hardening, not redesign

### 6. Main expected targets
Purpose:
- strongly signal the main files

Freedom level:
- task-specific, but not absolute

Recommended wording:
- identify the main target files
- state that these are the main expected targets, not an absolute file lock
- allow minimal additional child-repo adjustments only if truly necessary

### 7. Scope
Purpose:
- define the main behaviors / concerns included

Freedom level:
- task-specific, strongly fixed

Should include:
- the exact behavior family being changed
- the expected semantic boundary
- minimum necessary observability / output expectations if relevant

### 8. Non-goals
Purpose:
- prevent task drift

Freedom level:
- task-specific, strongly fixed

Should include:
- redesigns
- unrelated policy expansion
- frameworkization
- workflow/meta changes
- out-of-scope neighboring concerns

### 9. Production code change policy
Purpose:
- constrain implementation size and direction

Freedom level:
- mostly fixed with task-specific insertions

Should include:
- allowed change type
- disallowed architecture expansion
- repo-local boundedness
- no responsibility spill into neighboring modules unless truly necessary

### 10. Implementation freedom
Purpose:
- preserve DHM comparison value

Freedom level:
- almost fixed

Should include:
- main targets should be strongly preferred
- minimal extra child-repo edits may be allowed if truly necessary
- helper shape is not fixed
- naming is not fixed
- internal representation is not fixed
- avoid over-engineering

### 11. Acceptance criteria
Purpose:
- define success conditions

Freedom level:
- task-specific, strongly fixed

Should include:
- behavior is explicit rather than implicit
- intended semantics are distinguishable from neighboring cases
- behavior is readable in code and tests
- current architecture is preserved
- representative focused protection exists

### 12. Validation handling
Purpose:
- suppress command-proposal interruptions

Freedom level:
- almost fixed

Recommended wording should explicitly include:
- do not assume shell execution
- do not assume venv creation
- do not propose pytest / python / validation commands
- do not interrupt work for manual validation
- validation ownership belongs to the human
- human will validate later using the established workflow
- focus on file editing and repo-local consistency

### 13. Report format
Purpose:
- standardize comparison output

Freedom level:
- mostly fixed with task-specific items

Recommended base items:
1. changed files
2. why any non-main-target files were touched
3. how the main semantics were implemented
4. how neighboring cases were distinguished
5. how save / stop / flow behavior was handled
6. tests added or updated
7. any remaining judgment call worth noting briefly

### 13.5 Report delivery option

Purpose:
- reduce copy/paste overhead from editor AI responses
- keep implementation reports available as child-repo-local artifacts

Optional rule:
- when useful, the editor prompt may instruct the editor AI to write its final report
  to a child-repo-local text file such as:
  - `TASKNNN_report.txt`

Important constraints:
- the report file should be written inside the current child repository only
- do not instruct the editor AI to write reports into root/meta locations
- this is a workflow convenience option, not a mandatory requirement for every task
- if used, the prompt should still specify the required report contents explicitly
- prefer simple text output that the human can inspect with `cat`

Recommended wording example:
- "At the end of your work, write your report to `TASKNNN_report.txt` in this repo root."

### 13.6 New-file handoff reminder

If the task is likely to create new child-repo files
(example: new focused test files), the human + advisor side should remember
that later evidence-preparation commands may need explicit include arguments
for those files.

When presenting `prepare_task_evidence.sh` usage to the user, include any
required new child-repo files in the command arguments if the helper supports
explicit new-file inclusion.

Do not assume new files will be committed automatically.

Purpose:
- reduce missed-file commits
- keep evidence preparation reproducible
- prevent silent omission of newly added focused tests

### 13.7 Report artifact handling note

Purpose:
- prevent accidental promotion of editor report files into evidence commits
- keep report artifacts clearly separated from product deliverables

Recommended wording:
- if the editor is instructed to write `TASKNNN_report.txt`,
  state that the file is review-oriented and report-only by default
- do not treat `TASKNNN_report.txt` as a product deliverable
- do not assume `TASKNNN_report.txt` should be included in
  `./prepare_task_evidence.sh --include-file ...`
- only include such a file in a commit when the human explicitly decides
  that preserving the exact report artifact is necessary

Suggested prompt sentence:
- `Write TASKNNN_report.txt to the child repo root for review convenience only.
   Treat it as report-only by default, not as a commit-target artifact.`

### 14. Final warnings
Purpose:
- repeat the most important drift-prevention rules

Freedom level:
- task-specific, concise

Should include:
- do not widen to nearby design topics
- do not redesign adjacent modules
- keep bounded production hardening
- avoid over-engineering

--------------------------------------------------

## Fixed wording block for execution boundary

The following block can usually be reused almost verbatim:

validation handling:
- shell execution and virtual-environment creation are not part of this task
- do not propose pytest / python / validation commands or interrupt work for manual verification
- validation ownership remains on the human side
- the human will validate later using the established workflow
- focus on file editing and repo-local consistency
- avoid avoidable submission-quality problems in touched code, especially overlong lines
- do not add unnecessary patch / mock setup when the tested path does not actually reach that dependency

--------------------------------------------------

## Fixed wording block for implementation freedom

The following block can usually be reused almost verbatim:

implementation freedom:
- strongly prefer the main expected targets
- however, do not treat them as an absolute hard lock if a truly minimal child-repo-local adjustment is necessary
- helper split, naming, internal representation, and exact wording do not need to be fixed in advance
- preserve enough implementation freedom for meaningful Double Helix comparison
- avoid over-engineering
- preserve boundedness and explainability

--------------------------------------------------

## Recommended prompt skeleton

Use this as the default shape.

```text
対象リポジトリ:
- `<repo-path>`

あなたの役割:
- この repo 内での bounded implementation editor として作業してください
- judge / adoption decider ではありません
- task drift を避けつつ、必要最小限の実装とテスト更新に集中してください

今回の task:
`<TASK-NUMBER>`

task goal:
`<ONE-SENTENCE-GOAL>`

背景意図:
- `<WHY-NOW-1>`
- `<WHY-NOW-2>`
- bounded production hardening task として扱ってください

main expected targets:
- `<MAIN-FILE-1>`
- `<MAIN-FILE-2>`

scope:
- `<SCOPE-ITEM-1>`
- `<SCOPE-ITEM-2>`
- `<SCOPE-ITEM-3>`

期待する意味論 / 振る舞い:
- `<SEMANTIC-EXPECTATION-1>`
- `<SEMANTIC-EXPECTATION-2>`
- `<SEMANTIC-EXPECTATION-3>`

non-goals:
- `<NON-GOAL-1>`
- `<NON-GOAL-2>`
- `<NON-GOAL-3>`
- `<NON-GOAL-4>`

production code change policy:
- `<ALLOWED-CHANGE-1>`
- `<ALLOWED-CHANGE-2>`
- `<DISALLOWED-CHANGE-1>`
- `<DISALLOWED-CHANGE-2>`

implementation freedom:
- strongly prefer the main expected targets
- however, do not treat them as an absolute hard lock if a truly minimal child-repo-local adjustment is necessary
- helper split, naming, internal representation, and exact wording do not need to be fixed in advance
- avoid over-engineering
- preserve boundedness and explainability

acceptance criteria:
- `<ACCEPTANCE-1>`
- `<ACCEPTANCE-2>`
- `<ACCEPTANCE-3>`
- `<ACCEPTANCE-4>`

validation handling:
- shell execution and virtual-environment creation are not part of this task
- do not propose pytest / python / validation commands or interrupt work for manual verification
- validation ownership remains on the human side
- the human will validate later using the established workflow
- focus on file editing and repo-local consistency

報告してほしい内容:
1. changed files
2. why any non-main-target files were touched
3. how the target behavior was implemented
4. how neighboring cases were distinguished
5. how save / stop / flow behavior was handled
6. tests added or updated
7. any remaining judgment call worth noting briefly

注意:
- `<WARNING-1>`
- `<WARNING-2>`
- bounded production hardening に留めてください

