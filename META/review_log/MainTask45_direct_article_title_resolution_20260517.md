# MainTask: direct article title resolution

## Summary

MainTask-direct-article-title-resolution corrected the article title
resolution boundary.

The application now treats non-URL user input as an exact Nicopedia article
title and resolves it by directly fetching:

- `https://dic.nicovideo.jp/a/<URL-encoded user input>`

This restores the intended product philosophy:

- the user specifies the exact article
- the app attempts to fetch that exact article
- if that exact article does not exist, the app returns not_found
- the app does not depend on Nicopedia Search for normal title registration

## Background

A user attempted to register:

- `ストローマン論法`

Expected behavior:

- resolve the exact article page directly
- register it as a scraping target if the page exists

Observed pre-fix behavior:

- Web UI showed `Article was not found.`
- the target was not registered
- investigation showed that title input used a Nicopedia Search URL
- the Search URL could fail even when the direct article page existed

## Adopted decision

The project decided that normal title input must not use Nicopedia Search.

This was treated as a product philosophy / resolver-boundary correction, not
as a request to update the Search URL.

## Adopted implementation

Cursor implementation was adopted.

Main behavior after adoption:

- URL input continues to use direct article URL resolution.
- Non-URL title input constructs `/a/<encoded title>` and fetches that page
  directly.
- Existing canonical / article-id extraction remains the source of normalized
  target identity.
- Search-based title resolution was removed from the normal path.
- Fuzzy matching, typo correction, alternate suggestions, and Search fallback
  were not added.

## Validation

Before adoption:

- Copilot and Cursor variants were both implemented and validated.
- Cursor was selected for adoption.
- validate_helix.sh passed for both variants before selection.
- Cursor variant reported 413 tests passed.

After adoption:

- product main was reflected to the runtime checkout.
- runtime container was rebuilt/recreated through the standard reflection flow.

## Runtime Web smoke

Runtime Web smoke succeeded after reflection.

Smoke target:

- `ストローマン論法`

Observed result:

- Web registration succeeded.
- The UI showed the article was registered for archive checking.
- Registered Articles showed:
  - article_id: 5400838
  - type: a
  - title: ストローマン論法
- This confirmed that exact title input now resolves directly to the article
  page and registers the target in the provisional runtime environment.

## Development Web note

A child-repo development Web smoke was attempted first.

That environment returned an internal error and used a non-runtime-like old DB.
The direct article page fetch from inside the container returned HTTP 200, so
the development Web failure was treated as an environment-specific smoke issue,
not as adoption evidence against the resolver change.

## Explicit non-goals

This task intentionally did not introduce:

- Nicopedia Search fallback
- fuzzy title matching
- typo recovery
- alternate title suggestions
- DB schema changes
- scrape behavior changes
- cron/runtime policy changes
- Delete Feeder changes
- article_type="id"
- Max Res No semantic changes

## Follow-up candidate: zero-response boards

During runtime review, a separate behavior was observed:

- articles that exist but have no board responses can continue to look like
  never-scraped targets in the Registered Articles list

Desired future behavior:

- once an existing article is scraped and no responses are found, it should be
  represented as a scraped article with saved responses = 0 and max res no = 0
- this should apply regardless of why the board has no responses
- examples include boards with no posts and boards unavailable due platform-side
  or petition-related restrictions
- if an article previously had archived responses but later the board becomes
  unavailable, existing archived responses must remain downloadable

This should be handled as a separate bounded task.
