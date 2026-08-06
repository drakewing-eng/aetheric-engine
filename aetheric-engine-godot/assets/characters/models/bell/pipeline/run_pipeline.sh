#!/usr/bin/env bash
# Bell reference → final/bell.glb
set -euo pipefail
PIPE="$(cd "$(dirname "$0")" && pwd)"
GODOT="$(cd "$PIPE/../../../../.." && pwd)"
# If path wrong (pipeline is under assets/...), fix:
# PIPE = .../bell/pipeline → project root is 5 levels up: pipeline, bell, models, characters, assets, PROJECT
GODOT="$(cd "$PIPE/../../../../.." && pwd)"
# verify
if [ ! -f "$GODOT/project.godot" ]; then
  GODOT="$(cd "$PIPE/../../../../../.." && pwd)"
fi
if [ ! -f "$GODOT/project.godot" ]; then
  # pipeline is at assets/characters/models/bell/pipeline → 5 ups = project
  GODOT="$(cd "$PIPE" && cd ../../../../.. && pwd)"
fi
echo "GODOT=$GODOT"
echo "PIPE=$PIPE"

export BELL_PIPE_WORK="$PIPE/work"
mkdir -p "$BELL_PIPE_WORK"

# Blender
if [ -z "${BELL_BLENDER:-}" ]; then
  for c in \
    "/var/folders/6f/lh4fvcl14g7bs34x6nh9dxdm0000gn/T/grok-goal-ed336d5b6aa6/implementer/Blender.app/Contents/MacOS/Blender" \
    "/Applications/Blender.app/Contents/MacOS/Blender" \
    "$(command -v blender || true)"; do
    if [ -n "$c" ] && [ -x "$c" ]; then
      BELL_BLENDER="$c"
      break
    fi
  done
fi
echo "BELL_BLENDER=${BELL_BLENDER:-MISSING}"

cd "$PIPE"
python3 01_prepare_sheet.py
python3 02_image_to_mesh.py

if [ -z "${BELL_BLENDER:-}" ]; then
  echo "ERROR: Blender required for 03_postprocess"
  exit 1
fi
export BELL_PIPE_WORK
"$BELL_BLENDER" --background --python 03_postprocess_blender.py
python3 04_install.py

# Headless verify if Godot present
GODOT_BIN=""
for c in \
  "/Applications/Godot.app/Contents/MacOS/Godot" \
  "$(command -v godot || true)"; do
  if [ -n "$c" ] && [ -x "$c" ]; then
    GODOT_BIN="$c"
    break
  fi
done
if [ -n "$GODOT_BIN" ] && [ -f "$GODOT/project.godot" ]; then
  echo "=== headless test ==="
  "$GODOT_BIN" --headless --path "$GODOT" --script res://scripts/test_npc_skeletal.gd 2>&1 | tee "$BELL_PIPE_WORK/headless.log" | grep -E '^(OK|FAIL|===)' || true
else
  echo "skip headless (no Godot)"
fi
echo "=== PIPELINE COMPLETE ==="
ls -la "$PIPE/../final/bell.glb"
