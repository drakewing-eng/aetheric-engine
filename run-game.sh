#!/bin/zsh
# One command to run the Aetheric Engine Godot slice + NPC bridge.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
BRIDGE="$ROOT/server"
GODOT_PROJ="$ROOT/aetheric-engine-godot"

export ENGRAM_BINARY="${ENGRAM_BINARY:-/Users/babble/engram-current/target/release/engram}"
export ENGRAM_STORE="${ENGRAM_STORE:-$HOME/.engram/stalks/}"
export OLLAMA_URL="${OLLAMA_URL:-http://localhost:11434}"
export OLLAMA_MODEL="${OLLAMA_MODEL:-gemma3:4b}"

echo "=== Aetheric Engine launcher ==="
echo "Engram: $ENGRAM_BINARY"
echo "Ollama: $OLLAMA_URL ($OLLAMA_MODEL)"
echo ""

# Bridge in background (always restart so latency/lore code is current)
if curl -sf "http://127.0.0.1:3001/health" >/dev/null 2>&1; then
  echo "Stopping old bridge on :3001 so new code loads …"
  lsof -ti :3001 | xargs kill 2>/dev/null || true
  sleep 1
fi
echo "Starting NPC bridge on :3001 …"
# Latency defaults: slim prompts + short answers (override with env if needed)
export OLLAMA_NUM_PREDICT="${OLLAMA_NUM_PREDICT:-60}"
export OLLAMA_KEEP_ALIVE="${OLLAMA_KEEP_ALIVE:-60m}"
export SLIM_PROMPT="${SLIM_PROMPT:-1}"
# Prefer shared Engram if serve is up
if curl -sf "http://127.0.0.1:3456/health" >/dev/null 2>&1; then
  export ENGRAM_MCP_URL="${ENGRAM_MCP_URL:-http://127.0.0.1:3456/mcp}"
fi
(cd "$BRIDGE" && node index.js) &
BRIDGE_PID=$!
sleep 3

cleanup() {
  if [[ -n "${BRIDGE_PID:-}" ]]; then
    kill "$BRIDGE_PID" 2>/dev/null || true
  fi
}
trap cleanup EXIT

# Find Godot
GODOT=""
for candidate in \
  "/Applications/Godot.app/Contents/MacOS/Godot" \
  "$(command -v godot 2>/dev/null || true)" \
  "$(command -v godot4 2>/dev/null || true)"; do
  if [[ -n "$candidate" && -x "$candidate" ]]; then
    GODOT="$candidate"
    break
  fi
done

if [[ -z "$GODOT" ]]; then
  echo ""
  echo "Godot is not installed yet."
  echo "Install once with:  brew install --cask godot"
  echo "Then run this script again."
  echo ""
  echo "Bridge is up — you can test dialogue with curl:"
  echo '  curl -s http://127.0.0.1:3001/chat -H "Content-Type: application/json" -d '"'"'{"speaker":"bell","message":"What is the experiment for?","history":[]}'"'"' | jq .'
  wait ${BRIDGE_PID:-} 2>/dev/null || true
  exit 1
fi

echo "Launching Godot project …"
exec "$GODOT" --path "$GODOT_PROJ" res://scenes/fps_main.tscn