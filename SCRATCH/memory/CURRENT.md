# CURRENT — Aetheric Engine (agent one-screen)

**Updated:** 2026-07-28 ~22:35 (overnight goal active)  
**HEAD:** see latest commit  
**10m density scheduler:** OFF  
**Do not mark goal complete after one pass** — living priority queue.

## Ordered work list

| # | Item | Status |
|---|------|--------|
| 1 | Furniture spacing / overlap | **DONE 67–68** drawing re-layout; kitchen thinned; gallery stools spread |
| 2 | Furniture collision | **DONE 67** billboard `col_size`; solid furniture hulls; workbench solid |
| 3 | Walking not skating | **DONE 67** ACCEL/FRICTION + lower speed in `fps_player.gd` |
| 4 | Unique Victorian objects | **ADVANCED 71** copper 5 styles; crate open/stencil/rope; sconce 3 styles; oil lamp 3 bases |
| 5 | Geometric / surface detail | **ADVANCED** chair splat; gilt frames; bench banding; portal leaf panels |
| 6 | Victorian wall art | **ADVANCED 69** real oil plates (9); frame styles; canvas occlusion fixed |
| 7 | Plant diversity | **DONE 67** palm+fern, size tiers, mesh pots across rooms |
| 8 | Side-view mesh furniture | **ADVANCED 70** drawing mesh desk/wing/chairs; chesterfield bulk |
| 9 | Door transition safety | **ADVANCED 71** floor-snap teleport; spawn nudge inward; closed leaf face on portal |

## Loops

| Loop | Work |
|------|------|
| 67 | Spacing + collision + walk + tools + plants + frames |
| 68 | Kitchen de-clutter; gallery stool/lamp spread; workbench uniqueness |
| 69 | Oil wall-art plates + frame styles + canvas occlusion fix |
| 70 | Mesh furniture sides + morning light |
| 71 | **Doors + props:** safe E-teleport landings; portal closed-leaf face; copper/crate/sconce/lamp micro-variety |

## Still high-value if continuing

- Human E-door playtest confirmation (code hardened; needs hands-on)  
- Mesh bulk / solid mesh for other rooms if billboards still thin  
- Geometric wainscot/carving polish  
- Wallpaper contrast secondary rooms  
- Further uniqueness on hall table / prep still-lifes  

## Anchors

- Plan: `SCRATCH/memory/visual-deveraux-house-plan-interior-design.md`  
- Uniqueness: `SCRATCH/memory/visual/uniqueness-rule.md`  
- Shots: `auto_loop_67/` … `auto_loop_71/`  
- Art plates: `aetheric-engine-godot/assets/rooms/textures/art/`  
