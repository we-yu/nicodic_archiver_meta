#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 1 ]]; then
  echo "usage: ./runtime_exec.sh '<command>'" >&2
  exit 1
fi

RUNTIME_DIR="${RUNTIME_DIR:-/home/manage/product/nicodic_archiver_runtime}"
COMPOSE_FILE="${COMPOSE_FILE:-docker-compose.runtime.yml}"
SERVICE_NAME="${SERVICE_NAME:-personal_runtime}"
CMD_STR="$1"

cd "${RUNTIME_DIR}"
docker compose --env-file ./.env.runtime.local -f "./${COMPOSE_FILE}" exec -T "${SERVICE_NAME}" sh -lc "${CMD_STR}"

