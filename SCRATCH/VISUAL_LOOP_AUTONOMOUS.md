# Autonomous visual improvement loop (7h / 10m)

**Scope:** Visual art only (rooms, props, materials, lighting, doors). Do not change lore/dialogue/bridge unless a visual path is broken.

**Preserve:** Furniture/props must never silently vanish. If fps_props fails to compile, fix immediately. Always git commit + push after each successful iteration.

**Godot binary:** `/Applications/Godot.app/Contents/MacOS/Godot`

## Each iteration
1. Capture:
   ```
   /Applications/Godot.app/Contents/MacOS/Godot --path aetheric-engine-godot --resolution 1280x720 -s res://scripts/screenshot_tour.gd
   ```
2. Copy shots to `SCRATCH/screenshots/auto_loop_N/` (increment N; do not delete prior loops)
3. Review key frames (drawing spawn, hall door open, kitchen, conservatory, gallery)
4. Fix top 3–5 visual issues only (see priority queue)
5. `Godot --headless --path aetheric-engine-godot -s res://scripts/test_room_art_pass.gd` must PASS
6. `./scripts/checkpoint.sh "visual loop N: short note"` (pushes to private GitHub)

## Priority queue
1. Door openings: wall holes + portal tunnel (see through door) — mostly done; polish portal density
2. Floating furniture: billboard ground align / sink — increased sinks; verify all rooms
3. Plants: cross_planes + rembg cleanup (no black squares / flat edges)
4. Horizon z-fight (chair rail — already done; don't regress)
5. Period density (Myst/Oblivion/1856) — kitchen range hero, workshop density, conservatory fill
6. Screenshot tour camera: from_south/from_north sometimes clip into door leaf — pull camera back

## Done so far (baseline)
- `8211021` wall openings + portal tunnels + ground billboards + face-camera plants
- Loop1: cross-plane plants, richer portal hall, ajar doors, furniture sink
- Loop2: screenshot camera yaw, wood doors, kitchen range, workshop spawn, conservatory density
- Loop3: mesh plants sphere canopy; tool rack tools; morning+kitchen density
- Loop4: gallery machines continuous; paintings scene photos; density
- Loop5: plant PNG black cleared; workbench tops; pot racks; crown moulding
- Loop6: FIXED_Y plants; glass garden; morning density; oil lamps
- Loop7: glass hedge exterior; chandeliers; conservatory palms
- Loop8: fern cleanup; morning hall paper; workshop runner; kitchen shelf
- Loop9: palm not fern; pot racks; Argand lamp
- Loop10: mesh pots under plants; workshop denser; kitchen denser
- Loop11: terracotta not wood barrels; morning denser
- Loop12: no dual pots; conservatory mix; richer portals
- Loop13: mesh fronds; kitchen art; workshop walls
- Loop14: bush plants; cream lamps; hall chandelier
- Loop15: all-palm conservatory; dim kitchen; workshop paintings
- Loop16: short-wide palms; gallery denser; kitchen rug; morning pattern
- Loop17: kitchen wall shelves; conservatory glass; plant sink
- Loop18: hall shelves off doorway; conservatory corners; shelf brackets
- Loop19: plant stems; drawing paintings; workshop clutter
- Loop20: wainscot_height API; kitchen/workshop taller dado
- Loop21: taller wainscot; wall_vine; workshop denser
- Loop22: denser ivy attempt; gallery denser
- Loop23: removed balloon vines; denser palms; conservatory seating
- Loop24: max service wainscots; layered hedge; drawing denser
- Loop25: conservatory full dado; morning denser; portal lights; plant sink
- Loop26: furniture sinks; plant alpha; gallery cooler light
- Loop27: full-panel conservatory; plant shadow; kitchen darker
- Loop28: no mid-rail full panels; double cornice; gallery aisle
- Loop29: full-panel double-layer; fireplace ornaments
- Loop30: dark conservatory panels; stone thresholds; ajar doors
- Loop31: palm alpha bridges; workshop runner; exterior garden
- Loop32: conservatory stone path; richer aetheric coils; denser garden
- Loop33: dark conservatory paper; wall sconces hall+drawing; hall path
- Loop34: sconces more rooms; thicker skirting; plant sink
- Loop35: denser dresser; plant sink; more sconces
- Loop36: chalk board diagrams+sticks; coat stand top hat; gallery stone path; denser gallery props

## Do not
- Delete prop lists from fps_rooms
- Commit BACKUPS/*.tar.gz
- Break door E-triggers
- Change Engram lore / NPC dialogue / bridge for visual loops

## Schedule
- Every 10 minutes for ~7 hours (≈42 iterations)
- Cancel scheduler task when 7h elapsed or user returns


## Milestone 30
~30 unattended visual loops on private GitHub. Rooms denser, doors/portals solid, tall service wainscots, hybrid furniture, plant grounding improved. Remaining: palm FIXED_Y crown float, rembg plant assets, more unique room wallpaper contrast.
