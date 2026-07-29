# CURRENT — Aetheric Engine (agent one-screen)

**Updated:** 2026-07-29 ~14:55 (overnight goal active)  
**HEAD:** see latest commit  
**10m density scheduler:** OFF  
**Do not mark goal complete after one pass** — living priority queue.

## Ordered work list

| # | Item | Status |
|---|------|--------|
| 1–3 | Spacing / collision / walk | **DONE 67–68** |
| 4 | Unique Victorian objects | **ADVANCED 71–128** plants |
| 5 | Geometric / surface detail | **ADVANCED 72–116** paths |
| 6 | Victorian wall art | **ADVANCED 69+96+97+133** kitchen |
| 7 | Plant diversity / side volume | **ADVANCED 74–128** fronds |
| 8 | Side-view mesh furniture | **ADVANCED 70–136** cross-planes |
| 9 | Door transition safety | **ADVANCED 76+98+125** portal leaf |
| 10 | Wallpaper contrast | **ADVANCED 72–115** service |
| 11 | Hall / prep still-life | **ADVANCED 73–126** tables |
| 12–23 | Conservatory / gallery / workshop densify | **ADVANCED 116–132** |
| 24–52 | Materials…stools | **DONE 89–127** |
| 53–62 | Copper…stools/sconces | **DONE 118–127** |
| 63–70 | Plants…side-chair heroes | **DONE 128–135** |
| 71 | Chair cross-planes + dust motes | **DONE 136** |

## Loops

| Loop | Work |
|------|------|
| 128–135 | Plants through side-chair heroes + settle |
| 136 | **Side chairs:** `cross_planes` + mesh bulk on heroes (drawing/hall/kitchen/gallery/morning). **Dust motes:** soft GPUParticles in drawing, hall, gallery. |

## Still high-value if continuing

- Human E-door playtest confirmation  
- Optional: leftover mesh chairs in far corners  
- Optional: dust mote density tuning / more rooms  
- Optional: edge-on bulk still boxy at rare angles  

## Anchors

- Door test: `scripts/test_door_transitions.gd`  
- Shots: `auto_loop_67/` … `auto_loop_136/`  
