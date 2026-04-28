# TASK040 adoption log

- task: TASK040 canonical URL identity merge
- adopted: Cursor
- non-adopted: Copilot
- reason:
  - Cursor keeps a strict safe keep-identity rule based on canonical /a/<slug>
  - Cursor does not auto-merge no-slug groups
  - Cursor handles target rows conservatively
  - Cursor passed copy-DB dry-run/apply checks for the real duplicate set
  - Cursor did not reintroduce article_type='id'
  - Cursor log compaction remained bounded and reviewable

- non-adopted notes:
  - Copilot auto-merged a no-slug duplicate group by picking a numeric keep identity
  - That behavior is less conservative than the TASK040 safety direction

- validation:
  - compare_helix.sh --all: to be recorded after main realignment
  - validate_helix.sh: PASS on synchronized final state

- runtime note:
  - runtime cron remains paused until runtime DB dry-run and apply finish
