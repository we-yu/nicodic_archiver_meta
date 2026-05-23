#!/usr/bin/env python3
"""Build a lightweight development sample DB from the runtime DB.

The source runtime DB is treated as read-only input.
The destination DB is built in a temporary location, validated, and only then
published to the requested output path.
"""

from __future__ import annotations

import argparse
from dataclasses import dataclass
from datetime import datetime, timezone
import importlib.util
import json
import shutil
import sqlite3
import tempfile
from pathlib import Path


ROOT_DIR = Path(__file__).resolve().parents[2]
DEFAULT_SOURCE_DB = Path(
    "/home/manage/product/nicodic_archiver_runtime/runtime/data/nicodic.db"
)
DEFAULT_OUTPUT_DB = ROOT_DIR / "META/out/dev_sample/nicodic.db"
DEFAULT_STAGING_DIR = ROOT_DIR / "META/out/dev_sample"
DEFAULT_SCHEMA_SOURCE_CHECKOUT = ROOT_DIR / "copilot"
DEFAULT_RESPONSE_CAP = 200
ARTICLE_TYPE = "a"
HARD_EXCLUDED_ARTICLE_ID = "5511090"

REQUIRED_ARTICLE_IDS = [
    "5512354",
    "5513908",
    "5527590",
    "5523983",
    "5527595",
    "5523746",
    "1919260",
    "5228140",
    "4493425",
    "5535296",
    "5104766",
    "5287728",
    "4897961",
    "5509670",
    "5351038",
    "5501738",
    "4982057",
]

OPTIONAL_ARTICLE_IDS = ["5400838"]


@dataclass(frozen=True)
class BuildResult:
    output_db: Path
    manifest_path: Path
    manifest: dict


class BuildError(RuntimeError):
    """Raised when the sample DB build cannot complete safely."""


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Build a lightweight development sample DB safely.",
    )
    parser.add_argument(
        "--source-db",
        default=str(DEFAULT_SOURCE_DB),
        help="Read-only source SQLite DB path.",
    )
    parser.add_argument(
        "--output-db",
        default=str(DEFAULT_OUTPUT_DB),
        help="Published sample DB path.",
    )
    parser.add_argument(
        "--staging-dir",
        default=str(DEFAULT_STAGING_DIR),
        help="Directory used for temporary build artifacts.",
    )
    parser.add_argument(
        "--schema-source-checkout",
        default=str(DEFAULT_SCHEMA_SOURCE_CHECKOUT),
        help="Read-only product checkout path used for storage.init_db.",
    )
    parser.add_argument(
        "--response-cap",
        type=int,
        default=DEFAULT_RESPONSE_CAP,
        help="Maximum responses copied per article.",
    )
    parser.add_argument(
        "--overwrite",
        action="store_true",
        help="Allow replacing an existing output DB and manifest.",
    )
    parser.add_argument(
        "--distribute-to-children",
        action="store_true",
        help="Copy the published sample DB to both child repo runtime paths.",
    )
    parser.add_argument(
        "--copilot-db-path",
        default=str(ROOT_DIR / "copilot/runtime/data/nicodic.db"),
        help="Distribution target for the Copilot child repo DB.",
    )
    parser.add_argument(
        "--cursor-db-path",
        default=str(ROOT_DIR / "cursor/runtime/data/nicodic.db"),
        help="Distribution target for the Cursor child repo DB.",
    )
    parser.add_argument(
        "--self-check",
        action="store_true",
        help="Run a lightweight temporary self-check and exit.",
    )
    return parser.parse_args()


def load_storage_init_db(schema_source_checkout: Path):
    storage_path = schema_source_checkout / "storage.py"
    if not storage_path.is_file():
        raise BuildError(f"storage.py not found: {storage_path}")

    spec = importlib.util.spec_from_file_location(
        "dev_sample_storage",
        storage_path,
    )
    if spec is None or spec.loader is None:
        raise BuildError(f"could not load storage module: {storage_path}")

    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)

    init_db = getattr(module, "init_db", None)
    if init_db is None:
        raise BuildError(f"init_db not found in: {storage_path}")
    return init_db


def ensure_safe_paths(
    source_db: Path,
    output_db: Path,
    staging_dir: Path,
    *,
    overwrite: bool,
) -> Path:
    if not source_db.is_file():
        raise BuildError(f"source DB not found: {source_db}")
    if source_db.resolve() == output_db.resolve():
        raise BuildError("source DB and output DB must differ")

    staging_dir.mkdir(parents=True, exist_ok=True)
    output_db.parent.mkdir(parents=True, exist_ok=True)
    manifest_path = output_db.with_name("dev_sample_manifest.json")

    if output_db.exists() and not overwrite:
        raise BuildError(f"output DB exists, use --overwrite: {output_db}")
    if manifest_path.exists() and not overwrite:
        raise BuildError(
            f"manifest exists, use --overwrite: {manifest_path}"
        )
    return manifest_path


def column_names(conn: sqlite3.Connection, table_name: str) -> list[str]:
    rows = conn.execute(f"PRAGMA table_info({table_name})").fetchall()
    return [row[1] for row in rows]


def common_insert_columns(
    src_conn: sqlite3.Connection,
    dst_conn: sqlite3.Connection,
    table_name: str,
    *,
    exclude: set[str] | None = None,
) -> list[str]:
    exclude = exclude or set()
    src_columns = column_names(src_conn, table_name)
    dst_columns = set(column_names(dst_conn, table_name))
    return [
        name for name in src_columns if name in dst_columns and name not in exclude
    ]


def fetch_single_row(
    conn: sqlite3.Connection,
    table_name: str,
    columns: list[str],
    article_id: str,
    article_type: str,
) -> tuple | None:
    if not columns:
        return None
    sql = (
        f"SELECT {', '.join(columns)} FROM {table_name} "
        "WHERE article_id = ? AND article_type = ?"
    )
    return conn.execute(sql, (article_id, article_type)).fetchone()


def insert_row(
    conn: sqlite3.Connection,
    table_name: str,
    columns: list[str],
    row: tuple,
) -> None:
    placeholders = ", ".join("?" for _ in columns)
    sql = (
        f"INSERT INTO {table_name} ({', '.join(columns)}) "
        f"VALUES ({placeholders})"
    )
    conn.execute(sql, row)


def fetch_response_rows(
    conn: sqlite3.Connection,
    columns: list[str],
    article_id: str,
    article_type: str,
    response_cap: int,
) -> list[tuple]:
    if not columns:
        return []
    sql = (
        f"SELECT {', '.join(columns)} FROM responses "
        "WHERE article_id = ? AND article_type = ? "
        "ORDER BY res_no ASC LIMIT ?"
    )
    return conn.execute(sql, (article_id, article_type, response_cap)).fetchall()


def create_destination_db(
    output_db: Path,
    schema_source_checkout: Path,
) -> sqlite3.Connection:
    init_db = load_storage_init_db(schema_source_checkout)
    conn = init_db(str(output_db))
    conn.close()
    return sqlite3.connect(output_db)


def copy_selected_articles(
    src_conn: sqlite3.Connection,
    dst_conn: sqlite3.Connection,
    *,
    response_cap: int,
    required_article_ids: list[str],
    optional_article_ids: list[str],
) -> dict:
    article_columns = common_insert_columns(
        src_conn,
        dst_conn,
        "articles",
        exclude={"id"},
    )
    response_columns = common_insert_columns(
        src_conn,
        dst_conn,
        "responses",
        exclude={"id"},
    )
    target_columns = common_insert_columns(
        src_conn,
        dst_conn,
        "target",
        exclude={"id"},
    )

    copied_counts: dict[str, int] = {}
    copied_titles: dict[str, str] = {}
    missing_required: list[str] = []
    optional_status: dict[str, str] = {}

    for article_id in required_article_ids:
        article_row = fetch_single_row(
            src_conn,
            "articles",
            article_columns,
            article_id,
            ARTICLE_TYPE,
        )
        if article_row is None:
            missing_required.append(article_id)
            continue

        insert_row(dst_conn, "articles", article_columns, article_row)
        title_index = article_columns.index("title")
        copied_titles[article_id] = str(article_row[title_index])

        target_row = fetch_single_row(
            src_conn,
            "target",
            target_columns,
            article_id,
            ARTICLE_TYPE,
        )
        if target_row is not None:
            insert_row(dst_conn, "target", target_columns, target_row)

        response_rows = fetch_response_rows(
            src_conn,
            response_columns,
            article_id,
            ARTICLE_TYPE,
            response_cap,
        )
        for row in response_rows:
            insert_row(dst_conn, "responses", response_columns, row)
        copied_counts[article_id] = len(response_rows)

    for article_id in optional_article_ids:
        article_row = fetch_single_row(
            src_conn,
            "articles",
            article_columns,
            article_id,
            ARTICLE_TYPE,
        )
        if article_row is None:
            optional_status[article_id] = "missing_in_source"
            continue

        insert_row(dst_conn, "articles", article_columns, article_row)
        title_index = article_columns.index("title")
        copied_titles[article_id] = str(article_row[title_index])

        target_row = fetch_single_row(
            src_conn,
            "target",
            target_columns,
            article_id,
            ARTICLE_TYPE,
        )
        if target_row is not None:
            insert_row(dst_conn, "target", target_columns, target_row)

        response_rows = fetch_response_rows(
            src_conn,
            response_columns,
            article_id,
            ARTICLE_TYPE,
            response_cap,
        )
        for row in response_rows:
            insert_row(dst_conn, "responses", response_columns, row)
        copied_counts[article_id] = len(response_rows)
        optional_status[article_id] = "copied"

    if missing_required:
        raise BuildError(
            "required articles missing from source DB: "
            + ", ".join(sorted(missing_required))
        )

    dst_conn.commit()
    return {
        "copied_counts": copied_counts,
        "copied_titles": copied_titles,
        "optional_status": optional_status,
    }


def validate_destination(
    dst_conn: sqlite3.Connection,
    *,
    response_cap: int,
    required_article_ids: list[str],
    optional_article_ids: list[str],
) -> dict:
    required_count = dst_conn.execute(
        "SELECT COUNT(*) FROM articles WHERE article_type = ? "
        f"AND article_id IN ({', '.join('?' for _ in required_article_ids)})",
        [ARTICLE_TYPE, *required_article_ids],
    ).fetchone()[0]

    excluded_response_count = dst_conn.execute(
        "SELECT COUNT(*) FROM responses WHERE article_id = ? AND article_type = ?",
        (HARD_EXCLUDED_ARTICLE_ID, ARTICLE_TYPE),
    ).fetchone()[0]

    capped_rows = dst_conn.execute(
        "SELECT article_id, COUNT(*) FROM responses WHERE article_type = ? "
        "GROUP BY article_id HAVING COUNT(*) > ?",
        (ARTICLE_TYPE, response_cap),
    ).fetchall()

    optional_present = dst_conn.execute(
        "SELECT article_id FROM articles WHERE article_type = ? "
        f"AND article_id IN ({', '.join('?' for _ in optional_article_ids)})",
        [ARTICLE_TYPE, *optional_article_ids],
    ).fetchall()

    validation = {
        "required_article_count_ok": required_count == len(required_article_ids),
        "response_cap_ok": not capped_rows,
        "excluded_article_responses_ok": excluded_response_count == 0,
        "required_article_count": required_count,
        "optional_articles_present": [row[0] for row in optional_present],
        "capped_row_violations": [
            {"article_id": row[0], "response_count": row[1]}
            for row in capped_rows
        ],
        "excluded_article_response_count": excluded_response_count,
    }

    if not (
        validation["required_article_count_ok"]
        and validation["response_cap_ok"]
        and validation["excluded_article_responses_ok"]
    ):
        raise BuildError(f"validation failed: {json.dumps(validation)}")

    return validation


def build_manifest(
    *,
    source_db: Path,
    output_db: Path,
    schema_source_checkout: Path,
    response_cap: int,
    required_article_ids: list[str],
    optional_article_ids: list[str],
    copy_result: dict,
    validation_summary: dict,
    distributed_to_children: bool,
) -> dict:
    return {
        "source_db_path": str(source_db),
        "generated_at": datetime.now(timezone.utc).isoformat(),
        "output_db_path": str(output_db),
        "schema_source_checkout": str(schema_source_checkout),
        "article_type": ARTICLE_TYPE,
        "required_article_ids": required_article_ids,
        "optional_article_ids": optional_article_ids,
        "optional_article_handling_result": copy_result["optional_status"],
        "response_cap": response_cap,
        "response_selection_policy": "lowest res_no first, ascending",
        "per_article_copied_response_counts": copy_result["copied_counts"],
        "per_article_titles": copy_result["copied_titles"],
        "validation_summary": validation_summary,
        "excluded_article_check": {
            "article_id": HARD_EXCLUDED_ARTICLE_ID,
            "article_type": ARTICLE_TYPE,
            "responses_present": False,
        },
        "distributed_to_children": distributed_to_children,
    }


def write_json(path: Path, payload: dict) -> None:
    path.write_text(json.dumps(payload, indent=2, sort_keys=True) + "\n")


def publish_file(temp_path: Path, final_path: Path, *, overwrite: bool) -> None:
    if final_path.exists() and not overwrite:
        raise BuildError(f"refusing to overwrite existing file: {final_path}")
    final_path.parent.mkdir(parents=True, exist_ok=True)
    temp_path.replace(final_path)


def distribute_to_children(
    output_db: Path,
    *,
    copilot_db_path: Path,
    cursor_db_path: Path,
    overwrite: bool,
) -> list[str]:
    distributed_paths: list[str] = []
    for target in (copilot_db_path, cursor_db_path):
        if target.exists() and not overwrite:
            raise BuildError(
                f"distribution target exists, use --overwrite: {target}"
            )
        target.parent.mkdir(parents=True, exist_ok=True)
        shutil.copy2(output_db, target)
        distributed_paths.append(str(target))
    return distributed_paths


def run_build(
    *,
    source_db: Path,
    output_db: Path,
    staging_dir: Path,
    schema_source_checkout: Path,
    response_cap: int,
    overwrite: bool,
    distribute_children: bool,
    copilot_db_path: Path,
    cursor_db_path: Path,
    required_article_ids: list[str] | None = None,
    optional_article_ids: list[str] | None = None,
) -> BuildResult:
    required_article_ids = required_article_ids or REQUIRED_ARTICLE_IDS
    optional_article_ids = optional_article_ids or OPTIONAL_ARTICLE_IDS

    if response_cap <= 0:
        raise BuildError("response cap must be greater than zero")

    manifest_path = ensure_safe_paths(
        source_db,
        output_db,
        staging_dir,
        overwrite=overwrite,
    )

    with tempfile.TemporaryDirectory(dir=staging_dir) as temp_dir_name:
        temp_dir = Path(temp_dir_name)
        temp_db = temp_dir / "nicodic.db"
        temp_manifest = temp_dir / "dev_sample_manifest.json"

        src_conn = sqlite3.connect(source_db)
        dst_conn = create_destination_db(temp_db, schema_source_checkout)

        try:
            copy_result = copy_selected_articles(
                src_conn,
                dst_conn,
                response_cap=response_cap,
                required_article_ids=required_article_ids,
                optional_article_ids=optional_article_ids,
            )
            validation_summary = validate_destination(
                dst_conn,
                response_cap=response_cap,
                required_article_ids=required_article_ids,
                optional_article_ids=optional_article_ids,
            )
        finally:
            src_conn.close()
            dst_conn.close()

        manifest = build_manifest(
            source_db=source_db,
            output_db=output_db,
            schema_source_checkout=schema_source_checkout,
            response_cap=response_cap,
            required_article_ids=required_article_ids,
            optional_article_ids=optional_article_ids,
            copy_result=copy_result,
            validation_summary=validation_summary,
            distributed_to_children=distribute_children,
        )

        write_json(temp_manifest, manifest)
        publish_file(temp_db, output_db, overwrite=overwrite)
        publish_file(temp_manifest, manifest_path, overwrite=overwrite)

        if distribute_children:
            distributed_child_paths = distribute_to_children(
                output_db,
                copilot_db_path=copilot_db_path,
                cursor_db_path=cursor_db_path,
                overwrite=overwrite,
            )
            manifest["distributed_child_paths"] = distributed_child_paths
            write_json(manifest_path, manifest)

    return BuildResult(output_db=output_db, manifest_path=manifest_path, manifest=manifest)


def create_self_check_source_db(
    source_db: Path,
    schema_source_checkout: Path,
) -> None:
    conn = create_destination_db(source_db, schema_source_checkout)
    conn.execute(
        "INSERT INTO articles "
        "(article_id, article_type, title, canonical_url) VALUES (?, ?, ?, ?)",
        ("1001", ARTICLE_TYPE, "Required One", "https://example/a/1001"),
    )
    conn.execute(
        "INSERT INTO articles "
        "(article_id, article_type, title, canonical_url) VALUES (?, ?, ?, ?)",
        ("1002", ARTICLE_TYPE, "Required Two", "https://example/a/1002"),
    )
    conn.execute(
        "INSERT INTO articles "
        "(article_id, article_type, title, canonical_url) VALUES (?, ?, ?, ?)",
        ("1003", ARTICLE_TYPE, "Optional", "https://example/a/1003"),
    )
    conn.execute(
        "INSERT INTO articles "
        "(article_id, article_type, title, canonical_url) VALUES (?, ?, ?, ?)",
        (
            HARD_EXCLUDED_ARTICLE_ID,
            ARTICLE_TYPE,
            "Excluded",
            "https://example/a/excluded",
        ),
    )

    for article_id in ("1001", "1002", "1003"):
        conn.execute(
            "INSERT INTO target "
            "(article_id, article_type, canonical_url, title) VALUES (?, ?, ?, ?)",
            (
                article_id,
                ARTICLE_TYPE,
                f"https://example/a/{article_id}",
                f"Target {article_id}",
            ),
        )

    for res_no in range(1, 6):
        conn.execute(
            "INSERT INTO responses "
            "(article_id, article_type, res_no, content_text, content_html) "
            "VALUES (?, ?, ?, ?, ?)",
            ("1001", ARTICLE_TYPE, res_no, f"r{res_no}", f"<p>r{res_no}</p>"),
        )
    for res_no in range(1, 4):
        conn.execute(
            "INSERT INTO responses "
            "(article_id, article_type, res_no, content_text, content_html) "
            "VALUES (?, ?, ?, ?, ?)",
            ("1002", ARTICLE_TYPE, res_no, f"s{res_no}", f"<p>s{res_no}</p>"),
        )
    conn.execute(
        "INSERT INTO responses "
        "(article_id, article_type, res_no, content_text, content_html) "
        "VALUES (?, ?, ?, ?, ?)",
        (
            HARD_EXCLUDED_ARTICLE_ID,
            ARTICLE_TYPE,
            1,
            "excluded",
            "<p>excluded</p>",
        ),
    )
    conn.commit()
    conn.close()


def run_self_check(schema_source_checkout: Path) -> int:
    with tempfile.TemporaryDirectory() as temp_dir_name:
        temp_dir = Path(temp_dir_name)
        source_db = temp_dir / "source.db"
        output_db = temp_dir / "sample.db"
        staging_dir = temp_dir / "staging"

        create_self_check_source_db(source_db, schema_source_checkout)
        result = run_build(
            source_db=source_db,
            output_db=output_db,
            staging_dir=staging_dir,
            schema_source_checkout=schema_source_checkout,
            response_cap=2,
            overwrite=False,
            distribute_children=False,
            copilot_db_path=temp_dir / "copilot/runtime/data/nicodic.db",
            cursor_db_path=temp_dir / "cursor/runtime/data/nicodic.db",
            required_article_ids=["1001", "1002"],
            optional_article_ids=["1003"],
        )

        manifest = json.loads(result.manifest_path.read_text(encoding="utf-8"))
        assert result.output_db.is_file()
        assert manifest["response_cap"] == 2
        assert manifest["per_article_copied_response_counts"]["1001"] == 2
        assert manifest["optional_article_handling_result"]["1003"] == "copied"
        assert not manifest["excluded_article_check"]["responses_present"]

    print("self_check_ok")
    return 0


def main() -> int:
    args = parse_args()

    source_db = Path(args.source_db)
    output_db = Path(args.output_db)
    staging_dir = Path(args.staging_dir)
    schema_source_checkout = Path(args.schema_source_checkout)
    copilot_db_path = Path(args.copilot_db_path)
    cursor_db_path = Path(args.cursor_db_path)

    try:
        if args.self_check:
            return run_self_check(schema_source_checkout)

        result = run_build(
            source_db=source_db,
            output_db=output_db,
            staging_dir=staging_dir,
            schema_source_checkout=schema_source_checkout,
            response_cap=args.response_cap,
            overwrite=args.overwrite,
            distribute_children=args.distribute_to_children,
            copilot_db_path=copilot_db_path,
            cursor_db_path=cursor_db_path,
        )
    except (AssertionError, BuildError, OSError, sqlite3.Error) as exc:
        print(f"error: {exc}")
        return 1

    print(f"sample_db={result.output_db}")
    print(f"manifest={result.manifest_path}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())