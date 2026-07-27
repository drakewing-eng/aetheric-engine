# Aetheric Engine — project memory index

**Purpose:** Thin, git-tracked memory tree so agents rehydrate without replaying long transcripts.  
**Does not replace Engram.** Engram finds the handoff; this tree holds reviewable truth.

## Wake sequence (every new session)

1. **Engram** `session_start` → read concepts listed in [CURRENT.md](CURRENT.md)
2. **Read** [CURRENT.md](CURRENT.md) (one screen)
3. **Then** only the topic files needed for the task
4. **Code** as linked under [architecture/](architecture/)

## Layout

```
SCRATCH/memory/
  INDEX.md              ← you are here
  CURRENT.md            ← open work + status (update often)
  engram-bridge.md      ← Engram concepts ↔ files map
  visual/
    open-bugs.md        ← playtest priorities
    uniqueness-rule.md  ← object identity rule
    loop-history.md     ← 7h unattended loop pointer (not full log)
  architecture/
    fps-visual.md       ← rooms/props/builder entry points
```

## Related SCRATCH docs (canonical long form)

| Doc | Role |
|-----|------|
| [../NEXT_SESSION_VISUAL_PROMPT.md](../NEXT_SESSION_VISUAL_PROMPT.md) | Full next-session implementation brief |
| [../DREAM_AETHERIC_VISUAL_2026-07-27.md](../DREAM_AETHERIC_VISUAL_2026-07-27.md) | Dream consolidation of visual arc |
| [../VISUAL_LOOP_7H_SUMMARY.md](../VISUAL_LOOP_7H_SUMMARY.md) | Stopped 10m unattended loop summary |
| [../VISUAL_LOOP_AUTONOMOUS.md](../VISUAL_LOOP_AUTONOMOUS.md) | Autonomous loop protocol (if used again) |

## Maintenance rules

- Keep **CURRENT.md** short (≤ ~40 lines). Put depth in topic files or the SCRATCH docs above.
- After meaningful work: update CURRENT.md + Engram `helper:session_handoff_latest` (or batch_remember).
- Do **not** dump every `auto_loop_N` into markdown.
- Do **not** re-enable 10-minute unattended visual scheduler unless the user asks.
