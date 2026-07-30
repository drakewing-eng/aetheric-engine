# CURRENT — Aetheric Engine (agent one-screen)

**Updated:** 2026-07-30 ~overnight loop 209  
**HEAD:** (pending commit) visual loop 209  
**10m density scheduler:** OFF  
**Do not mark goal complete after one pass** — living priority queue.

## Ordered work list

| # | Item | Status |
|---|------|--------|
| 1–3 | Spacing / collision / walk | **DONE 67–68** |
| 4 | Unique Victorian objects | **ADVANCED 71–207** |
| 5 | Geometric / surface detail | **ADVANCED 72–209** service tiles |
| 6 | Victorian wall art | **ADVANCED 69–205** frames |
| 7 | Plant diversity / side volume | **ADVANCED 74–209** soft shadow |
| 8 | Side-view mesh furniture | **DONE 70–165** wing envelope |
| 9 | Door transition safety | **ADVANCED 76–208** portal solid |
| 10 | Wallpaper contrast | **ADVANCED 72–209** kitchen dens |
| 11 | Hall / prep still-life | **ADVANCED 73–206** fruit |
| 12–23 | Conservatory densify | **ADVANCED 116–205** glass wall |
| 24–142 | Prop solid mats…billboard bulk | **DONE 89–207** |
| 143 | Architectural trim + portal solid mats | **DONE 208** |
| 144 | Service wall densify + contact shadow | **DONE 209** |

## Loops

| Loop | Work |
|------|------|
| 205 | Windows + paintings + glass wall + wall vine solid mats |
| 206 | Plant mesh fronds/pots + prep fruit + flame emission mats |
| 207 | Billboard furniture mesh bulk solid mats |
| 208 | **Skirting/crown/chair rail** solid-mat mahogany + **door portal** solid-mat wood + stronger beyond-light leak |
| 209 | **Kitchen/workshop wall densify** (UV 0.72/0.58 + finer tile plates) + **contact shadow soften** (no black void discs under plants) |

## Still high-value if continuing

- **Human E-door playtest** confirmation (automated art + door suite PASS)  
- Optional: paper-thin plant cards from extreme side angles (mesh fronds help; card pot still flat)  
- Optional: kitchen prep still-life cube residual mid-FOV if user notes  
- Optional: wallpaper/floor period textures remain intentional plates  

## Solid-mat status

- **Props:** washout conversion largely exhausted (`_solid_matte` / `_solid_metal`)  
- **Architecture trim + portals:** solid mats (loop 208)  
- **Service walls:** denser UV + regenerated metro/brick plates (loop 209)  
- **Contact shadows:** warm soft discs (loop 209) — not pure black void  
- **Intentional textures:** wallpaper, floors, rugs, oil canvases, exterior views, plant cards  

## Anchors

- Door test: `scripts/test_door_transitions.gd`  
- Shots: `auto_loop_67/` … `auto_loop_209/`  
