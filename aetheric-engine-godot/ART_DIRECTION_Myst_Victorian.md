# Richmond House — Near-Final Art Direction (Myst × 1856)

**Target:** Environmental storytelling and material realism approaching *Myst* / classic adventure games, set in a mid-Victorian Surrey country house (summer 1856).  
**Engine approach:** Hybrid Godot FPS — textured architecture + painted/unique prop silhouettes + billboard NPCs. Shared house language (wood, plaster, brass, candlelight) with **distinct room functions and palettes**.

**Ship bar:** From any doorway at ~5 m, the player must know *which room* they entered without reading the HUD title. Kitchen must read as kitchen. Gallery must read as experiment. Conservatory must read as glass and plants.

---

## Studio process (how a pro team would ship this)

| Role | Owns |
|------|------|
| **Art director** | Bible, palette, room identity cards, “don’t ship” rules, final visual gate |
| **Environment artists** | Tileable wallpaper / floor / wainscot per room; skirting, rails, windows, glass |
| **Prop artists** | Unique furniture silhouettes; hero billboards; set-dressing kits |
| **Lighting TD** | Per-room mood (fire, north light, machine glow, glasshouse, soft morning) |
| **Integration** | Godot materials, scale, collision, import, alpha scissor, occlusion |
| **Playtest** | Silhouette read at 5 m, clutter density, door readability, NPC vs furniture |

**Production order:** identity cards → tileables → hero props → set dressing → lighting → integrate → playtest loop.

---

## What else must be considered (near-final draft)

1. **Scale bible** — door 2.1–2.4 m; chair seat ~0.45 m; table ~0.75 m; adult NPC 1.65–1.8 m; Elspeth ~1.55–1.6 m  
2. **Occlusion** — NPCs write depth (alpha scissor); no ghost-through-chair  
3. **Door readability** — frames, gaps, triggers inside room; furniture never blocks approach  
4. **Collision vs visual** — solid chairs/tables; soft rugs; open doorways  
5. **Performance** — shared materials; billboards for complex silhouettes; ~2–4 omnis/room  
6. **Period accuracy 1856** — copper/brass/cast iron; oil/candles; no electric LEDs; no steampunk neon  
7. **Wear & life** — scuffs, soot near fire, lived-in desk still lifes  
8. **Story clutter** — Amara’s notes, Rooke’s filings, Clara’s order, Elspeth’s copybook  
9. **Import pipeline** — new JPG/PNG must import or Image.load fallback  
10. **Audio later** — room tone hooks for sound design  
11. **Accessibility** — door frame contrast; silhouette over color-only cues  
12. **Save/load** — static summer day architecture for this draft  

---

## Master improvement list

### P0 — House identity

- [x] Shared material language: mahogany, oak, brass, linen, velvet, plaster — textured  
- [x] Vertical hierarchy: skirting → wainscot → wallpaper → picture rail  
- [x] Per-room tileables for kitchen, workshop, conservatory, morning room  
- [x] Warm + cool light mix; room-specific energy/color  
- [x] Utility metals: copper / iron / brass textures  

### P0 — Room distinction (identity cards)

| Room | Function | Palette | Signature objects | Light | Status |
|------|----------|---------|-------------------|-------|--------|
| **Entrance hall** | Arrival | Dark wood, muted green, runner | Hall tables, coat stand, umbrella stand, plants | Cool-warm transit | shipped |
| **Drawing room** | Gentry | Green damask, red velvet, fire | Painted sofa/desk/chairs, fireplace, books | Candle + fire | shipped |
| **Gallery** | Experiment | Sage, brass, cyan glow | Aetheric engine, benches, chalk boards | Dual warm + cyan | shipped |
| **Kitchen** | Food / heat | Cream tile, iron, copper | **Range, dresser, sink, prep table** | Hearth orange | shipped |
| **Workshop** | Labor | Soot plaster, metal | Benches, tool rack, crates, copper scrap | Oil amber | shipped |
| **Conservatory** | Plants / glass | Stone tile, iron, green | Glass walls, tall plants | Cool daylight | shipped |
| **Morning room** | Soft day | Pale blue-cream | Lesson desk, linen chairs, soft light | Cool morning | shipped |

### P0 — Furniture & objects

- [x] No two rooms share the same prop layout  
- [x] Kitchen never reuses lab workbench → range / dresser / sink / prep_table  
- [x] Gallery aetheric_machine multi-part silhouette + cyan glow  
- [x] Hero painted billboards for drawing-room sofa / chair / desk / armchair / side tables  
- [x] Workshop tool rack + copper scrap  
- [x] Conservatory plants + glass_wall features  
- [x] Hall coat_stand + umbrella_stand  
- [x] Contact shadows under major furniture  
- [x] Metal-aware materials on copper / brass / iron  

### P0 — Set dressing

- [x] Dense kits per principal room (pots, crates, stools, plates, tools, books)  
- [x] Desk still life (letters, ink, candle)  
- [x] Kitchen still life (kettle, flour, bowls, copper)  

### P1 — Polish remaining (backlog)

- [ ] Window exterior garden/sky cards  
- [ ] Particle dust / fire sparks  
- [ ] Higher-res painted kitchen range / engine hero cards  
- [ ] Audio-visual sync  

---

## Technical pipeline

1. Tileables: `assets/rooms/textures/victorian/wallpaper_*.jpg`, `floor_*.jpg`, `wainscot_*.jpg`  
2. Metals: `metal_copper.jpg`, `metal_iron.jpg`, `metal_brass.jpg`  
3. Painted props: `assets/props/drawing_room/*.png` → `kind: "billboard_prop"`  
4. Prop kinds: kitchen_range, dresser, sink, prep_table, coat_stand, umbrella_stand, plant, tool_rack, crate, stool, aetheric_machine, copper_pot, chalk_board, billboard_prop  
5. Features: window, door_frame, painting, mirror, glass_wall  
6. Verify: `test_graphics_assets.gd`, `test_room_art_pass.gd`  

---

## Acceptance criteria (close-to-final)

1. Kitchen from doorway: range + copper + cream — never “another workshop.”  
2. Gallery: dominant aetheric machine + cool glow.  
3. Conservatory: glass + plants dominant.  
4. Morning room: softer palette than drawing room.  
5. Drawing room: painted furniture + fire.  
6. Hall: runner + tables + coat stand + multi doors.  
7. No flat untextured major furniture.  
8. NPCs opaque and depth-writing.  
9. All doors walkable.  
10. Dual headless Godot tests EXIT=0.  

**Headless evidence (2026-07-24):**  
`test_graphics_assets` PASS · `test_room_art_pass` PASS ×2 (all 7 rooms build, kitchen identity, distinct wallpapers).

---

## Self-critique pass (square backgrounds + minimal detail)

### Root cause of square furniture
Painted hero PNGs were **studio product shots with opaque brown backdrops**. Alpha was ~85–95% opaque (corners α=255). Alpha-scissor billboards therefore drew full **brown rectangles**.

### Fixes shipped
1. **rembg (U2Net)** cutouts from original JPGs → real transparency; corners α=0; 60–80% transparent frames  
2. Tight content crop so quads aren’t empty frames  
3. Billboard **no longer uses FIXED_Y camera face** (kept room yaw; dual-sided quads)  
4. **Filename remap** (on-disk names were historically swapped: desk.png=sofa, sofa.png=desk, chair.png=armchair, armchair.png=side chair)  
5. Enriched **mesh** sofa/armchair/chair/desk/side_table for rooms without painted heroes  
6. Automated alpha-corner tests in `test_room_art_pass.gd`

### Remaining honesty
Meshes are still hybrid primitives (not carved 3D Victorian). Kitchen/workshop/conservatory rely on mesh kits. Painted heroes are the high-detail path in the drawing room.

---

## Files touched this pass

- `ART_DIRECTION_Myst_Victorian.md` — this bible  
- `scripts/fps_props.gd` — full prop kit expansion  
- `scripts/fps_rooms.gd` — per-room materials, lighting, unique layouts  
- `scripts/fps_room_builder.gd` — ceiling tint, extra hall/gallery fill light  
- `scripts/test_graphics_assets.gd` / `test_room_art_pass.gd`  
- `assets/rooms/textures/victorian/*` — kitchen/workshop/conservatory/morning + metals  

**Play:** `/Users/babble/aetheric-engine/PLAY.sh`
