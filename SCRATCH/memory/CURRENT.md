# CURRENT — Aetheric Engine (agent one-screen)

**Updated:** 2026-07-29 ~12:15 (overnight goal active)  
**HEAD:** see latest commit  
**10m density scheduler:** OFF  
**Do not mark goal complete after one pass** — living priority queue.

## Ordered work list

| # | Item | Status |
|---|------|--------|
| 1–3 | Spacing / collision / walk | **DONE 67–68** |
| 4 | Unique Victorian objects | **ADVANCED 71–125** doors |
| 5 | Geometric / surface detail | **ADVANCED 72–116** paths |
| 6 | Victorian wall art | **ADVANCED 69+96+97** hall |
| 7 | Plant diversity / side volume | **ADVANCED 74–116** urns |
| 8 | Side-view mesh furniture | **ADVANCED 70–124** wing chair |
| 9 | Door transition safety | **ADVANCED 76+98+125** portal leaf |
| 10 | Wallpaper contrast | **ADVANCED 72–115** service |
| 11 | Hall / prep still-life | **ADVANCED 73–122** candlesticks |
| 12–23 | Conservatory / gallery / workshop densify | **ADVANCED 116–120** |
| 24–52 | Materials…stools | **DONE 89–117** |
| 53–58 | Copper…gasolier | **DONE 118–123** |
| 59 | Exterior window views + wing chair polish | **DONE 124** |
| 60 | Portal 4-panel leaf + sharper views | **DONE 125** |

## Loops

| Loop | Work |
|------|------|
| 67–123 | Density through gasolier |
| 124 | **Views** + wing chair restore |
| 125 | **Doors:** portal full 4-panel leaf + brass lock/hinges; door-frame hardware denser. **Views:** sharper garden/street (less blur, hedge flowers, brick terrace). **Fix:** `fps_main` Vector2 XZ nudge used `.z` → `.y` (parse break). |

## Still high-value if continuing

- Human E-door playtest confirmation  
- Optional micro-polish  

## Anchors

- Door test: `scripts/test_door_transitions.gd`  
- Shots: `auto_loop_67/` … `auto_loop_125/`  
