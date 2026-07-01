# WorkflowTask-report-artifact-sweeper

## Summary

A root/meta report-artifact sweeper helper was added.

The purpose is to keep temporary editor/report artifacts from accumulating in
the root workspace and child product working directories.

Raw editor reports remain temporary working artifacts. Durable task memory
continues to live in curated files such as:

- `META/review_log/*.md`
- `PROJECT_STATE.md`
- other explicit META source-of-truth files

## Added helper

Added:

- `sweep_report_artifacts.sh`

Default behavior:

- dry-run only
- selects report/review artifacts whose mtime is at least 3 days old
- skips tracked files
- moves only with explicit `--apply`

Default archive destination:

- `META/out/report_archive/YYYYMMDD/`

Candidate patterns:

- root-level `*report*.txt`
- root-level `*report*.md`
- `copilot/*report*.txt`
- `copilot/*report*.md`
- `cursor/*report*.txt`
- `cursor/*report*.md`
- `META/out/review_snapshot*.txt`

Safety notes:

- product data/config files such as `requirements.txt`, `targets.txt`,
  `scrape_targets.txt`, and runtime data files are not matched by the intended
  patterns
- tracked files are skipped even if their names match
- generated archive output remains under `META/out/` and is not intended for
  Git commits

## Snapshot reminder

`META/scripts/export_snapshot.sh` now prints an AI-HINT reminding the operator
and Advisor-AI to run the report sweeper during task closeout.

This is intentionally a hint rather than an automatic cleanup step.

## Boundaries

No product code was changed.

No child repository code was changed.

No runtime DB, cron, Docker, or runtime checkout state was changed.

## Validation

- `bash -n sweep_report_artifacts.sh`: PASS
- `./sweep_report_artifacts.sh --older-than-days 3`: dry-run available for
  operator review

## Conclusion

The sweeper is a manual, opt-in root/meta workflow helper. It should be used
near task closeout after durable review memory has been written.

