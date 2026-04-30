# DB Schema Notes

This file records the current SQLite schema meaning for the project.

It is AI-readable workflow memory.
It is not a migration file.
It is not executable source code.

Authoritative runtime behavior is still defined by product code and the actual
SQLite database.

--------------------------------------------------

## Purpose

The project uses SQLite as the main archive and target-registry persistence
layer.

This document exists to prevent semantic confusion around names such as:

- `article_id`
- `article_type`
- `canonical_url`

In particular, `article_id` in the current DB should not be assumed to mean the
numeric NicoNicoPedia `/id/<number>` value.

--------------------------------------------------

## Important identity terminology

### Storage article identity

The storage identity is the identity used by this application to persist and
join archive rows.

It is generally represented by:

- `article_id`
- `article_type`

For current `/a/<title>` archive rows, `article_id` may represent the canonical
article key / slug identity used by this application.

### NicoNicoPedia numeric article ID

NicoNicoPedia pages may also expose numeric IDs such as:

- `/id/5560706`

These numeric IDs may appear in page metadata, links, or response HTML.

However, the current schema should not be assumed to have a dedicated canonical
numeric Nico article ID column unless explicitly confirmed by schema and data
inspection.

If numeric Nico article IDs are needed for display or lookup, that should be
handled by a dedicated follow-up task with parser / storage / backfill design.

Candidate follow-up:

- TASK041B: Capture and display numeric NicoNicoPedia article ID

--------------------------------------------------

## Core tables

### target

Purpose:

Stores scrape target registry rows.

Known columns include:

- `id`
- `article_id`
- `article_type`
- `canonical_url`
- `is_active`
- `created_at`
- `is_redirected`
- `redirect_target_url`
- `redirect_detected_at`

Notes:

- `target.article_id` is a storage / target identity.
- It should not automatically be interpreted as numeric Nico article ID.
- `target` does not currently have a `title` column.

### articles

Purpose:

Stores one saved archive article row per storage article identity.

Common columns include:

- `article_id`
- `article_type`
- `canonical_url`
- `title`
- `created_at`
- other article metadata columns depending on current migrations

Notes:

- `articles.article_id` is the archive storage identity.
- It may be numeric for some historical rows or slug/key-like for canonical
  `/a` rows depending on the ingestion and migration history.
- After TASK040, canonical `/a/<title>` identity is the practical saved-archive
  mainline for historical duplicate canonical URL groups.

### responses

Purpose:

Stores saved BBS responses.

Common identity columns include:

- `article_id`
- `article_type`
- `res_no`

Common response payload columns include:

- `poster_name`
- `poster_id`
- `posted_at`
- `content_text`
- `content_html`

Notes:

- Response uniqueness is expected to be based on storage article identity plus
  response number.
- Numeric Nico article IDs may appear inside `content_html`, but that does not
  make them canonical DB article IDs.

--------------------------------------------------

## Current caution points

### article_id naming ambiguity

The name `article_id` is historically overloaded.

It may refer to:

1. this application's storage identity
2. a slug/key derived from `/a/<title>`
3. historical numeric-looking archive identity
4. NicoNicoPedia's numeric `/id/<number>` value

Do not assume these are the same.

Before adding UI columns or migrations that depend on numeric article IDs,
inspect both schema and representative data.

### article_type='id'

Current post-TASK040 / SUBTASK010 baseline expects `article_type='id'` rows not
to reappear in normal target/archive state.

If `article_type='id'` rows are found again, treat that as a regression or a
maintenance issue unless a later task explicitly redefines the behavior.

### canonical_url

`canonical_url` is the strongest alias key currently used for canonical article
identity merge work.

TASK040 used `canonical_url` to merge historical numeric/slug identity splits
for `article_type='a'` rows.

--------------------------------------------------

## Runtime safety notes

- Runtime DB is not a scratch DB.
- Migration and maintenance scripts should accept an explicit DB path.
- Dry-run should be the safe default for destructive or normalizing operations.
- Runtime DB should be tested through a copy DB before apply.
- Runtime DB should not be changed implicitly by tools that default to
  `data/nicodic.db` without an explicit operator decision.

--------------------------------------------------

## Snapshot note

When this file changes, regenerate the authoritative snapshot with:

`./export_snapshot.sh`

