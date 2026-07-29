# CURRENT — Aetheric Engine (agent one-screen)

**Updated:** 2026-07-28 ~22:20 (overnight goal active)  
**HEAD:** see latest commit  
**10m density scheduler:** OFF  
**Do not mark goal complete after one pass** — living priority queue.

## Ordered work list

| # | Item | Status |
|---|------|--------|
| 1 | Furniture spacing / overlap | **DONE 67–68** drawing re-layout; kitchen thinned; gallery stools spread |
| 2 | Furniture collision | **DONE 67** billboard `col_size`; solid furniture hulls; workbench solid |
| 3 | Walking not skating | **DONE 67** ACCEL/FRICTION + lower speed in `fps_player.gd` |
| 4 | Unique Victorian objects | **ADVANCED** tool_rack 6 tool kinds by seed; workbench seed dressing; more possible |
| 5 | Geometric / surface detail | **ADVANCED** chair splat variants; gilt corner frames; bench banding |
| 6 | Victorian wall art | **ADVANCED 69** real oil plates (9); frame styles; canvas occlusion fixed |
| 7 | Plant diversity | **DONE 67** palm+fern, size tiers, mesh pots across rooms |
| 8 | Side-view mesh furniture | **ADVANCED 70** drawing: mesh desk/wing/side chairs; chesterfield card + behind-card mesh bulk |

## Loops

| Loop | Work |
|------|------|
| 67 | Spacing + collision + walk + tools + plants + frames |
| 68 | Kitchen de-clutter; gallery stool/lamp spread; workbench uniqueness |
| 69 | Oil wall-art plates + frame styles + canvas occlusion fix |
| 70 | **Mesh furniture sides:** partner desk + wing + side chair replace paper cards; `_add_billboard_mesh_bulk` for sofa; morning light + garden views |

## Still high-value if continuing

- Human E-door playtest (open-bugs §1 residual)  
- Further tool/prop micro-variety (uniqueness)  
- Mesh bulk / solid mesh for other rooms if billboards still thin  
- Geometric surface detail pass (wainscot/carving)  
- Optional: more art plates  

## Anchors

- Plan: `SCRATCH/memory/visual-deveraux-house-plan-interior-design.md`  
- Uniqueness: `SCRATCH/memory/visual/uniqueness-rule.md`  
- Shots: `auto_loop_67/` … `auto_loop_70/`  
- Art plates: `aetheric-engine-godot/assets/rooms/textures/art/`  
