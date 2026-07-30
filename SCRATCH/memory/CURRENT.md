# CURRENT — Aetheric Engine (agent one-screen)

**Updated:** 2026-07-30 ~overnight loop 207  
**HEAD:** `7901c2a` visual loop 207  
**10m density scheduler:** OFF  
**Do not mark goal complete after one pass** — living priority queue.

## Ordered work list

| # | Item | Status |
|---|------|--------|
| 1–3 | Spacing / collision / walk | **DONE 67–68** |
| 4 | Unique Victorian objects | **ADVANCED 71–207** |
| 5 | Geometric / surface detail | **ADVANCED 72–207** solid mats |
| 6 | Victorian wall art | **ADVANCED 69–205** frames |
| 7 | Plant diversity / side volume | **ADVANCED 74–206** fronds |
| 8 | Side-view mesh furniture | **DONE 70–165** wing envelope |
| 9 | Door transition safety | **ADVANCED 76–204** solid-mat leaf |
| 10 | Wallpaper contrast | **ADVANCED 72–142** morning stripes |
| 11 | Hall / prep still-life | **ADVANCED 73–206** fruit |
| 12–23 | Conservatory densify | **ADVANCED 116–205** glass wall |
| 24–141 | Materials…plant/prep solid mats | **DONE 89–206** |
| 142 | Billboard mesh bulk solid mats | **DONE 207** |

## Loops

| Loop | Work |
|------|------|
| 203 | Copper scrap + floor path + wicker basket solid mats |
| 204 | Door frames + rug lip + mirror solid mats |
| 205 | Windows + paintings + glass wall + wall vine solid mats |
| 206 | Plant mesh fronds/pots + prep fruit + flame emission mats |
| 207 | **Billboard furniture mesh bulk** solid mats (sofa/desk/wing/chair edge volume) |

## Still high-value if continuing

- **Human E-door playtest** confirmation (automated suite PASS; visual cues 167)  
- Optional: room_builder architectural wood textures (intentional period plates — not washout path)  
- Optional: user-driven residual notes after playtest  

## Solid-mat status

Automatable prop `_mat_for` washout conversion is **largely exhausted** — makers use `_solid_matte` / `_solid_metal` / emission mats. Remaining textured plates are intentional (wallpaper, floors, rugs, oil canvases, exterior views, plant cards).

## Anchors

- Door test: `scripts/test_door_transitions.gd`  
- Shots: `auto_loop_67/` … `auto_loop_207/`  
