# Self-critique: square furniture + minimal detail (2026-07-24)

## What I saw wrong
1. **Square brown backgrounds** on furniture billboards
2. **Minimal blocky mesh detail** elsewhere

## Root cause
Hero PNGs were studio photos with **opaque brown backdrops** (corners alpha=255). Alpha-scissor billboards drew full brown rectangles.

## Fixes
- rembg U2Net cutouts + tight crop (corners α=0; 60–80% transparent)
- Billboards keep room yaw (not camera-facing FIXED_Y); dual-sided quads
- Filename content remap (desk.png=sofa image, etc.)
- Enriched mesh sofa/armchair/chair/desk/side_table
- Automated alpha-corner tests

## Verify
```
Godot --headless -s res://scripts/test_room_art_pass.gd  # PASS
```
Play: `/Users/babble/aetheric-engine/PLAY.sh`
Or: `/Users/babble/ gemini/antigravity/playground/aetheric-engine/PLAY.sh`
