# CURRENT — Aetheric Engine (agent one-screen)

**Updated:** 2026-07-29 (overnight goal)  
**Primary goal:** Deveraux visual + interaction overhaul (7-item ordered list)  
**Plan bible:** `visual-deveraux-house-plan-interior-design.md`  
**Uniqueness:** `visual/uniqueness-rule.md`  
**10m density scheduler:** OFF  

## Ordered work list status

| # | Item | Status |
|---|------|--------|
| 1 | Furniture spacing / overlap | **DONE loop 67** — drawing room re-laid: no stacked chairs/desks; clear walk rings |
| 2 | Furniture collision | **DONE loop 67** — billboard `col_size` hulls; solid seats/benches; workbench solid tops/legs |
| 3 | Walking not skating | **DONE loop 67** — ACCEL/FRICTION walk model, slower WALK_SPEED |
| 4 | Unique Victorian objects (esp tools) | **IN PROGRESS** — tool_rack seed tool types; workbench seed dressing; more remaining |
| 5 | Geometric / surface detail | **IN PROGRESS** — chair piping/splat variants; painting corner ornaments; workbench banding |
| 6 | Victorian wall art | **PARTIAL** — gilt multi-step frames; content still procedural landscapes (period-subject OK, style still simplified) |
| 7 | Plant diversity | **DONE loop 67** — palm/fern mix + size tiers; mesh pots; conservatory/hall/drawing diversified |

## Loop log

| Loop | Work |
|------|------|
| 66 | Uniqueness pass (prior session) |
| **67** | Spacing layout + collision hulls + walk accel + unique tool racks + plant kinds/sizes + chair/frame detail |

## Remaining high-value

1. Deeper prop uniqueness (kitchen still-lifes, more tool variety on benches)  
2. Richer period art plates if assets available (or further frame/canvas polish)  
3. Mesh sofa alternative where billboards thin from side  
4. Human E-door playtest  
5. Scan other rooms for residual overlap (gallery stools, kitchen)  

## Paths

- Shots: `SCRATCH/screenshots/auto_loop_67/`  
- Code: `fps_rooms.gd`, `fps_props.gd`, `fps_player.gd`  
