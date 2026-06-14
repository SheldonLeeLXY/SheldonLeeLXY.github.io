#!/usr/bin/env bash
set -euo pipefail

die() {
  echo "[ERROR] $*" >&2
  exit 1
}

has_cmd() {
  command -v "$1" >/dev/null 2>&1
}

port_is_busy() {
  if has_cmd ss; then
    ss -ltn "sport = :${PORT}" 2>/dev/null | awk 'NR > 1 { found = 1 } END { exit found ? 0 : 1 }'
    return
  fi

  if has_cmd lsof; then
    lsof -nP -iTCP:"${PORT}" -sTCP:LISTEN >/dev/null 2>&1
    return
  fi

  return 1
}

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
REPO_ROOT="$(cd -- "${SCRIPT_DIR}/.." >/dev/null 2>&1 && pwd)"

CONDA_ENV="${CONDA_ENV:-academicpages-ruby}"
HOST="${HOST:-127.0.0.1}"
PORT="${PORT:-4000}"
JEKYLL_ENV="${JEKYLL_ENV:-development}"
export JEKYLL_ENV

[[ "${PORT}" =~ ^[0-9]+$ ]] || die "PORT must be a number, got '${PORT}'"

has_cmd conda || die "conda is not available on PATH"

if ! conda info --envs | awk '{ print $1 }' | grep -Fxq "${CONDA_ENV}"; then
  die "conda environment '${CONDA_ENV}' was not found"
fi

cd "${REPO_ROOT}"

echo "[INFO] repository: ${REPO_ROOT}"
echo "[INFO] conda env: ${CONDA_ENV}"
echo "[INFO] jekyll env: ${JEKYLL_ENV}"
echo "[INFO] address: http://${HOST}:${PORT}/"

if port_is_busy; then
  die "port ${PORT} is already in use; stop that service or run with PORT=<another-port>"
fi

echo "[INFO] checking Ruby gems"
conda run --no-capture-output -n "${CONDA_ENV}" bundle check

echo "[INFO] starting Jekyll; press Ctrl-C to stop"
exec conda run --no-capture-output -n "${CONDA_ENV}" \
  bundle exec jekyll serve -l -H "${HOST}" --port "${PORT}" --config _config.yml,_config_docker.yml
