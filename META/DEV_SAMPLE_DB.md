# Development Sample DB Helper

This document describes the root/meta helper for building a lightweight
development sample SQLite DB from the large provisional runtime DB.

## Purpose

The runtime DB is now too large to copy wholesale into development checkouts.

This helper exists to:

- read the runtime DB as input only
- extract a fixed, bounded article set
- cap copied responses per article
- validate the result before publish
- optionally distribute the finished sample DB to child repo runtime data paths

This is a root/meta workflow helper.

It is not product code.
It does not change scrape behavior.
It does not fix runtime observation DB lock tolerance.

Observation DB lock tolerance remains a separate product SubTask.

## Files

- `./build_dev_sample_db.sh`
- `META/scripts/build_dev_sample_db.py`

## Source DB safety

Default source DB path:

- `/home/manage/product/nicodic_archiver_runtime/runtime/data/nicodic.db`

Safety rules:

- the source runtime DB is treated as read-only
- the helper never modifies the source DB
- the helper builds a temporary destination DB first
- validation runs against the temporary DB before publish
- only after validation does the helper publish the sample DB

## Schema creation

The helper prefers current product schema creation through `storage.init_db`
loaded from an explicit read-only checkout path.

Default schema source checkout:

- `copilot/`

Reason:

- keeps the sample DB schema aligned with current product expectations
- avoids hand-maintaining a duplicate root/meta schema definition

The schema source checkout path is explicit and overrideable.

## Fixed sample article set

Required article IDs with `article_type=a`:

- `5512354`
- `5513908`
- `5527590`
- `5523983`
- `5527595`
- `5523746`
- `1919260`
- `5228140`
- `4493425`
- `5535296`
- `5104766`
- `5287728`
- `4897961`
- `5509670`
- `5351038`
- `5501738`
- `4982057`

Optional article ID:

- `5400838`

If a required article is missing from the source DB, the build fails.

If the optional article is missing, the build may still succeed and the result
is recorded in the manifest.

## Response cap

Maximum copied responses per article:

- `200`

Deterministic selection policy:

- copy responses in ascending `res_no` order
- keep the lowest `res_no` rows first
- stop at the configured cap

Reason:

- stable sample output matters more than recency for development fixtures
- later runtime growth should not constantly reshuffle the sample selection

## Hard exclusion

The sample DB must not include responses for:

- `article_id=5511090`
- `article_type=a`

The helper includes an explicit validation check for this exclusion.

## Manifest

The helper writes a manifest beside the published sample DB:

- `dev_sample_manifest.json`

Manifest contents include at least:

- source DB path
- generated timestamp
- required article IDs
- optional article handling result
- response cap
- per-article copied response counts
- validation summary
- excluded article check result

## Staging flow

Typical flow:

1. create a temporary DB under the staging directory
2. initialize schema from explicit product checkout
3. copy only the bounded article set
4. cap responses per article
5. validate the temporary DB
6. write the manifest
7. publish the DB and manifest to the requested output location

Default output DB:

- `META/out/dev_sample/nicodic.db`

Default staging directory:

- `META/out/dev_sample`

## Future distribution flow

The helper supports an explicit future distribution mode for copying the
published sample DB to both child repos:

- `copilot/runtime/data/nicodic.db`
- `cursor/runtime/data/nicodic.db`

Distribution is explicit, not automatic.

Suggested human-run pattern:

```bash
./build_dev_sample_db.sh --overwrite
```

Build plus explicit distribution:

```bash
./build_dev_sample_db.sh --overwrite --distribute-to-children
```

Alternative source DB or output path:

```bash
./build_dev_sample_db.sh --source-db /path/to/source.db --output-db META/out/dev_sample/custom.db --staging-dir META/out/dev_sample
```

## What this helper does not do

This helper does not:

- modify the runtime source DB
- run scraping
- run batch or periodic jobs
- run Web operations
- restart runtime containers
- change crontab
- fix runtime observation DB lock tolerance
- edit existing files under `copilot/`
- edit existing files under `cursor/`

## Self-check support

The Python implementation includes a lightweight temporary self-check mode:

```bash
./build_dev_sample_db.sh --self-check
```

The self-check uses temporary DB files only.

It does not touch the runtime DB or child repo DB paths.