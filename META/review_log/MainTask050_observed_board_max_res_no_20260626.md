# MainTask050: observed board max response number persistence and display

## Task

MainTask050-observed-board-max-res-no-persistence-and-display

## Decision

Adopted: Cursor with one hybrid adjustment from Copilot.

Non-adopted comparison:

- Copilot implementation was retained and pushed as comparison evidence.

Hybrid adjustment:

- Cursor was used as the base implementation.
- Copilot's saved_rows_fallback behavior was ported into the already-up-to-date scrape path.

## Purpose

Registered Articles previously displayed `Saved Max Res No`, which was the
maximum response number among locally saved response rows.

The intended user-facing meaning is different:

- `Saved Responses` = number of locally saved response rows
- `saved_max_res_no` = internal maximum saved response number
- `Observed Max Res No` = maximum response number observed on the NicoNicoPedia board

NicoNicoPedia board response content may be deleted or hidden, but response
numbers themselves are not removed. Therefore, the observed board max response
number can be treated as a monotonic board-level counter.

## Adopted implementation

The adopted implementation added target-side observed max persistence:

- `target.observed_max_res_no`
- `target.observed_max_res_no_at`
- `target.observed_max_res_no_source`

The implementation keeps `saved_max_res_no` internally in
`article_response_stats` and row dictionaries, but removes it from the
Registered Articles UI and page CSV.

The visible Registered Articles column was changed:

- removed: `Saved Max Res No`
- added: `Observed Max Res No`

The CSV column was changed consistently:

- removed: `saved_max_res_no`
- added: `observed_max_res_no`

## Storage semantics

Observed max update rule:

- `None` / parse miss: no write
- invalid or negative value: ignored safely
- stored NULL: set value, timestamp, source
- observed greater than stored: update value, timestamp, source
- observed equal to stored: refresh timestamp/source
- observed lower than stored: do not lower or overwrite timestamp/source

This makes partial observations and saved-row fallback safe.

## Observation sources

Implemented sources:

- `article_top_preview`
  - observed during article registration from the already fetched article top HTML
- `bbs_page_scrape`
  - observed during scrape from collected BBS responses
- `saved_rows_fallback`
  - used on the already-up-to-date scrape path to populate existing targets from saved rows as a lower-bound observation

The saved rows fallback was the hybrid adjustment adopted from Copilot. It lets
already fully saved targets gradually populate observed max values during normal
periodic scraping even when no new responses are fetched.

## Registered Articles behavior

Registered Articles now shows:

- Article ID
- Type
- Title
- Canonical URL
- Created At
- Saved Responses
- Observed Max Res No
- Last Scraped

Legacy sort aliases were kept compatible:

- `sort_by=saved_max_res_no`
- `sort_by=latest_scraped_max_res_no`

Both map to the observed max sort for user-facing behavior.

## Validation

Before adoption:

- Cursor implementation passed validation.
- After the hybrid adjustment, Cursor validation passed:
  - 513 tests passed
  - `git diff --check` passed

After GitHub merge and child repo synchronization:

- `compare_helix.sh --all` passed
- `validate_helix.sh` passed
- copilot: 513 tests passed
- cursor: 513 tests passed

## Runtime reflection

Runtime reflection was performed after confirming:

- no periodic lock
- no soft-stop file
- no scrape-like process

Runtime checkout was fast-forwarded to product main and runtime container was recreated with:

- `tools/runtime_up.sh`

Because existing runtime DBs do not automatically receive compatibility ALTERs
only from container recreation, explicit runtime `init_db('/app/data/nicodic.db')`
was run through the root/meta runtime helper.

Result:

- `init_db_ok`

Runtime target schema then contained:

- `observed_max_res_no`
- `observed_max_res_no_at`
- `observed_max_res_no_source`

## Runtime Web and CSV verification

Runtime curl checks:

- `/registered?page=1&per_page=100`
  - http=200
  - time=0.093206 seconds
- `/registered?sort_by=observed_max_res_no&sort_order=desc&page=1&per_page=100`
  - http=200
  - time=0.091304 seconds
- `/registered?sort_by=saved_max_res_no&sort_order=desc&page=1&per_page=100`
  - http=200
  - time=0.091318 seconds

HTML header verification:

- `Observed Max Res No` is present
- `Saved Responses` is present
- `Saved Max Res No` is no longer present as a visible column

CSV header verification:

- `observed_max_res_no` is present
- `saved_max_res_no` is no longer present

Runtime browser verification:

- Registered Articles rendered normally
- `Observed Max Res No` appeared in the intended position
- A newly registered Linux article showed `Observed Max Res No = 207`
- This confirmed the registration-time article top preview path in practice

## Existing target state

Immediately after schema addition, existing targets were expected to have NULL observed max values.

Observed check before later registrations/scrapes:

- active targets: 12239
- observed non-null: 0

This is expected. Existing rows should fill over time through:

- new registration article-top observation
- periodic scraping
- already-up-to-date saved_rows_fallback

## Safety notes

No full runtime DB backup was created.

This was intentional because the runtime schema change was additive and nullable:

- no archive-critical rows were rewritten
- no saved responses were rewritten
- no `responses` table index was added
- no 20GB-class runtime DB copy was made

Runtime final status after verification:

- no periodic lock
- no soft-stop file
- no scrape-like process

## Known limitations

- Existing targets start with NULL observed max until touched by registration or scrape.
- Article-top empty-board detection is conservative.
- `observed_max_res_no_at` and `observed_max_res_no_source` are stored but not yet surfaced in the UI.
- No full backfill was performed.
- Verification of periodic random-start filling should be checked after the next scheduled scrape cycle.

## Follow-up candidates

Recommended immediate follow-up:

- after the next periodic scrape cycle, verify that `observed_max_res_no` begins filling for existing targets

Recommended future tasks:

- optional bounded operator to initialize NULL observed max values from `article_response_stats.saved_max_res_no`
- optional operator view showing `observed_max_res_no_at` and source
- optional saved/observed coverage ratio display
- optional article-top HTML fixture hardening for board preview parsing
