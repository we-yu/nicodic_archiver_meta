
## 2026-05-08 Runtime DB reset after TASK043 repair rehearsal

Context:
- TASK042 restored numeric article_id storage semantics.
- TASK043 added legacy slug article_id repair tooling.
- Subsequent SubTask-BugFix work added unresolved network skip handling and
  target-only numeric slug repair.
- Copy DB repair rehearsal mostly worked, but unresolved/skipped cases and
  repeated validation friction made further historical DB repair too costly.

Decision:
- Abandoned further runtime DB patching as an operational cost decision.
- Existing runtime scrape data was treated as disposable personal-use state.
- Preserved one compressed backup:
  `runtime/data/nicodic.before_reset_20260508_131736.db.gz`
- Exported active canonical URLs from target before reset.
- Excluded the known max-BBS-response-count challenge article:
  `https://dic.nicovideo.jp/a/%3E%3E3%E3%81%8C%E7%90%86%E8%A7%A3%E3%81%A7%E3%81%8D%E3%82%8B%E3%81%93%E3%81%A8%E3%81%8C%E4%B8%8D%E5%B9%B8`
- Re-imported 12149 targets into a fresh runtime DB.
- Ran a bounded manual smoke shot with:
  `ONESHOT_LIMIT_DURATION_SECONDS=1800`

Smoke result:
- `periodic-once` completed successfully.
- `articles=40`
- `responses=20153`
- `duplicate_response_keys=0`
- `articles_id_type=0`
- `responses_id_type=0`
- `target_id_type=0`
- `legacy_slug_articles=0`
- excluded article remained absent.

Follow-up:
- Re-enable runtime cron with bounded one-shot duration.
- Add a later task to review ignore-list behavior for max-BBS-response-count
  challenge pages.

