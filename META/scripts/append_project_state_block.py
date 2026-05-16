#!/usr/bin/env python3
"""Safely append a headed Markdown block to PROJECT_STATE.md.

This helper is intentionally small and root-meta specific.

Usage example:

  python3 META/scripts/append_project_state_block.py --heading "Example" <<'EOF'
  Body text.
  EOF

If the target file already contains the normalized heading, the helper exits
successfully without modifying the file.
"""

from __future__ import annotations

import argparse
import sys
from pathlib import Path


DEFAULT_TARGET = Path("PROJECT_STATE.md")


def normalize_heading(raw_heading: str) -> str:
    heading = raw_heading.strip()
    if not heading:
        raise ValueError("heading must not be empty")
    if heading.startswith("#"):
        return heading
    return f"## {heading}"


def read_stdin_block() -> str:
    block = sys.stdin.read().strip()
    if not block:
        raise ValueError("stdin block must not be empty")
    return block


def build_block(marker_heading: str, block: str) -> str:
    if marker_heading not in block:
        return f"{marker_heading}\n\n{block.strip()}\n"
    return block.strip() + "\n"


def append_block(
    target_path: Path,
    marker_heading: str,
    block: str,
    *,
    allow_duplicate: bool,
    dry_run: bool,
) -> str:
    text = target_path.read_text(encoding="utf-8")

    if not allow_duplicate and marker_heading in text:
        return "already_present"

    append_text = build_block(marker_heading, block)
    new_text = text.rstrip() + "\n\n" + append_text

    if dry_run:
        return "would_append"

    target_path.write_text(new_text, encoding="utf-8")
    return "appended"


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Safely append a headed block to PROJECT_STATE.md.",
    )
    parser.add_argument(
        "--heading",
        required=True,
        help="Heading used as the duplicate-detection marker.",
    )
    parser.add_argument(
        "--target",
        default=str(DEFAULT_TARGET),
        help="Target Markdown file. Defaults to PROJECT_STATE.md.",
    )
    parser.add_argument(
        "--allow-duplicate",
        action="store_true",
        help="Append even when the heading already exists.",
    )
    parser.add_argument(
        "--dry-run",
        action="store_true",
        help="Report what would happen without writing.",
    )
    return parser.parse_args()


def main() -> int:
    args = parse_args()

    try:
        marker_heading = normalize_heading(args.heading)
        block = read_stdin_block()
        result = append_block(
            Path(args.target),
            marker_heading,
            block,
            allow_duplicate=args.allow_duplicate,
            dry_run=args.dry_run,
        )
    except OSError as exc:
        print(f"error: {exc}", file=sys.stderr)
        return 1
    except ValueError as exc:
        print(f"error: {exc}", file=sys.stderr)
        return 2

    print(result)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())

