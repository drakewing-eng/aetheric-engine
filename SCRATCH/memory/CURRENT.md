# CURRENT — Aetheric Engine (agent one-screen)

**Updated:** 2026-07-28 ~23:50 (overnight goal active)  
**HEAD:** see latest commit  
**10m density scheduler:** OFF  
**Do not mark goal complete after one pass** — living priority queue.

## Ordered work list

| # | Item | Status |
|---|------|--------|
| 1 | Furniture spacing / overlap | **DONE 67–68** |
| 2 | Furniture collision | **DONE 67** |
| 3 | Walking not skating | **DONE 67** |
| 4 | Unique Victorian objects | **ADVANCED 71–75** |
| 5 | Geometric / surface detail | **ADVANCED 72+75** |
| 6 | Victorian wall art | **ADVANCED 69** |
| 7 | Plant diversity / side volume | **ADVANCED 74–75** |
| 8 | Side-view mesh furniture | **ADVANCED 70** |
| 9 | Door transition safety | **ADVANCED 76** face-into-room; busy lock; deeper triggers; `test_door_transitions` PASS |
| 10 | Wallpaper contrast | **ADVANCED 72** |
| 11 | Hall / prep still-life identity | **ADVANCED 73** |

## Loops

| Loop | Work |
|------|------|
| 67–75 | Visual queue + polish polish |
| 76 | **Doors:** always face into room after E; `_door_busy` anti double-tap; trigger depth/width; unique portal names; automated transition suite |

## Still high-value if continuing

- Human E-door playtest confirmation (automated suite green; still wants hands-on)  
- Optional drawing damask / thin-card polish if found  

## Anchors

- Plan: `SCRATCH/memory/visual-deveraux-house-plan-interior-design.md`  
- Uniqueness: `SCRATCH/memory/visual/uniqueness-rule.md`  
- Door test: `aetheric-engine-godot/scripts/test_door_transitions.gd`  
- Shots: `auto_loop_67/` … `auto_loop_75/`  
