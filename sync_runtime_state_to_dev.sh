#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"
RUNTIME_DIR="${RUNTIME_DIR:-/home/manage/product/nicodic_archiver_runtime}"
COPILOT_DIR="${COPILOT_DIR:-${ROOT_DIR}/copilot}"
CURSOR_DIR="${CURSOR_DIR:-${ROOT_DIR}/cursor}"
RUNTIME_SERVICE="${RUNTIME_SERVICE:-nicodic_archiver_runtime-personal_runtime-1}"

RUNTIME_RUNTIME_DIR="${RUNTIME_DIR}/runtime"
RUNTIME_DATA_DIR="${RUNTIME_RUNTIME_DIR}/data"
RUNTIME_LOGS_DIR="${RUNTIME_RUNTIME_DIR}/logs"
RUNTIME_TARGETS_DIR="${RUNTIME_RUNTIME_DIR}/targets"

COPILOT_RUNTIME_DIR="${COPILOT_DIR}/runtime"
CURSOR_RUNTIME_DIR="${CURSOR_DIR}/runtime"

TMP_ROOT="${TMP_ROOT:-/tmp/nicodic_runtime_sync}"
TMP_DB_PATH="${TMP_ROOT}/nicodic.db"

DELETE_MODE="${DELETE_MODE:-0}"

echo "[sync-runtime-state] root=${ROOT_DIR}"
echo "[sync-runtime-state] runtime_dir=${RUNTIME_DIR}"
echo "[sync-runtime-state] copilot_dir=${COPILOT_DIR}"
echo "[sync-runtime-state] cursor_dir=${CURSOR_DIR}"
echo "[sync-runtime-state] runtime_service=${RUNTIME_SERVICE}"
echo "[sync-runtime-state] delete_mode=${DELETE_MODE}"

require_dir() {
  local path="$1"
  if [[ ! -d "${path}" ]]; then
    echo "[sync-runtime-state] ERROR: missing dir: ${path}" >&2
    exit 1
  fi
}

preflight_runtime_idle() {
  if [[ -d "${RUNTIME_RUNTIME_DIR}/logs/periodic_once.lock" ]]; then
    echo "[sync-runtime-state] ABORT: periodic_once lock exists" >&2
    exit 2
  fi

  if docker ps --format '{{.Names}}' | grep -qx "${RUNTIME_SERVICE}"; then
    local active_pids
    active_pids="$(
      docker top "${RUNTIME_SERVICE}" -eo pid,args 2>/dev/null | \
        grep -E 'python(3)? main.py (batch|periodic|periodic-once)' || true
    )"
    if [[ -n "${active_pids}" ]]; then
      echo "[sync-runtime-state] ABORT: scrape-like process is running" >&2
      echo "${active_pids}" >&2
      exit 3
    fi
  fi
}

prepare_dirs() {
  mkdir -p "${TMP_ROOT}"
  mkdir -p "${COPILOT_RUNTIME_DIR}/data"
  mkdir -p "${COPILOT_RUNTIME_DIR}/logs"
  mkdir -p "${COPILOT_RUNTIME_DIR}/targets"
  mkdir -p "${CURSOR_RUNTIME_DIR}/data"
  mkdir -p "${CURSOR_RUNTIME_DIR}/logs"
  mkdir -p "${CURSOR_RUNTIME_DIR}/targets"
}

snapshot_runtime_db() {
  local src_db="${RUNTIME_DATA_DIR}/nicodic.db"

  if [[ ! -f "${src_db}" ]]; then
    echo "[sync-runtime-state] ERROR: runtime DB not found: ${src_db}" >&2
    exit 4
  fi

  rm -f "${TMP_DB_PATH}"

  python3 - "${src_db}" "${TMP_DB_PATH}" <<'PY'
import sqlite3
import sys

src = sys.argv[1]
dst = sys.argv[2]

src_conn = sqlite3.connect(src)
try:
    dst_conn = sqlite3.connect(dst)
    try:
        src_conn.backup(dst_conn)
    finally:
        dst_conn.close()
finally:
    src_conn.close()
PY

  if [[ ! -f "${TMP_DB_PATH}" ]]; then
    echo "[sync-runtime-state] ERROR: snapshot DB was not created" >&2
    exit 5
  fi

  echo "[sync-runtime-state] snapshot_db=${TMP_DB_PATH}"
}

build_rsync_args() {
  RSYNC_ARGS=(
    -a
    --human-readable
    --itemize-changes
  )

  if [[ "${DELETE_MODE}" == "1" ]]; then
    RSYNC_ARGS+=(--delete-delay)
  fi
}

sync_tree() {
  local src="$1"
  local dst="$2"

  echo "[sync-runtime-state] sync ${src} -> ${dst}"
  rsync "${RSYNC_ARGS[@]}" "${src}/" "${dst}/"
}

sync_all_non_db() {
  sync_tree "${RUNTIME_LOGS_DIR}" "${COPILOT_RUNTIME_DIR}/logs"
  sync_tree "${RUNTIME_TARGETS_DIR}" "${COPILOT_RUNTIME_DIR}/targets"
  sync_tree "${RUNTIME_DATA_DIR}" "${COPILOT_RUNTIME_DIR}/data"

  sync_tree "${RUNTIME_LOGS_DIR}" "${CURSOR_RUNTIME_DIR}/logs"
  sync_tree "${RUNTIME_TARGETS_DIR}" "${CURSOR_RUNTIME_DIR}/targets"
  sync_tree "${RUNTIME_DATA_DIR}" "${CURSOR_RUNTIME_DIR}/data"
}

install_snapshot_db() {
  install -m 0644 "${TMP_DB_PATH}" "${COPILOT_RUNTIME_DIR}/data/nicodic.db"
  install -m 0644 "${TMP_DB_PATH}" "${CURSOR_RUNTIME_DIR}/data/nicodic.db"
}

print_summary() {
  echo "[sync-runtime-state] done"
  echo "[sync-runtime-state] copied snapshot DB to:"
  echo "  - ${COPILOT_RUNTIME_DIR}/data/nicodic.db"
  echo "  - ${CURSOR_RUNTIME_DIR}/data/nicodic.db"
  echo "[sync-runtime-state] target dirs:"
  echo "  - ${COPILOT_RUNTIME_DIR}"
  echo "  - ${CURSOR_RUNTIME_DIR}"
  echo "[sync-runtime-state] DB size:"
  ls -lh "${TMP_DB_PATH}"
}

require_dir "${RUNTIME_DIR}"
require_dir "${COPILOT_DIR}"
require_dir "${CURSOR_DIR}"
require_dir "${RUNTIME_RUNTIME_DIR}"
require_dir "${RUNTIME_DATA_DIR}"
require_dir "${RUNTIME_LOGS_DIR}"
require_dir "${RUNTIME_TARGETS_DIR}"

preflight_runtime_idle
prepare_dirs
build_rsync_args
snapshot_runtime_db
sync_all_non_db
install_snapshot_db
print_summary
