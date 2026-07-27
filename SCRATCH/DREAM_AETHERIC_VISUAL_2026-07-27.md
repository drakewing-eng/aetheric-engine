# Dream consolidation — Aetheric Engine visual work (2026-07-27)

Consolidated from long unattended visual loop + playtest feedback + session handoffs.

## Session arc

1. **Unattended VISUAL-ONLY loop** ran every 10 minutes for ~7h (`scheduler 019fa272beef`).
2. Captures: `SCRATCH/screenshots/auto_loop_0` … `auto_loop_43` (44 dirs).
3. Many commits on private `main` (visual loop N + docs status). Stopped explicitly; scheduler deleted.
4. Final stop doc: `SCRATCH/VISUAL_LOOP_7H_SUMMARY.md` (`1b85acd`).
5. User playtest: better overall; critical gameplay/art issues remain.
6. Handoff for next work: `SCRATCH/NEXT_SESSION_VISUAL_PROMPT.md` (`bf55a36`).
7. Context filled (~95%); recommended new session + optional worktree; study handoff not full loop history.

## Hard rules that still apply

- Visual art only for that loop (rooms/props/materials/lighting/doors/textures).
- Never delete furniture/prop lists; fix `fps_props.gd` parse failures immediately.
- Test: `test_room_art_pass.gd` PASS; then `./scripts/checkpoint.sh "…"`.
- Do not re-enable 10-minute unattended scheduler unless user asks.

## Technical outcomes worth keeping

| Area | Outcome |
|------|---------|
| Doors | Ajar leaves + portals + thresholds added; still **broken for play** (closet feel, fall through floor) |
| Walls | Per-room `wainscot_height`; tall kitchen/workshop dados; conservatory full-panel dark wood |
| Density | Heavy prop fill across all rooms; sconces, stone paths, chandeliers |
| Plants | Palm cutouts, FIXED_Y, sink, alpha bridges, side leaf cards — **still imperfect** |
| Kitchen | Range/sink/dresser/prep identity (not lab workbench) |
| Gallery | Hero aetheric machine + secondary machines |

**Core files:** `aetheric-engine-godot/scripts/fps_rooms.gd`, `fps_props.gd`, `fps_room_builder.gd`.

## User-confirmed open work (priority)

1. **Door transition:** closed door → direct load of target room + spawn; fix void/floor fall; do not rely on walk-into portal closet.
2. **Drawing room:** ottoman under sofa (clip).
3. **Shelves:** identical Minecraft-like shelves/bookshelves (incl. kitchen) — redesign with room-specific identity.
4. **Uniqueness rule:** each object needs specific design/identity; no lazy clones of hero still-lifes; mass items (books) may share styles.

**Suggested effort:** ~1 hour / ~6 focused loops, human-directed, Engram throughout.

## Anti-patterns / scars

- Unattended 10m density loops hit **diminishing returns**; more clutter without identity worsens “Minecraft block” feel.
- Portal hallway is **not** a substitute for real multi-room load + collision.
- Mesh “ivy/wall_vine” balloon poles and dual mesh pots under billboards were bad; prefer real cutouts or true meshes.
- Cross_planes on plants doubled pots; FIXED_Y alone keeps plants paper-thin from the side.

## Engram concept keys

- `aetheric__visual_loop_N` (many N)
- `aetheric__next_session_door_unique_props`
- `helper:session_handoff_latest`
- Praxis: 7h visual loop stop solution

## Next agent first actions

1. `session_start` + read handoff concepts/files above.
2. Find room switch / door interact code; implement closed-door teleport + floor fix.
3. Fix drawing sofa/ottoman placement.
4. Specialize kitchen shelves vs library bookshelves; kill green/brown mystery blocks.
5. Apply uniqueness rule when adding/editing props.
