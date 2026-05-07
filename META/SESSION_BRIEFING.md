# SESSION BRIEFING

Short summary of PROJECT_STATE.md for context recovery.

--------------------------------------------------

## 完了済みタスク（Completed tasks）

| Task   | 概要 |
|--------|------|
| TASK001 | 基本実装。Copilot 実装を採用。両リポジトリを同一状態に揃えた。 |
| TASK002 | main.py を CLI エントリポイントに絞り、orchestration を orchestrator.py に分離。Copilot 採用。 |
| TASK003 | 最小ユニットテスト追加（main.py / orchestrator.py / conftest.py）。Cursor 採用。本番コード変更なし。 |
| TASK004 | parser の振る舞い保護テスト追加。本番コード変更なし。両リポジトリ再整合済み。 |
| TASK005 | root ヘルパースクリプト群を追加（new_task_branches.sh / validate_helix.sh / collect_task_review.sh 等）。WORKSPACE.md / META/README.md 更新済み。 |
| TASK006 | storage テスト追加（test_storage.py）。Cursor ハイブリッド採用。本番コード変更なし。 |
| TASK007 | orchestration フローテスト拡充（test_orchestrator.py）。Cursor 採用。本番コード変更なし。 |

--------------------------------------------------

## 次タスクの状態（Next task status）

TASK007 完了。次タスクは **未確定**。

将来方向の参照として `META/ROADMAP_REFERENCE.md` が存在するが、
これは **非権威的** な参考情報であり、固定されたタスク順序を示すものではない。

次タスクを決定する前に、人間のレビュアーが方針を確定する必要がある。

--------------------------------------------------

## Repo boundary の扱い（Repo boundary rules）

| 所有者 | 管理対象 |
|--------|---------|
| **meta リポジトリ（root）** | AI_CONTEXT.md / PROJECT_STATE.md / WORKSPACE.md / META/ / スナップショット / root ヘルパースクリプト |
| **product リポジトリ（copilot/ / cursor/）** | main.py / orchestrator.py 等のアプリコード / tests/ / 製品向けドキュメント |

### ハードルール

- プロダクトコード・テストを meta リポジトリにコミットしてはならない。
- meta ファイルを product リポジトリの成果物として扱ってはならない。
- commit / merge / push の前に、対象ファイルがどのリポジトリに属するかを必ず確認する。

### 過去のインシデント教訓

tests/test_storage.py が誤って meta リポジトリに取り込まれそうになった事例がある。
リポジトリ境界は「読んで理解した」だけでは不十分であり、実際の統合操作ごとに明示的に適用する必要がある。

--------------------------------------------------

## 現在のアプリケーション構成（Current application structure）

```
main.py
orchestrator.py
cli.py
http_client.py
parser.py
storage.py

tests/
  conftest.py
  test_main.py
  test_orchestrator.py
  test_parser.py
  test_storage.py
```

--------------------------------------------------

## 参照ファイル（Reference files）

新セッション開始時は以下の順で読む：

1. AI_CONTEXT.md
2. PROJECT_STATE.md
3. WORKSPACE.md
4. project_snapshot.txt
5. project_knowledge_snapshot.txt

必要に応じて：

- META/review_log/*.md
- META/TASK_CYCLE_CHECKLIST.md
- META/REPO_BOUNDARY_GUARDRAILS.md
