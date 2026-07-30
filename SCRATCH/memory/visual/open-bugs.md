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

## Status update 2026-07-28 (loop 72)

- §4 Wallpaper contrast: morning no longer reuses gallery damask — powder-blue stripe + oak panel dado. Workshop limewash over brick + board wainscot. Hall sage stripe. Kitchen cream check. Secondary papers now 4 distinct (test asserts).  
- Geometry: chair rail is triple (body + under-mould + bead); skirting has cap moulding + corner plinth blocks.  

## Status update 2026-07-28 (loop 76)

- §1 Door: teleport always uses **into-room yaw** (spawn_yaw often faced the leaf). Deeper/wider door triggers; `_door_busy` blocks double-E; post-load floor re-snap. Unique `DoorPortal_<target>` names. Automated `test_door_transitions.gd` PASS (graph, nudge footprint, face-in, triggers, floors). Human playtest still recommended.  

## Status update 2026-07-29 (loop 89)

- **Material bug:** dark mahogany (`MAHOGANY` / `MAHOGANY_DARK`) matched iron classifier → black metal desks/chairs. Fixed: iron requires true greys (r≈g≈b); metallic lowered.  
- Iron `floor_path`: riveted diamond-tread plates + curbs (gallery/workshop no longer Minecraft black slabs).  
- Chalk boards denser for distance read.  

## Status update 2026-07-29 (loop 144)

- **Fireplace polish:** chimney-glass overmantel, iron fender rail, fire tools (poker/shovel/tongs), coal scuttle, taller mantel ornaments, pilaster plinths. Still-life painting shifted clear of overmantel.  
- **Hall polish:** console turned-profile legs + warmer pedestal (not pipe/ebony blocks); plant/chair spacing for NW corner.  
- Residual: hall chair cutout cross-planes can still flash green scrap (accepted paper-thin tradeoff).  

## Status update 2026-07-29 (loop 145)

- **Kitchen prep still-life:** doorway read was stacked barrel/copper cylinders. Rewrote kits — flour sack as cloth box, wide dough board + loaf, cold apples (novel cue), knife, shallow copper basin; baking/veg/herb variants; lower shelf boxes not towers.  

## Status update 2026-07-29 (loop 147)

- **Hall chair green scrap:** seat-only velvet pad bulk behind cross_plane cards (intentional cushion, not plant bleed); furniture alpha scissor raised to 0.58. Legs stay off (rug L-junk).  
- **Floor baskets:** new `wicker_basket` (weave ribs, handles, apples/linen/veg) in kitchen + conservatory replacing packing-crate clutter.  

## Status update 2026-07-29 (loop 149)

- **Material bug:** CLAY/terracotta matched copper (then wood) → conservatory urns read as woven metal barrels. Fixed: terracotta class (g≥0.45) before copper; scrubbed wood excludes orange clay; copper stays g≈0.42.  
- **Urns:** classical amphora + handles, stone grit, sparse ivy (no green knob crown).  
- **Oil lamps:** slim stem, smaller font, taller amber glass hero.  

## Status update 2026-07-29 (loop 151)

- **Whole-house residual spacing:** hall plants no longer under demi-lune; freestanding lamps off runner. Workshop lamps/scrap/crates clear of iron path centre. Kitchen door approach wall-side only. Conservatory lamp beside table not under apron.  

## Status update 2026-07-29 (loop 153)

- **Chair edge-on:** cross_plane chairs/wings get four vertical stub feet under seat pad (no horizontal stretchers — those were rug L-junk).  
- **Door UX:** prompt is `[E] Enter <room>` (closed-leaf teleport). Door test nudge amount aligned to fps_main 0.65.  

## Status update 2026-07-29 (loop 155)

- **Morning room chair scrap:** too many cross_plane chairs caused extreme edge-on double-card ghosts. Thinned to wing + desk + one SE chair; clear centre walk.  
- **Hall kitchen runner:** freestanding oil lamps moved off carpet to side flanks.  

## Status update 2026-07-29 (loop 157)

- **Hall/gallery cutout chairs:** all converted to solid mesh chairs (edge-on volume).  
- **Kitchen:** formal cutout chair → stool (service identity).  
- **Wings:** drawing red + morning sage → full mesh armchair (no card/bulk colour ghost).  
- **Material:** fabric (velvet red/green) classified before wood so oxblood seats no longer read as mahogany timber.  

## Status update 2026-07-29 (loop 158)

- **Wing boxiness:** mesh armchair was a velvet fridge / ziggurat crown. Rewrote continuous shell + rounded crown rolls, diamond tufts, horizontal seat/arm bolsters, slim turned legs. Helper `_add_cylinder_rotated` for pipe bolsters.  

## Status update 2026-07-29 (loop 160)

- **Tea tray hero FOV:** pure-white block china on silver plank. Oval pewter tray, sphere-belly teapot + curved spout, warmer ivory (g≤0.64 so china ≠ linen fabric classifier), cups with tea liquid disc.  

## Status update 2026-07-29 (loop 156)

- **Tea at four:** redesigned `_make_tea_tray` — silvered rim tray, belly teapot with spout/C-handle/lid knop, saucers+cups, jug, sugar (not white box stack).  
- **Chair edge scrap:** drawing desk/side/approach + morning desk/SE → solid mesh chairs. Wings drop cross_planes; fuller mesh bulk for side volume without double-card ghost.  

## Status update 2026-07-29 (loop 158)

- **Wing silhouette:** `_make_armchair` rewritten — continuous shell + rounded crown bolsters (not fridge slab or ziggurat terraces).  
- **Horizontal rolls:** new `_add_cylinder_rotated` for seat front, arm, and crown (true axis orientation).  
- **Tufts:** staggered diamond buttons on seat + back. Drawing red + morning sage FOVs in `auto_loop_158/`.  

## Status update 2026-07-29 (loop 157)

- **Hall cutout chairs:** all entrance_hall side chairs → mesh (no cross_plane scrap). Gallery desk chair mesh. Kitchen formal cutout → stool.  
- **Wings solid:** drawing red + morning sage `armchair` mesh (no painted card bulk mismatch).  
- **Material bug:** VELVET_RED matched wood path first → timber wing. Fabrics now classify before wood browns.  

## Status update 2026-07-29 (loop 154)

- **Oil lamp residual mass:** freestanding Argands were still reading as fat metal barrels (esp. workshop/gallery mid-FOV). Root cause: opaque amber glass Color matched brass in `_mat_for` → metallic brass texture on chimney. Fix: pencil stem + thimble font + tall chimney; glass/emission use alpha transparency (never brass path). Mini Argands on furniture dress kits slimmed to match.

## Status update 2026-07-29 (loop 159)

- **Prep still-life cubes:** flour sack was stacked beige boxes; loaf was white bricks then copper metal (crust Color hit copper gate). Soft sphere-mass sack + oval matte loaf; crust r≤0.5 to miss copper. Rolling pin axis-rotated. Kit 2 oval wicker tray.  
- **Wing arm residual:** sphere_blob scroll read as billiard ball → fabric cylinder roll.  
