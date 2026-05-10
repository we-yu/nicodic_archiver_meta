# SubTask target denylist policy seam adoption log

## Task

- Title: target denylist / ignore policy seam
- Type: single-editor bounded SubTask
- Adopted implementation: Copilot
- Final product commit on main: 359bf50
- Implementation branch: Subtask-target-denylist-policy-seam-copilot
- Integration path: GitHub PR merge into product `main`

## Purpose

Before re-enabling runtime cron, prevent known high-volume, low-value
articles from being registered or collected.

This task targets complete exclusion of known articles from collection.
It intentionally does not implement per-article response truncation or a
1,000,000 response cap behavior change.

## Denylisted articles

- `480340`
  - title: `>>3が理解できることが不幸`
  - canonical URL:
    `https://dic.nicovideo.jp/a/%3E%3E3%E3%81%8C%E7%90%86%E8%A7%A3%E3%81%A7%E3%81%8D%E3%82%8B%E3%81%93%E3%81%A8%E3%81%8C%E4%B8%8D%E5%B9%B8`
  - numeric URL: `https://dic.nicovideo.jp/id/480340`
- `237789`
  - title: `4294967295`
  - canonical URL: `https://dic.nicovideo.jp/a/4294967295`
  - numeric URL: `https://dic.nicovideo.jp/id/237789`

## Adopted implementation

- Added `collection_policy.py` as a small Python policy seam.
- Moved `DENYLIST_ARTICLE_IDS` from `orchestrator.py` into the shared policy
  seam.
- Kept `RESPONSE_CAP` and `QUEUE_DRAIN_PER_ARTICLE_RESPONSE_CAP` in
  `orchestrator.py` to avoid broad policy churn.
- Added denylist checks at the shared target registration boundary in
  `target_list.register_target_url()`.
- Added Web manual registration feedback:
  `This article is excluded from archive collection.`
- Added delete-request feeder skip accounting:
  `skipped_denylisted_candidates`.
- Added direct `main.py add-target` operator-facing denylisted messaging.
- Preserved scrape-side `skip_denylist` protection in `orchestrator.py`.

## Non-goals

- No response cap behavior change.
- No per-article scrape truncation.
- No `denylist.txt`.
- No DB-backed denylist table.
- No `target.deny_flag`.
- No DB schema migration.
- No runtime DB direct edit.
- No cron restart.
- No root/meta file changes by editor AI.
- No runtime checkout implementation.

## Review notes

The initial editor result had two issues:

1. `collection_policy.py` was missing EOF newline.
2. delete-request feeder raw `/id/480340` candidates were dropped before
   `register_target_url()` was reached.

A focused fix prompt was re-run on the same Copilot branch.

The final result skips raw denylisted `/id/<digits>` feeder candidates before
archive DB resolution or registration, and exposes the skip in feeder summary
output.

## Validation

Post-merge validation was run from the workspace root with:

`./validate_helix.sh`

Result:

- Copilot main: PASS, 370 passed
- Cursor main: PASS, 370 passed

## Convergence

Post-merge convergence was checked with:

`./compare_helix.sh --all`

Result:

- `copilot/` and `cursor/` match for selected files.
- Helix converged.

## Runtime status

Runtime reflection and cron restart were not part of the adoption decision.

Cron remains intentionally stopped at this point.

Runtime reflection and read-only runtime DB checks should be handled as the
next operational closeout step.

## Conclusion

The SubTask is adopted.

The product `main` now contains a bounded denylist policy seam and shared
registration-time protection for known high-volume articles.

## Runtime reflection follow-up

Runtime reflection was completed after adoption.

Observed:
- runtime checkout fast-forwarded to product main commit `359bf50`
- runtime image rebuild and force-recreate completed successfully
- runtime Web container started on `127.0.0.1:58001`
- public preliminary Web surface was reachable through
  `nicoarc-prelim.mimizuku.dev`
- runtime policy smoke confirmed:
  - `find_denylisted_article_id(.../id/480340) == "480340"`
  - `find_denylisted_article_id(.../a/4294967295) == "237789"`
- runtime DB counts after reflection:
  - `articles=40`
  - `responses=20153`
  - `target=12149`
- cron remained intentionally disabled.

Runtime target follow-up:
- Existing active target `4294967295` was found after reflection.
- This row predated the denylist policy seam.
- It was deactivated through the operator target tooling from the runtime
  container:
  `python main.py operator target deactivate 4294967295 a --db /app/data/nicodic.db`
- Post-deactivation confirmation showed:
  `('4294967295', 'a', 'https://dic.nicovideo.jp/a/4294967295', 0)`
- Raw SQL DB editing was avoided.
- Cron remained intentionally disabled after this cleanup.

