# Runtime cron scrape schedule tuning

## Date

2026-06-23

## Purpose

Runtime scraping had largely converged. Recent `RUN DIGEST` totals showed that
newly collected responses had become much smaller than earlier catch-up runs.

The runtime cron schedule was adjusted from broad long runs to a lighter
maintenance-oriented schedule.

## Previous schedule

- 00:05 default, 8500 seconds
- 03:05 reverse, 8500 seconds
- 06/09/12/15/18/21:05 random_rotation, 8500 seconds

## New schedule

- 00:05 default, 1200 seconds
- 01:05 reverse, 8400 seconds
- 04/07/10/13/16/19:05 random_rotation, 8400 seconds

## Rationale

The intended daily flow is:

1. Light ascending/default pass checks early/newly ordered targets.
2. Reverse pass picks up newly registered DeleteFeeder targets soon after.
3. Random rotation continues smoothing the archive throughout the day.

The random schedule starts at 04:05 because the 01:05 reverse run is allowed to
run for 2h20m, ending around 03:25. A 03:05 random run would overlap.

## Notes

- No product code was changed.
- Runtime DB was not modified directly.
- Cron-only operational change.
- Future candidate: prioritize existing articles that receive delete requests.
