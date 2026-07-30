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

## Status update 2026-07-29 (loop 173)

- **Botanical pot residual after 172:** multi-tier cylinders + TEX_STONE/wood washout still read as wedding cake mid-FOV. Single CLAY body (matches floor plant pots) + blue glaze band + flush red bloom disc in mouth.  
- **Stone path residual:** pale aligned boards. Staggered irregular flags, darker grit gaps, chunkier curbs.  
- **Watering can:** continuous bright copper belly (fewer weave-like seam bands).  

## Status update 2026-07-29 (loop 171)

- **Watering can residual:** 5-prim stick read as brown lump mid-FOV. Rewrote Haws-style can — stacked copper body + collar, long horizontal spout + rose head, C-handle, top bail, seam rivets; larger scale + yaw so spout reads from spawn.  
- **Floor trug residual:** low box nubs. Oval willow weave, arched end handles (+ optional crossbar), apples/linen/veg fills without foliage sphere scrap. Kitchen trugs inherit same mesh.  

## Status update 2026-07-29 (loop 176)

- **Kitchen range flue residual:** stepped grey boxes read as Minecraft ziggurat mid-FOV. Continuous rectangular iron shaft, surface bands only, front damper plate, single cornice cap + chimney pot. Solid matte iron (no width-step tiers).  

## Status update 2026-07-29 (loop 181)

- **Botanical table pot residual:** blue glaze band + red disc lid still read as wedding cake mid-FOV (conservatory side table). Classic tapered terracotta + saucer, leaf mound, irregular geranium cluster (red/pink/cream) — no contrasting band or lid disc.  

## Status update 2026-07-29 (loop 180)

- **Prep flour sack residual:** pale cream box stack still Minecraft cube mid-FOV after 174. Hessian jute plump bag (same-mat cylinders + oval cheek), dark twine cinch, brand stamp — not white fridge/crate stack.  
- **Urn residual:** light/dark mat_l/mat_d body tiers read as milk-churn stack. Single solid body mat, overlapping amphora cylinders, darker plinth only; mid-stone colors (pale washed white under glass).  

## Status update 2026-07-29 (loop 179)

- **Kitchen sink residual:** butler sink read as pure white Minecraft slab + T-pipe mid-FOV. Rewrote fireclay oval basin (not rim-wall box), scrubbed oak drain board with groove ribs, solid-metal brass hand-pump (barrel + curved spout + side lever), tiled backsplash with grout. Warm ware colors (not CREAM white). Helper `_solid_metal` for untextured brass/copper.  

## Status update 2026-07-29 (loop 178)

- **Garden bench residual:** cast-iron park bench read as black fridge slab mid-FOV (solid end panels + dense back). Open iron ends (legs + arm + braces, air under armrest), thin spindle back, 6 oak seat slats with gaps, solid matte iron greys.  

## Status update 2026-07-29 (loop 177)

- **Oil lamp residual:** freestanding Argands still thin gold sticks mid-FOV. Wider amber glass chimney (alpha emission, not brass), larger font cup, medium stem; stronger omni. Avoids fat brass barrels (loop 149) and hairline sticks.  

## Status update 2026-07-29 (loop 175)

- **Classical urn residual:** multi-cylinder stack read as stone barrel mid-FOV. Continuous amphora (foot→belly→shoulder→neck), solid matte stone (no TEX bands), C-handles, sparse trailing ivy only.  

## Status update 2026-07-29 (loop 174)

- **Watering can residual:** body still read as brown/wicker next to trug. Root: metal_copper.jpg grain + cop_l g≥0.45 hit CLAY. Fix: solid-metal copper materials (no albedo texture), g-safe copper colors on body/spout/handle.  

## Status update 2026-07-29 (loop 172)

- **Botanical vase residual:** white cream tiers still read as wedding cake at mid FOV. Terracotta pot (clay gate) + blue glaze band + dense low bloom crown.  

## Status update 2026-07-29 (loop 170)

- **Conservatory path residual:** flag colors hit iron/wood gates → metal plates + board look. Colors now r>0.45/g>0.42 (TEX_STONE); continuous gravel bed; moss/pebble without brass rivets.  
- **Botanical vase:** amphora silhouette + multi-stem bloom cluster (not white stick-cup).  

## Status update 2026-07-29 (loop 168)

- **Prep flour sack residual:** stacked cylinders with g<0.7 hit scrubbed-wood path → copper/wood coil look on doorway FOV. Wide low linen bag (g≥0.7 linen gate), flat cloth top, short twine ear, low oval loaf, flour scoop; salt crock moved clear of sack.  

## Status update 2026-07-29 (loop 167)

- **Door closet residual:** portal visual identity — double leaves for wide doors, destination Label3D plaque on lintel, warm under-leaf emission + soft omni (next-room light leak), overdoor cornice. Feature frames get glow + cornice. Prompt `[E] Enter · <room>`. Automated door suite still PASS; human playtest still recommended.  

## Status update 2026-07-29 (loop 165)

- **Wing side residual:** nested back/wing boxes still read as green stairs from morning side FOV after 164. Single deep shell + full-height wing envelope; front pad coplanar; arms under wing.  
- **Tea tray:** pot/lid/sugar no longer use untextured sphere_blob (stacked china cylinders only).  

## Status update 2026-07-29 (loop 163)

- **Prep flour sack residual:** kit 0 used untextured `_add_sphere_blob` → beige snowman on doorway FOV. Cloth bag via linen cylinders + top folds + twine neck; oval loaf is cylinders only (no foliage end-blobs).  

## Status update 2026-07-29 (loop 164)

- **Wing side steps:** upper/lower wing boxes read as green stairs. Continuous tall ear + leading cylinder only.  
- **Morning centre mattress:** seed-2 long fringe bench dominated rug FOV. Replaced with square seed-0 footstool (width 0.7); style-2 defaults slimmed.  

## Status update 2026-07-29 (loop 166)

- **Conservatory table cubes:** side_table seed 3 dress-1 book stack = fat colored Minecraft books. Conservatory uses seed 6 (botanical vase). Global table books via `_add_table_folio` / `_add_table_folio_stack` (thin leather + gilt edge).  

## Status update 2026-07-29 (loop 167)

- **Door closet residual (visual):** closed leaf still read as cupboard. Double leaves on wide doors; under-leaf emission leak; overdoor cornice; brass destination plaque + Label3D on leaf; HUD `[E] Enter · <room>`. Teleport graph tests still PASS.  

## Status update 2026-07-29 (loop 169)

- **Tiny floor plants:** mid-FOV green scrap from scale≤0.55 ferns on carpets. Plant card min size raised (h≥0.68, w≥0.55); morning mid-rug micro fern removed; perimeter plants enlarged in hall/drawing/morning/conservatory.  

## Status update 2026-07-29 (loop 162)

- **Sofa mesh residual:** loop 161 mesh used foliage `_add_sphere_blob` for cushions → pale lime balloons. Rewrote continuous buttoned seat + dense diamond back, velvet bolsters only, mahogany arm scrolls + crest. Ottoman morning fabrics re-gated (oxblood/sage hit velvet, not wood).  

## Status update 2026-07-29 (loop 161)

- **Green brick ottoman:** soft dome/bolsters/tufts + mahogany plinth (not Minecraft cube).  
- **Sofa billboard edge:** drawing room chesterfield → solid mesh kind (side volume without card ghost).  

## Status update 2026-07-29 (loop 160)

- **Tea tray hero FOV:** pure-white block china on silver plank. Oval pewter tray, sphere-belly teapot + curved spout, warmer ivory (g≤0.64 so china ≠ linen fabric classifier), cups with tea liquid disc.  

## Status update 2026-07-29 (loop 161)

- **Ottoman brick:** square footstool was a flat green Minecraft slab. Soft dome crown, perimeter bolsters, diamond tufts, fringe, bun feet (styles 0/1/2).  
- **Sofa billboard:** drawing-room chesterfield converted to solid mesh (three cushions, crown rolls, rolled arms, diamond tufts). Art pass now requires mesh sofa+armchair+ottoman.  

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
