# NPC animation style — DECISION (2026-08-03)

## Decision: **Option 1 — 3D skeletal characters**

**Status:** Chosen by user. Cutouts are **placeholder only**, not the end state.

### Why
User wants Oblivion-like life: talk, walk circuits, sit, work, read. FIXED_Y cutouts cannot do real facing, sit/work transitions, or head look-at without paper-plane hacks.

### Non-goals of the old path
- Investing further in perfect FIXED_Y walk thrash
- Billboard-off yaw / fake 3D on single PNG
- Multi-angle 2D sheets as long-term target (Option 2 rejected for now)

### Target capabilities
1. **Locomotion** — walk (later run) along circuits; face travel direction  
2. **Idle** — continuous breathing / weight shift (animation, not Y-bob sprite)  
3. **Activities** — sit, read, work-at-bench (clips or simple state poses)  
4. **Attention** — head/torso look-at player when near / in dialogue  
5. **Talk** — face player; optional gesture later  
6. **Behavior** — simple packages: WanderCircuit → Idle → SitRead / Work → Talk interrupt  

### Current code (transitional)
- `fps_npc.gd`: FIXED_Y billboard + optional walk frames + tiny procedural breath  
- Keep working until 3D path renders; do **not** expand cutout art pipeline  
- When 3D Bell ships, billboard path becomes fallback for NPCs without a mesh  

### Phased plan (see plan section below)
1. Prototype **one** 3D character (Bell) end-to-end  
2. State machine shared by cutout and 3D  
3. Roll out cast  
4. Activity furniture markers (chairs, benches)  

Full plan: session `goal/plan.md` / `plan.md` for `goal:aetheric_npc_life_motion` (updated).
