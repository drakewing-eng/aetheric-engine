# Next session — paste / run this

**Status:** Prior unattended 10m visual scheduler is STOPPED. Fresh session should execute human-directed ~1h work (~6 loops), not restart the old 10m scheduler.

**Project memory tree (read first after Engram):** `SCRATCH/memory/INDEX.md` → `SCRATCH/memory/CURRENT.md`  
**Project:** `/Users/babble/aetheric-engine`  
**Godot:** `/Applications/Godot.app/Contents/MacOS/Godot`  
**HEAD at handoff:** see `git log -3`

## User directive (verbatim intent)

Looking better. When stepping into doorways they look like a closet, not an entrance hall, and then player falls through the floor. Stepping through a doorway should land in the entrance hall (target room) directly.

**User suggestion (recommended):** doors closed; transition **directly** into the next room (teleport on use / interact), rather than walking into a portal closet that has no floor/collision.

Also: **ottoman is under the sofa** (see session image of blue/green sofa).

Shelves look the same in various rooms (including kitchen) — Minecraft-like, green patches + brown blocks. Detail those out; they should not be generic identical bookcases everywhere.

**NEW RULE — object identity / uniqueness:**
- Each object needs a **specific design and identity**.
- No lazy repeats of the same hero still-life piece (e.g. one unique cheese block, not clones).
- Furniture pieces should be unique where possible.
- Allowed similarity: mass items like books on a shelf may share styles with a few unique standouts.
- Avoid repetitive non-specific Minecraft blocks.

Work on these issues for **~1 hour** (~**6** visual loops if using the autonomous loop pattern). Use Engram throughout. Visual-only still: no lore/dialogue/bridge unless needed for door transition.

## Implementation priorities (next agent)

1. **Door transition / fall-through**
   - Investigate room load + portal geometry + floor collision at door thresholds.
   - Prefer: closed door interact → load target room + spawn at door spawn (no walk-into-closet portal).
   - If portals remain: solid floor + correct portal length; never drop player through void.
   - Files likely: `fps_room_builder.gd` (`_add_door_portal`), door interaction / room switch code, `fps_rooms.gd` door dicts.

2. **Ottoman under sofa**
   - Reposition ottoman / mesh armchair / billboard sofa props in drawing room so nothing clips under sofa.
   - Files: `fps_rooms.gd` drawing_room props, `fps_props.gd` sofa/armchair/ottoman if exists.

3. **Bookshelf / wall_shelf identity**
   - Kitchen should not use the same tall “library bookshelf” as drawing/morning unless redesigned as kitchen dresser/plate rack.
   - Detail materials: no green mystery blobs / brown Minecraft cubes; period wood, plates, crocks, copper per room function.
   - Files: `fps_props.gd` `_make_bookshelf`, `_make_wall_shelf`, room prop lists.

4. **Uniqueness rule**
   - Audit repeated still-lifes (copper pots, crates, stools, identical shelf rows).
   - Introduce variation seeds / alternate kits per instance, or unique one-off hero props.

5. **Process**
   - Engram `session_start` + remember after changes.
   - Test: `test_room_art_pass.gd` PASS + screenshot tour + checkpoint push.
   - Do **not** re-enable 10m unattended scheduler unless user asks.

## Related docs
- `SCRATCH/VISUAL_LOOP_7H_SUMMARY.md` — 7h unattended run stopped (loops 0–43)
- `SCRATCH/VISUAL_LOOP_AUTONOMOUS.md` — loop protocol (visual-only)

## Engram concepts
- `aetheric__visual_loop_40` / `41` / `42` / `43` — recent loops
- `praxis_solution_*` — 7h stop summary
- This handoff: `aetheric__next_session_door_unique_props`
