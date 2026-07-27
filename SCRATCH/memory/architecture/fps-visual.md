# FPS visual architecture (entry points)

**Godot project:** `aetheric-engine-godot/`  
**Binary:** `/Applications/Godot.app/Contents/MacOS/Godot`

## Core scripts

| File | Role |
|------|------|
| `scripts/fps_rooms.gd` | Room dicts: size, textures, features, props, doors, NPCs |
| `scripts/fps_props.gd` | Prop/feature makers (`_make_*`), materials, billboards |
| `scripts/fps_room_builder.gd` | Walls, floor, skirting, door portals, room assembly |
| `scripts/screenshot_tour.gd` | Automated visual QA tour PNGs |
| `scripts/test_room_art_pass.gd` | Headless art regression (must PASS) |

## Typical workflow

```bash
# Art pass test
Godot --headless --path aetheric-engine-godot -s res://scripts/test_room_art_pass.gd

# Screenshot tour
Godot --path aetheric-engine-godot --resolution 1280x720 -s res://scripts/screenshot_tour.gd

# Checkpoint + push
./scripts/checkpoint.sh "visual: short note"
```

## Door transition (loop 44+)

- Room graph: each room’s `doors[]` has `target`, `spawn`, `spawn_yaw`, `pos`, `size`
- **Design:** closed door leaf (`_make_door_frame`) + solid backstop; **E** → `_go_through_door` → load target + spawn
- Portal is shallow recess only (`_add_door_portal` depth ~0.28) — not walk-in closet
- Bounds use narrow doorway gaps; solid leaf blocks void fall-through

## Prop identity

- Kitchen: `crock_shelf` / `dresser` (not library `bookshelf`)
- Workshop: `tool_shelf` (not books)
- Drawing/morning: `bookshelf` with `seed` + leather spine colours
- Mass props use `seed` (copper_pot, stool, crate, pot_rack, side_table, wall_shelf, prep_table)
- Uniqueness rule: [../visual/uniqueness-rule.md](../visual/uniqueness-rule.md)
