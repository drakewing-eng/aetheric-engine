# CURRENT — Aetheric Engine (agent one-screen)

**Updated:** 2026-07-28 ~22:50 (overnight goal active)  
**HEAD:** see latest commit  
**10m density scheduler:** OFF  
**Do not mark goal complete after one pass** — living priority queue.

## Ordered work list

| # | Item | Status |
|---|------|--------|
| 1 | Furniture spacing / overlap | **DONE 67–68** drawing re-layout; kitchen thinned; gallery stools spread |
| 2 | Furniture collision | **DONE 67** billboard `col_size`; solid furniture hulls; workbench solid |
| 3 | Walking not skating | **DONE 67** ACCEL/FRICTION + lower speed in `fps_player.gd` |
| 4 | Unique Victorian objects | **ADVANCED 71** copper 5 styles; crate open/stencil/rope; sconce 3; lamp 3 |
| 5 | Geometric / surface detail | **ADVANCED 72** triple chair-rail; skirting cap + corner blocks |
| 6 | Victorian wall art | **ADVANCED 69** oil plates + frames + canvas fix |
| 7 | Plant diversity | **DONE 67** palm+fern, size tiers, mesh pots |
| 8 | Side-view mesh furniture | **ADVANCED 70** drawing mesh desk/wing/chairs; chesterfield bulk |
| 9 | Door transition safety | **ADVANCED 71** floor-snap; spawn nudge; portal leaf face |
| 10 | Wallpaper contrast (secondary rooms) | **ADVANCED 72** morning ≠ gallery; new hall/workshop/kitchen papers + dados |

## Loops

| Loop | Work |
|------|------|
| 67–68 | Spacing, collision, walk, kitchen/gallery density |
| 69 | Oil wall art |
| 70 | Mesh furniture sides + morning light |
| 71 | Door landings + prop micro-variety |
| 72 | **Room identity walls:** morning powder-blue stripe; workshop limewash+boards; hall sage stripe; kitchen cream check; rail/skirting geometry |

## Still high-value if continuing

- Human E-door playtest confirmation  
- Mesh bulk / solid mesh other rooms  
- Hall table / prep still-life uniqueness  
- Optional richer damask for drawing (already strong)  
- Plant side-volume residual  

## Anchors

- Plan: `SCRATCH/memory/visual-deveraux-house-plan-interior-design.md`  
- Uniqueness: `SCRATCH/memory/visual/uniqueness-rule.md`  
- Shots: `auto_loop_67/` … `auto_loop_72/`  
- Art plates: `aetheric-engine-godot/assets/rooms/textures/art/`  
