# CURRENT — Aetheric Engine (agent one-screen)

**Updated:** 2026-07-30 — retired iron floor_path  
**HEAD:** (local) iron path removed workshop + gallery  
**15m overnight scheduler:** OFF (user stopped)  
**Do not mark goal complete after one pass** — living priority queue.

## Ordered work list

| # | Item | Status |
|---|------|--------|
| 1–3 | Spacing / collision / walk | **DONE 67–68** |
| 4 | Unique Victorian objects | **ADVANCED 71–241** furniture soft |
| 5 | Geometric / surface detail | **ADVANCED 72–235** wood floors |
| 6 | Victorian wall art | **ADVANCED 69–205** frames |
| 7 | Plant diversity / side volume | **ADVANCED 74–238** denser fronds |
| 8 | Side-view mesh furniture | **ADVANCED 70–241** chesterfield |
| 9 | Door transition safety | **ADVANCED 76–208** portal solid |
| 10 | Wallpaper contrast | **ADVANCED 72–233** kitchen check |
| 11 | Hall / prep still-life | **ADVANCED 73–219** lower shelf |
| 12–23 | Conservatory densify | **ADVANCED 116–234** path dens |
| 24–142 | Prop solid mats…billboard bulk | **DONE 89–207** |
| 143–172 | Arch…oil lamp Argand | **DONE 208–237** |
| 173–175 | Plants / ottoman / club wing | **DONE 238–240** |
| 176 | Roll-dominant chesterfield sofa | **DONE 241** |

## Loops

| Loop | Work |
|------|------|
| 238 | **Plant denser side bulk** + **soft balloon chair cushion** |
| 239 | **Square ottoman soft pillow** + **wing rear curved shell** |
| 240 | **Club wing continuous shell** + **soft side-chair pads** |
| 241 | **Chesterfield roll-dominant** — 3 plump pillows + fat arm scrolls + channelled back |

## Still high-value if continuing

- **Human E-door playtest** confirmation (automated art + door suite PASS)  
- Optional residual: packing crates still boxy mid-FOV workshop  
- Optional residual: kitchen flour sack still tall cylinder mid-FOV  
- Intentional textures kept (wallpaper, rugs, oils, views, plant cards)

## Design notes

- **Iron `floor_path` retired** (workshop + gallery): factory diamond-tread fought Victorian house language. Workshop aisle is wood boards + work runners; conservatory keeps stone garden path.
- **Bell walk cycle** (`86cb87e`): 4 hard-alpha frames, no-mip scissor material, distance frame advance + idle on dwell. **Human playtest:** Drawing Room — legs should stay solid (not freckled) while he patrols.

## Solid-mat / residual status

- Prop solid-mat conversion largely exhausted  
- Architecture, machines, furniture, service textures advanced 208–241  
- Drawing-room sofa: roll-dominant chesterfield (not rectangular fridge slab)  

## Anchors

- Door test: `scripts/test_door_transitions.gd`  
- Shots: `auto_loop_67/` … `auto_loop_241/`  
