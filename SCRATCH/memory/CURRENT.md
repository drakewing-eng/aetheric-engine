# CURRENT — Aetheric Engine (agent one-screen)

**Updated:** 2026-07-28  
**Primary goal:** `goal:aetheric_deveraux_interior_plan`  
**Plan:** `visual-deveraux-house-plan-interior-design.md`  
**Loop protocol:** `IMPLEMENT_8H_LOOP_PROTOCOL.md`  
**HEAD:** (post loop 65)  
**10m unattended scheduler:** OFF  

## Implement progress (novel-true revision)

| Loop | Work |
|------|------|
| 61 | Gallery: oak base + 3 copper coils + south bracket; clear floor; desk/ledger; diagrams; no salon clutter. Workshop lean tools. Hall restrained. Conservatory edge plants. Morning light desk set. Drawing without workshop crates/copper. |
| 62 | Gallery south windows; thin kitchen copper/crates; thin morning wall art |
| 63 | Clearer window glass alpha so exterior views read |
| 64 | Full-room screenshot QA (`auto_loop_64`) |
| 65 | **Windows fix:** hollow sash frame (solid box was void-black); gallery south windows lowered/inset; green/sky/yard reads in `gallery_from_north`. Machine counter-wound spiral bars + larger south bracket. Freestanding `oil_lamp` prop in gallery+hall. E-door structural verify (all targets valid, closed frames, `_go_through_door`). Art pass PASS. Shots `auto_loop_65`. |

## Loop protocol for remaining / multi-session

```
goal-driven continuous loops
  → edit per plan room order
  → art pass PASS
  → screenshots auto_loop_N
  → checkpoint.sh commit+push
  → every 2 loops: CURRENT + Engram helper:session_handoff_latest
```

**On wake:** Engram `session_start` → read CURRENT + plan → continue next open item.

## Open polish

1. ~~Gallery window exteriors green/sky~~ **DONE loop 65**  
2. ~~Oil-lamp mesh heroes~~ **DONE** freestanding `oil_lamp` + sconces  
3. ~~Machine silhouette~~ **DONE** spiral bars + bracket  
4. ~~E-door structural~~ **DONE** (interactive play still best-effort / env limit)  

Optional residual: dedicated window close-up camera angle; in-game E playtest when human available.

## Paths

- Novel: `LORE/novel/New_Draft_Aetheric_Engine_March_2026.txt`  
- Plan: `SCRATCH/memory/visual-deveraux-house-plan-interior-design.md`  
- Shots: `SCRATCH/screenshots/auto_loop_61`…`65`  
