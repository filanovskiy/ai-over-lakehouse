#!/bin/zsh
# Start a fresh, local LiveLabs preview for one PeakGear lab.

set -euo pipefail

SCRIPT_DIR=${0:A:h}
LAB=${1:-connect-sources}
PORT=${2:-8000}

usage() {
  cat <<'EOF'
Usage: ./preview-livelabs.command [lab-id] [port]

Lab IDs:
  admin-setup
  connect-peakgear
  connect-sources
  connect-codex
  ai-enrichment
  governed-question
  analytic-views

Examples:
  ./preview-livelabs.command connect-sources
  ./preview-livelabs.command connect-codex 8001
EOF
}

case "$LAB" in
  admin-setup|connect-peakgear|connect-sources|connect-codex|ai-enrichment|governed-question|analytic-views)
    ;;
  -h|--help)
    usage
    exit 0
    ;;
  *)
    print -u2 -- "Unknown lab ID: $LAB"
    usage >&2
    exit 1
    ;;
esac

if [[ ! "$PORT" =~ '^[0-9]+$' ]] || (( PORT < 1 || PORT > 65535 )); then
  print -u2 -- "Port must be a number from 1 through 65535."
  exit 1
fi

if lsof -nP -iTCP:"$PORT" -sTCP:LISTEN >/dev/null 2>&1; then
  print -u2 -- "Port $PORT is already in use."
  print -u2 -- "Return to the Terminal that runs the preview server and press Control-C."
  print -u2 -- "This launcher will not stop an existing process."
  exit 1
fi

cd "$SCRIPT_DIR"

python3 -m http.server "$PORT" &
SERVER_PID=$!

cleanup() {
  if kill -0 "$SERVER_PID" >/dev/null 2>&1; then
    kill "$SERVER_PID" >/dev/null 2>&1 || true
    wait "$SERVER_PID" 2>/dev/null || true
  fi
}
trap cleanup EXIT INT TERM

for attempt in {1..20}; do
  if curl --silent --fail "http://127.0.0.1:$PORT/workshops/sandbox/index.html" >/dev/null; then
    break
  fi
  sleep 0.1
done

if ! kill -0 "$SERVER_PID" >/dev/null 2>&1; then
  print -u2 -- "The local preview server did not start."
  exit 1
fi

PREVIEW_ID="$(date +%s)-$RANDOM"
PREVIEW_URL="http://localhost:$PORT/workshops/sandbox/index.html?lab=$LAB&preview=$PREVIEW_ID"

print -- "Opening a fresh preview for $LAB."
print -- "Preview URL: $PREVIEW_URL"
print -- "The server log remains in this Terminal. Press Control-C to stop this server."
open "$PREVIEW_URL"
wait "$SERVER_PID"
