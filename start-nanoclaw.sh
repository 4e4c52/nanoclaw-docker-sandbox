#!/bin/bash
# start-nanoclaw.sh — Start NanoClaw without systemd
# To stop: kill \$(cat /Users/nathan/nanoclaw-sandbox-1191/nanoclaw.pid)

set -euo pipefail

cd "/Users/nathan/nanoclaw-sandbox-1191"

# Stop existing instance if running
if [ -f "/Users/nathan/nanoclaw-sandbox-1191/nanoclaw.pid" ]; then
  OLD_PID=$(cat "/Users/nathan/nanoclaw-sandbox-1191/nanoclaw.pid" 2>/dev/null || echo "")
  if [ -n "$OLD_PID" ] && kill -0 "$OLD_PID" 2>/dev/null; then
    echo "Stopping existing NanoClaw (PID $OLD_PID)..."
    kill "$OLD_PID" 2>/dev/null || true
    sleep 2
  fi
fi

echo "Starting NanoClaw..."
nohup "/usr/bin/node" "/Users/nathan/nanoclaw-sandbox-1191/dist/index.js" \
  >> "/Users/nathan/nanoclaw-sandbox-1191/logs/nanoclaw.log" \
  2>> "/Users/nathan/nanoclaw-sandbox-1191/logs/nanoclaw.error.log" &

echo $! > "/Users/nathan/nanoclaw-sandbox-1191/nanoclaw.pid"
echo "NanoClaw started (PID $!)"
echo "Logs: tail -f /Users/nathan/nanoclaw-sandbox-1191/logs/nanoclaw.log"
