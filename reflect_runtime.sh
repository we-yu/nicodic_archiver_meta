#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"
RUNTIME_DIR="${RUNTIME_DIR:-/home/manage/product/nicodic_archiver_runtime}"
RUNTIME_SERVICE="${RUNTIME_SERVICE:-nicodic_archiver_runtime-personal_runtime-1}"

echo "[reflect-runtime] runtime_dir=${RUNTIME_DIR}"
echo "[reflect-runtime] runtime_service=${RUNTIME_SERVICE}"

if [[ ! -d "${RUNTIME_DIR}" ]]; then
  echo "[reflect-runtime] ERROR: runtime dir not found: ${RUNTIME_DIR}" >&2
  exit 1
fi

if [[ -d "${RUNTIME_DIR}/runtime/logs/periodic_once.lock" ]]; then
  echo "[reflect-runtime] ABORT: periodic_once lock exists" >&2
  exit 2
fi

if docker ps --format '{{.Names}}' | grep -qx "${RUNTIME_SERVICE}"; then
  ACTIVE_PIDS="$(docker exec "${RUNTIME_SERVICE}" sh -lc "ps -eo pid,args | grep -E 'python main.py (batch|periodic|periodic-once)' | grep -v grep || true")"
  if [[ -n "${ACTIVE_PIDS}" ]]; then
    echo "[reflect-runtime] ABORT: scrape-like process is running inside container" >&2
    echo "${ACTIVE_PIDS}" >&2
    exit 3
  fi
fi

cd "${RUNTIME_DIR}"
git pull --ff-only origin main
bash tools/runtime_up.sh
docker ps --format 'table {{.Names}}\t{{.Status}}\t{{.Ports}}' | grep "${RUNTIME_SERVICE}"

echo "[reflect-runtime] done"


