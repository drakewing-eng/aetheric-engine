# Open visual / gameplay bugs (user playtest)

Source: user after 7h density loops + image feedback. Full paste: [../../NEXT_SESSION_VISUAL_PROMPT.md](../../NEXT_SESSION_VISUAL_PROMPT.md).

## 1. Doorways — closet + fall-through (P0)

**Symptom:** Entering a doorway feels like a small closet, not the hall beyond; player **falls through the floor**.

**Desired:** Stepping through / opening a door lands in the **target room** at its door spawn (e.g. entrance hall).

**Preferred design (user):** Doors **closed** by default; on use → **direct room transition** (load room + teleport). Do not require walking into a portal volume that has no real floor.

**Investigate:**

- `fps_room_builder.gd` — `_add_door_portal` (short hallway stub)
- Door interact / room switch / player controller
- `fps_rooms.gd` — `doors[]` (`target`, `spawn`, `spawn_yaw`, `pos`)
- Floor collision at thresholds vs portal depth

## 2. Ottoman under sofa (P0 drawing room)

**Symptom:** Ottoman sits **under** the sofa (clip).

**Fix:** Reposition drawing_room props (billboard sofa vs mesh ottoman/armchair). Check y/sink and xz placement in `fps_rooms.gd`.

## 3. Identical shelves / bookshelves (P1)

**Symptom:** Same shelf unit in many rooms including **kitchen**; green patches + brown blocks; Minecraft-like.

**Fix:**

- Kitchen → plate dresser / crocks / copper (not library books)
- Drawing/morning → true books with varied spines
- Workshop → tools / timber / parts
- Avoid shared generic green-blob + brown-cube still-lifes

**Code:** `fps_props.gd` (`_make_bookshelf`, `_make_wall_shelf`, dresser), room prop lists in `fps_rooms.gd`.

## 4. Remaining art debt (P2)

- Palm FIXED_Y crown float (asset)
- Paper-thin plants from extreme sides
- Wallpaper contrast between secondary rooms


## Status update 2026-07-28 (loop 66)

- §2 Ottoman: still in front of sofa; multi-style mesh (tuft/round/long).  
- §3 Shelves: bookshelf/tool/crock seed forks stronger; drawing no longer clones identical side_table billboards.  
- Doors: wood tone uniqueness by seed.  
- Drawing letters + tea tray added.  
- §1 Door transition: still closed leaf + E teleport (structural OK); human playtest residual.  

## Status update 2026-07-28 (loop 71)

- §1 Door: teleport forces y=0 + velocity clear; spawn nudged toward room centre; portal recess gets painted closed-leaf + panels + knob (less “closet void”). Still wants human E playtest.  
- §3 Uniqueness: copper pots 5 styles; crates open/stencil/rope; wall sconces 3 arm styles by pos seed; oil lamps 3 bases.  
