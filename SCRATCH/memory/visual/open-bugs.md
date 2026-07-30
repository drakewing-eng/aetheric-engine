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

## Status update 2026-07-30 (loop 204)

- **Door frame residual:** leaf/architrave/brass still `_mat_for` washout at every portal. Solid-mat wood tones + solid-metal brass furniture; `_add_mesh_box` now supports solid collision so closed leaf still blocks walk-through. Door suite PASS.  
- **Rug residual:** border/fringe used textured path. Solid-mat lip + fringe teeth (woven plate texture retained).  
- **Mirror residual:** gilt frame still brass-texture washout. Solid-metal gilt + dark liner.  

## Status update 2026-07-30 (loop 203)

- **Copper scrap residual:** wood tray + copper/iron still `_mat_for` washout mid-FOV workshop. Solid-mat oak tray + solid-metal spool/plates/tubes all 3 styles.  
- **Floor path residual:** iron plates / wood boards / stone flags used textured path. Full solid-mat iron tread + rivets, oak boards, stone flags + grit/moss.  
- **Wicker basket residual:** willow + fills still washout. Solid-mat weave + apples/linen/veg fills.  

## Status update 2026-07-30 (loop 202)

- **Secondary machine residual:** style 0 coil frame + style 2 Leyden still `_mat_for` washout mid-FOV. Full solid-mat bases/coils/jars; Leyden cyan terminal → warm amber. Style 1 already solid from 182.  
- **Teak garden settle residual:** seed-1 bench still textured wood path. Solid-mat teak + cushion.  
- **Copper pot residual:** freestanding vessels used metal_copper texture. Solid-metal copper/brass/iron all 5 styles.  

## Status update 2026-07-30 (loop 201)

- **Fireplace residual:** marble/brass/iron/mantel still `_mat_for` washout mid-FOV. Full solid-mat surround, overmantel frame, fender, tools, scuttle, seed mantel kits (candles/urns/clock). Flame/sparks/mirror plate kept special.  
- **Aetheric machine residual:** pedestal + copper coils still textured. Solid-mat oak base, iron posts, copper coils/windings, brass spine (dome already solid from 191).  
- **Prep table residual:** scrubbed top + legs still `_mat_for`. Solid-mat top/apron/legs (kits already solid).  

## Status update 2026-07-30 (loop 200)

- **Sofa residual:** chesterfield velvet/mahogany still `_mat_for` washout mid-FOV drawing room. Solid-mat velvet seat/back/arms + mahogany plinth/crest/feet + brass nails.  
- **Tea tray residual:** silver tray + china hit metal/fabric classifiers. Solid-metal pewter tray + solid-mat china pot/cups/jug/sugar.  
- **Letter stack residual:** paper stack used textured path. Solid-mat vellum + ink lines + wax seal + ribbon.  

## Status update 2026-07-30 (loop 199)

- **Armchair residual:** wing shell mahogany/velvet still `_mat_for` washout mid-FOV. Solid-mat velvet shell + mahogany rail/legs.  
- **Ottoman residual:** square/drum/bench fabric + wood washout. Solid-mat velvet + mahogany + brass nails.  
- **Side table residual:** pedestal/legs hit wood→iron washout mid-FOV. Solid-mat mahogany bases + solid dress (Argand glass, crock, pot, candle/letters). Table folios solid-mat leather + gilt.  

## Status update 2026-07-30 (loop 198)

- **Chair residual:** mahogany/velvet washout mid-FOV house-wide. Solid-mat wood + velvet seat/splat + brass nails.  
- **Stool residual:** oak/mahogany/velvet washout. Solid-mat tripod/square/drum styles.  
- **Oil lamp residual:** stem/font washout. Solid-mat wood stem + metal font + brass collar + amber glass.  

## Status update 2026-07-30 (loop 197)

- **Kitchen range residual:** body/brass/copper still `_mat_for` washout mid-FOV. Full solid-mat iron body, brass trim, copper vessels, stone hearth.  
- **Chalk board residual:** mahogany frame washout. Solid-mat frame + chalk rail + sticks.  

## Status update 2026-07-30 (loop 196)

- **Tool rack residual:** dark frame + stick tools mid-FOV workshop. Solid-mat frame/back + iron hammers/wrenches/tongs/planes + copper mallets.  
- **Hall dress kits 0/1/3 residual:** candlesticks/hat box/silver tray still `_mat_for` washout. Solid-mat trays, candles, clock, hat box, silver Argand.  

## Status update 2026-07-30 (loop 195)

- **Bookshelf residual:** case + spines texture-washed mid-FOV drawing/morning. Solid-mat case wood + solid-mat leather spines/gilt + brass bookends.  
- **Workbench residual:** scrubbed top / mahogany base / tools washout. Solid-mat top, base, iron/brass/copper tools.  
- **Hall table residual:** mahogany legs read black iron mid-FOV. Solid-mat mahogany base (turned/square/demi).  

## Status update 2026-07-30 (loop 194)

- **Tool shelf residual:** dark washed wood cubes mid-FOV workshop/gallery. Solid-mat oak case + iron wrenches/copper stock + hanging tools.  
- **Welsh dresser residual:** texture-washed oak + ware. Solid-mat base cupboard, plate rack, plates/crocks/copper.  
- **Partner desk residual:** mahogany hit iron/wood washout. Solid-mat mahogany + leather top + brass pulls + paper/ink/candlestick.  

## Status update 2026-07-30 (loop 193)

- **Prep kits 2–3 residual:** market veg + scullery still used `_mat_for` washout paths. Solid-mat wicker tray/chop block/cleaver; solid-mat mortar/colander/herbs.  
- **Crock shelf residual:** oak frame + ware texture-washed mid-FOV kitchen. Solid-mat oak frame + cream plates/clay crocks/copper bowls.  

## Status update 2026-07-30 (loop 192)

- **Prep flour sack residual (post-190):** upright cylinder still read as cake/tin mid-FOV. Horizontal hessian bag on its side + cinch ear + brand stamp + flour spill.  
- **Prep lower shelf residual:** anonymous wood cubes. Bread tin + crock + nested copper pan, solid mats.  
- **Baking kit (kit 1):** solid-mat dough/pie/rolling pin/bowl (no texture washout).  

## Status update 2026-07-30 (loop 191)

- **Hero aetheric cyan dome residual:** fat teal/cyan hat + cool fill mid-FOV gallery_from_south. Brass gallery ring + compact amber chamber + warm copper aether glow; warm lights only (no cyan).  
- **Umbrella stand residual:** anonymous dark cylinder. Oak/ceramic pot + brass rim + crook-handle sticks, solid mats.  

## Status update 2026-07-30 (loop 190)

- **Prep flour sack residual (post-189):** rectangular body still read as crate mid-FOV. Soft plump cylindrical hessian bag + cinch ear + brand stamp (one rounded mass).  
- **Hall coat stand residual:** thin stick pole mid-FOV. Victorian hall tree — wide base, turned column rings, solid-metal brass hooks, coats/hat, solid matte wood.  
- **Secondary machine cyan hats:** style 0/1 fat cyan glass mid-FOV gallery. Amber/brass terminals + warm emission (not cyan game hats).  

## Status update 2026-07-30 (loop 189)

- **Prep flour sack residual:** kit-0 still wedding-cake cylinder tiers mid-FOV (`kitchen_from_south`). Low rectangular hessian bag — continuous body width, sewn panels, twine, brand stamp, solid matte (not tier stack).  
- **Wall shelf residual:** black stick posts + thin plank mid-FOV kitchen-wide. Oak plate rail + wall back plate + triangle wood brackets + iron L-straps + solid-mat plates/crocks/copper.  

## Status update 2026-07-29 (loop 188)

- **Kitchen pot rack residual:** mahogany stick T-frame mid-FOV. Twin iron rails + oak wall brackets + iron struts, S-hooks, solid-metal copper skillets/saute/covered pot/ladle (not stick lumber).  

## Status update 2026-07-29 (loop 187)

- **Wall sconce residual:** thin brass L-stick + nub mid-FOV house-wide. Victorian gas sconce rewrite — solid-metal brass backplate, arm (straight/curved/candle-plate by seed), frosted alpha shade or globe with emission, stronger omni.  

## Status update 2026-07-29 (loop 186)

- **Packing crate residual:** solid wood cubes mid-FOV (gallery/workshop). Rewrote as boarded shipping crate — separate plank faces, corner posts, iron bands + corner straps, floor skids, lid board seam or ajar straw, seed forks for rope handles/stencil/hasp. Solid-matte wood (no texture washout).  

## Status update 2026-07-29 (loop 185)

- **Hall table flower vase residual:** dress-2 cream cylinder stack + sphere blooms read as wedding cake mid-FOV. Slim porcelain bud bottle (narrow neck), blue glaze band, irregular red/pink/yellow bloom cluster + leaf pad; cards + ink tray solid-matte.  

## Status update 2026-07-29 (loop 184)

- **Chandelier residual:** frosted shades read as cream ice-cream cone cluster mid-FOV. Brass gasolier rewrite — solid-metal brass ring/arms/body, shorter alpha frosted bell shades with emission, gallery rings, compact crystal drops.  

## Status update 2026-07-29 (loop 183)

- **Classical urn residual:** amphora cylinder stack still read as milk-churn mid-FOV after 180. Rewrote Victorian pedestal garden urn — round base disc, narrow turned stem, wide bowl + rolled rim, dark sandstone (not pale cream), small loop handles, trailing ivy drape.  

## Status update 2026-07-29 (loop 182)

- **Gallery secondary machine residual:** style-1 harmonic resonator was solid iron side cheeks + back panel + cyan glass hat = iron fridge mid-FOV. Open oak plinth, two posts, air-spaced copper diaphragms, thin rear rail, small glass jar + tuning-fork prongs.  

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
