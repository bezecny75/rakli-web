#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DIST_DIR="$ROOT/dist"
ENV_FILE="${RAKLI_DEPLOY_ENV:-$ROOT/.env}"
MODE="dry-run"
DELETE=""

usage() {
  cat <<'EOF'
Usage: scripts/deploy.sh [--dry-run] [--apply] [--delete]

Default is --dry-run. Credentials are loaded from .env or from RAKLI_DEPLOY_ENV.

Required variables:
  FTP_HOST=example.com
  FTP_USER=username
  FTP_PASS=password
  FTP_REMOTE_DIR=/path/to/webroot
  FTP_PROTOCOL=ftp|ftps|sftp

Safety:
  - uploads only the Astro build output from dist/
  - never uploads source files, .agent, .git, node_modules, or secrets
  - does not delete remote files unless --delete is explicitly provided
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --dry-run) MODE="dry-run" ;;
    --apply) MODE="apply" ;;
    --delete) DELETE="--delete" ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown argument: $1" >&2; usage; exit 2 ;;
  esac
  shift
done

command -v lftp >/dev/null || { echo "Missing lftp. Install: sudo apt-get install lftp" >&2; exit 1; }
[[ -d "$DIST_DIR" ]] || { echo "Build output not found: $DIST_DIR. Run npm run build first." >&2; exit 1; }
[[ -f "$ENV_FILE" ]] || { echo "Deploy env file not found: $ENV_FILE" >&2; exit 1; }

set -a
# shellcheck disable=SC1090
source "$ENV_FILE"
set +a

: "${FTP_HOST:?missing FTP_HOST}"
: "${FTP_USER:?missing FTP_USER}"
: "${FTP_PASS:?missing FTP_PASS}"
: "${FTP_REMOTE_DIR:?missing FTP_REMOTE_DIR}"
: "${FTP_PROTOCOL:?missing FTP_PROTOCOL}"

case "$FTP_PROTOCOL" in
  ftp|ftps|sftp) ;;
  *) echo "FTP_PROTOCOL must be ftp, ftps, or sftp" >&2; exit 1 ;;
esac

TMP="$(mktemp)"
chmod 600 "$TMP"
cleanup() { rm -f "$TMP"; }
trap cleanup EXIT

DRY=""
[[ "$MODE" == "dry-run" ]] && DRY="--dry-run"

cat >"$TMP" <<EOF
set net:timeout 30
set net:max-retries 2
set cmd:fail-exit yes
set ftp:ssl-allow yes
open -u "$FTP_USER","$FTP_PASS" "$FTP_PROTOCOL://$FTP_HOST"
mkdir -p "$FTP_REMOTE_DIR"
cd "$FTP_REMOTE_DIR"
mirror --reverse --verbose $DRY $DELETE "$DIST_DIR" "$FTP_REMOTE_DIR"
bye
EOF

run_lftp_redacted() {
  local output rc
  set +e
  output="$(lftp -f "$TMP" 2>&1)"
  rc=$?
  set -e
  output="${output//$FTP_PASS/***REDACTED***}"
  printf '%s\n' "$output"
  return "$rc"
}

if [[ "$MODE" == "dry-run" ]]; then
  echo "DRY RUN only. Nothing will be uploaded."
else
  echo "APPLY mode. Uploading dist/ to $FTP_PROTOCOL://$FTP_HOST$FTP_REMOTE_DIR"
fi

run_lftp_redacted
