#!/usr/bin/env bash
# Copy playground Mixamo downloads into the Godot mixamo source folder and bake clips.
set -euo pipefail
PIPE="$(cd "$(dirname "$0")" && pwd)"
GODOT_PROJ="$(cd "$PIPE/../../../../.." && pwd)"
if [ ! -f "$GODOT_PROJ/project.godot" ]; then
  GODOT_PROJ="$(cd "$PIPE/../../../../../.." && pwd)"
fi
MIX_DST="$GODOT_PROJ/assets/characters/mixamo/source"
# Playground default (sibling of aetheric-engine under antigravity/playground)
PLAY_ROOT="$(cd "$GODOT_PROJ/../.." && pwd)"
MIX_SRC_CANDIDATES=(
  "$PLAY_ROOT/Mixamo downloads"
  "$PLAY_ROOT/../Mixamo downloads"
  "/Users/babble/ gemini/antigravity/playground/Mixamo downloads"
  "$HOME/Downloads"
)

MIX_SRC=""
for c in "${MIX_SRC_CANDIDATES[@]}"; do
  if [ -d "$c" ] && ls "$c"/*.[Ff][Bb][Xx] >/dev/null 2>&1; then
    MIX_SRC="$c"
    break
  fi
done

echo "GODOT_PROJ=$GODOT_PROJ"
echo "MIX_SRC=${MIX_SRC:-MISSING}"
mkdir -p "$MIX_DST"

if [ -z "$MIX_SRC" ]; then
  echo "ERROR: no Mixamo downloads folder with .fbx files found"
  exit 1
fi

copy_if() {
  local src_name="$1"
  local dst_name="$2"
  if [ -f "$MIX_SRC/$src_name" ]; then
    cp -f "$MIX_SRC/$src_name" "$MIX_DST/$dst_name"
    echo "OK $src_name → $dst_name"
  else
    echo "NOTE missing $src_name"
  fi
}

copy_if "Start Walking.fbx" "start_walking.fbx"
copy_if "Idle.fbx" "idle.fbx"
copy_if "Standing Idle.fbx" "standing_idle.fbx"
copy_if "Sitting Idle.fbx" "sitting_idle.fbx"
copy_if "Sitting Idle (1).fbx" "sitting_idle_alt.fbx"

ls -la "$MIX_DST"

GODOT_BIN=""
for c in \
  "/Applications/Godot.app/Contents/MacOS/Godot" \
  "$(command -v godot || true)" \
  "$(command -v godot4 || true)"; do
  if [ -n "$c" ] && [ -x "$c" ]; then
    GODOT_BIN="$c"
    break
  fi
done

if [ -z "$GODOT_BIN" ]; then
  echo "NOTE: Godot not found — sources copied; run bake later"
  exit 0
fi

echo "=== import FBX ==="
"$GODOT_BIN" --headless --path "$GODOT_PROJ" --import 2>&1 | tail -20 || true

echo "=== bake mixamo clips ==="
"$GODOT_BIN" --headless --path "$GODOT_PROJ" --script res://scripts/bake_mixamo_clips.gd 2>&1 | tee "$PIPE/work/mixamo_bake.log" | grep -E '^(OK|FAIL|NOTE|===)' || true

echo "=== verify skeletal ==="
"$GODOT_BIN" --headless --path "$GODOT_PROJ" --script res://scripts/test_npc_skeletal.gd 2>&1 | tee "$PIPE/work/headless.log" | grep -E '^(OK|FAIL|NOTE|===)' || true

echo "=== sync_mixamo COMPLETE ==="
ls -la "$GODOT_PROJ/assets/characters/mixamo/" || true
