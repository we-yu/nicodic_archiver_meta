# RuntimeOps: build dev sample DB

## Summary

RuntimeOps-build-dev-sample-db was completed as a root/meta workflow helper
task.

This task added a safe helper for building a compact development sample SQLite
DB from the large provisional runtime DB.

## Task type

- Root/meta task
- Not a Double Helix product task
- Not a Copilot/Cursor product implementation task
- Product code was not changed

## Added files

- `build_dev_sample_db.sh`
- `META/scripts/build_dev_sample_db.py`
- `META/DEV_SAMPLE_DB.md`
- `RuntimeOps-build-dev-sample-db_report.txt`

## Updated files

- `.gitignore`
- `project_snapshot.txt`
- `project_knowledge_snapshot.txt`

## Purpose

The runtime DB had grown too large to copy wholesale into development
checkouts.

The new helper creates a compact sample DB from a fixed set of runtime articles
and can explicitly distribute that DB into:

- `copilot/runtime/data/nicodic.db`
- `cursor/runtime/data/nicodic.db`

This gives development checkouts realistic but lightweight SQLite data without
copying the full runtime DB.

## Safety boundaries

Preserved boundaries:

- Existing files under `copilot/` were not edited.
- Existing files under `cursor/` were not edited.
- Runtime product code was not edited.
- Runtime DB was treated as read-only input.
- No live scraping was performed.
- No crontab change was performed.
- No Docker or runtime container state change was performed.
- Full runtime DB copy was avoided.

Generated sample DB files are treated as local generated artifacts.

## Sample DB behavior

The helper:

- uses current product `storage.init_db` from a read-only product checkout
  when building the destination schema
- creates a temporary DB first
- copies only fixed selected articles
- copies at most 200 responses per article
- selects responses deterministically by ascending `res_no`
- validates the temporary DB before publishing
- emits `dev_sample_manifest.json`
- requires explicit `--distribute-to-children` before writing child repo DBs

## Fixed article set

Required `article_type='a'` article IDs:

- 5512354
- 5513908
- 5527590
- 5523983
- 5527595
- 5523746
- 1919260
- 5228140
- 4493425
- 5535296
- 5104766
- 5287728
- 4897961
- 5509670
- 5351038
- 5501738
- 4982057

Optional article ID:

- 5400838

## Delete Feeder guard

The sample DB must not contain responses for:

- `article_id='5511090'`
- `article_type='a'`

The generated sample validation confirmed the excluded response count was zero.

## Validation

Human-run validation completed:

- `git diff --check` passed.
- `python3 -m py_compile META/scripts/build_dev_sample_db.py` passed.
- `bash build_dev_sample_db.sh --help` worked.
- `bash build_dev_sample_db.sh --self-check` passed.
- `bash build_dev_sample_db.sh --overwrite` generated a staging sample DB.
- `bash build_dev_sample_db.sh --overwrite --distribute-to-children` generated
  and distributed the sample DB to both child repo runtime data paths.

Observed sample DB result:

- DB size: about 744 KiB
- `articles`: 17 rows for `article_type='a'`
- `responses`: 752 rows
- `5511090/a` responses: 0
- per-article response cap violations: none

Child repo status remained clean after distribution because runtime DB files
are local generated artifacts.

## Non-goals

This task did not address:

- runtime observation DB lock tolerance
- SQLite access hardening
- runtime cron restoration
- runtime scraping restart
- product code changes
- schema redesign
- scrape behavior changes

## Follow-up

The immediate follow-up candidate is:

- `SubTask-BugFix-observation-db-lock-tolerance`

Goal:

- keep archive-critical writes fatal
- make scrape-run observation / telemetry lock failures bounded and non-fatal
- avoid turning telemetry-only lock failures into whole-run failures
- preserve response storage integrity

A broader later candidate is:

- `MainTask-sqlite-access-hardening`

