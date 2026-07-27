# Autonomous visual improvement loop (7h / 10m)

**Scope:** Visual art only (rooms, props, materials, lighting, doors). Do not change lore/dialogue/bridge unless a visual path is broken.

**Preserve:** Furniture/props must never silently vanish. If fps_props fails to compile, fix immediately. Always git commit + push after each successful iteration.

## Each iteration
1. Capture: `Godot --path aetheric-engine-godot --resolution 1280x720 -s res://scripts/screenshot_tour.gd`
2. Copy shots to `SCRATCH/screenshots/auto_loop_N/`
3. Review key frames (drawing spawn, hall door, kitchen, conservatory, gallery)
4. Fix top 3–5 visual issues only
5. `test_room_art_pass.gd` must PASS
6. `./scripts/checkpoint.sh "visual loop N: short note"`

## Priority queue (user-reported)
1. Door openings: wall holes + portal tunnel (see through door)
2. Floating furniture: billboard ground align / sink
3. Plants face camera (FIXED_Y)
4. Horizon z-fight (chair rail — already done; don't regress)
5. Period density (Myst/Oblivion/1856)

## Do not
- Delete prop lists from fps_rooms
- Commit BACKUPS/*.tar.gz
- Break door E-triggers
