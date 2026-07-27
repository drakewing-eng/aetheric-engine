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

## Door transition (next fix)

- Room graph: each room’s `doors[]` has `target`, `spawn`, `spawn_yaw`, `pos`, `size`
- Portal geometry: `fps_room_builder.gd` `_add_door_portal` (stub hallway when only one room loaded)
- **Next design:** closed door interact → switch room + place player at target spawn; solid floors; no void fall

## Prop identity

- Prefer specialized makers over one generic `bookshelf` everywhere
- Uniqueness rule: [../visual/uniqueness-rule.md](../visual/uniqueness-rule.md)
