# Aetheric Engine 7h Visual Loop — Final Summary

**Stopped:** 2026-07-27 ~14:21 UTC  
**Scheduler:** cancelled recurring 10-minute task `019fa272beef` (VISUAL-ONLY improvement loop).  
**No further unattended visual loops will be started.**

## Scope

- **Project:** `/Users/babble/aetheric-engine`
- **Protocol:** `SCRATCH/VISUAL_LOOP_AUTONOMOUS.md`
- **Focus:** visual art only (rooms, props, materials, lighting, doors, textures)
- **Cadence:** every 10 minutes, unattended (~7h run from ~07:20 UTC start)

## Git activity since `ca35ed5`

- **~86 commits** on `main` from `ca35ed5` through `1df9637` (includes visual loop + docs status commits)
- **Latest HEAD at stop:** `1df9637` (`docs: loop43 status in autonomous protocol`)
- **Last visual code commit:** `510347c` — *visual loop 43: softer plant leaves, range mantel still-life, denser workshop/morning*

Representative span (newest → oldest visual loops):

| Loop range | Theme |
|---|---|
| 40–43 | Milestone polish: workbench/hall table density, plant side leaves, range mantel still-life |
| 30–39 | Dark conservatory panels, door thresholds, sconces, stone paths, tool racks, painting frames |
| 20–29 | `wainscot_height` API, tall service dados, full-panel walls, double cornice |
| 10–19 | Mesh pots / palm plants, denser kitchen/workshop, plant alpha fixes |
| 0–9 | Portals, plant cutouts, period density baseline |

## Screenshot archives

**44** capture directories:

`SCRATCH/screenshots/auto_loop_0` … `SCRATCH/screenshots/auto_loop_43`  
(44 dirs = loops 0–43 inclusive)

Each hold ~41 tour PNGs (spawn + from_south + NPC frames; PNGs gitignored).

## What improved (high level)

- **Doors / portals:** ajar Victorian leaves, stone+wood thresholds, short hallway portals (not solid exterior walls)
- **Rooms:** denser period props across drawing, hall, kitchen, workshop, gallery, morning, conservatory
- **Architecture:** per-room `wainscot_height`, tall service dados, double crown cornice, thicker skirting
- **Lighting:** chandeliers, wall sconces, Argand lamps, fireplace glow, cooler gallery fill
- **Plants:** palm cutouts (fern black artifacts removed), FIXED_Y + sink grounding, side leaf cards, palm alpha bridges
- **Kitchen identity:** range, pot racks, Welsh dresser, sink cupboard, prep tables (no lab workbench)
- **Gallery:** aetheric hero machine, denser secondary apparatus, clear aisle, stone paths
- **Conservatory:** glass walls + exterior garden hedge, stone floor path, dark solid-panel corners

## Remaining visual issues

1. **Palm FIXED_Y crown float** — rembg plant cards still disconnect frond/pot from some angles (asset-level; not fully solved by mesh side leaves)
2. **Plant flatness from extreme side views** — FIXED_Y billboards remain paper-thin off-axis; true 3D foliage still limited
3. **Wallpaper uniqueness / contrast** — secondary rooms improved but some still read similar at a glance
4. **Diminishing returns on density** — further clutter may crowd paths; next gains need better source art or real models
5. **User-reported regressions to re-verify in-game** — floating sofa, floating doorway, open door→wall (portals added; confirm live play, not only screenshot tour)

## Recommendation

Stop unattended 10-minute loops. Next visual work should be **human-directed** (playtest walkthrough, prioritised bugs) or occasional longer sessions—not another high-frequency scheduler.