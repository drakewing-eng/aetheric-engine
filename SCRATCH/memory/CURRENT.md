# CURRENT — Aetheric Engine (agent one-screen)

**Updated:** 2026-07-28 ~22:05 (overnight goal active)  
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
| 6 | Victorian wall art | **ADVANCED 69** real oil plates (9) replace clip-art; frame style forks; hollow liner so canvas shows; room coverage expanded |
| 7 | Plant diversity | **DONE 67** palm+fern, size tiers, mesh pots across rooms |

## Loops

| Loop | Work |
|------|------|
| 67 | Spacing + collision + walk + tools + plants + frames |
| 68 | Kitchen de-clutter; gallery stool/lamp spread; workbench uniqueness |
| 69 | **Wall art:** generated oil landscapes/still-lifes/botanical/ruin; fixed frame occlusion (black canvas); 4 frame styles; hall/gallery/morning/workshop placements |

## Still high-value if continuing

- Side-view mesh furniture where billboards thin (drawing chairs/desks edge-on)  
- Morning room light polish  
- Human E-door playtest  
- Further tool/prop micro-variety  
- Optional: more botanical/portrait plates; conservatory botanical hang if solid wall exists  

## Anchors

- Plan: `SCRATCH/memory/visual-deveraux-house-plan-interior-design.md`  
- Uniqueness: `SCRATCH/memory/visual/uniqueness-rule.md`  
- Shots: `auto_loop_67/`, `auto_loop_68/`, `auto_loop_69/`  
- Art plates: `aetheric-engine-godot/assets/rooms/textures/art/` (oil JPGs; old clip-art in `_old_clipart/`)  
