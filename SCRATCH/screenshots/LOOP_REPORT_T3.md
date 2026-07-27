# Visual loop report — target T3 hybrid (max 3 iterations)

**Date:** 2026-07-27  
**Target:** T3 hybrid (hero billboards + solid mesh kits + clean materials + density)  
**Method:** capture → score (0–2 × 8 criteria) → top-5 fix → verify  

Scoring: Identity | Bad-primitives | Materials | Density | Lighting | NPC | Hero | Period → max 16/room

---

## Loop 1 (baseline)

| Room | Score | Notes |
|------|------:|-------|
| drawing_room | 12 | Painted sofa/chairs good; books ok; plant cube; rug flat |
| gallery | 13 | Machine hero; Amara solid; side machines can-like |
| kitchen | 8 | Empty center; spawn faced door; blocky pots |
| conservatory | 7 | Minecraft trees; black quads |
| workshop | 6 | Sparse, simple benches |
| hall | 6 | Sparse, empty spawn |
| morning | 8 | Sparse, black desk |
| **House avg** | **~8.6** | **Tier T1–T2** |

### Top-5 fixes applied
1. Kitchen spawn face into room + denser copper/crates/tables  
2. Plant billboards (fern/palm) + rembg  
3. Workshop extra benches, tools, chalk, copper  
4. Morning denser shelves/tables/plant  
5. Hall plants/tables + spawn yaw; rug texture regen  

**Also:** billboard plant fails soft-fallback to mesh (no brown quads); secondary machines get gauges/pipes; prep table flour as cylinder not white cube.

---

## Loop 2 (after fixes)

| Room | Score | Notes |
|------|------:|-------|
| kitchen | 11 | Range visible, denser; still blocky set dressing |
| drawing | 13 | Fern plant works |
| conservatory | 9 | Palm gen failed (stumps) → dark quads until fallback |
| gallery | 13 | Stable |
| workshop | 9 | Denser but still mesh-simple |
| **House avg** | **~11** | **T2** |

### Loop 2 extra
- Pure rembg (don’t kill green foliage)  
- Palm regenerations; texture-load gate on plant billboards  

---

## Loop 3 (final this run)

| Room | Score | Notes |
|------|------:|-------|
| drawing | 13–14 | Sofa/fire/books/plant strong hybrid |
| kitchen | 12 | Larger range silhouette; full kitchen read |
| conservatory | 11–12 | Full-frond palm billboards |
| gallery | 13 | Unchanged strong |
| workshop | 9–10 | Density up; still mesh-era |
| hall/morning | 9–10 | Improved, not T3 hero rooms |
| **House avg** | **~12** | **T2 solid / T3 partial** |

### T3 gate status
- [x] No studio-square furniture (drawing heroes)  
- [x] Distinct room identities  
- [x] Kitchen ≠ workshop  
- [x] Painted plants in conservatory  
- [ ] All service rooms at adventure density (workshop still light)  
- [ ] PBR-ish materials / soft shadows everywhere  
- [ ] Hero mesh OR card for every major prop (range still mesh)  

**Verdict:** **T2 achieved house-wide; T3 partial** (drawing/gallery/kitchen leading). Full T3 needs more painted heroes (range, workbench) or real meshes — beyond one more micro-loop of box polish.

---

## Artifacts
- `SCRATCH/screenshots/loop_1/` baseline  
- `SCRATCH/screenshots/loop_1b/` mid  
- `SCRATCH/screenshots/loop_2/`  
- `SCRATCH/screenshots/loop_3/` final  
- Plants: `assets/props/plants/plant_{fern,palm}.png`  
- Tour: `scripts/screenshot_tour.gd`  

## Play
`/Users/babble/aetheric-engine/PLAY.sh`
