# NPC life: Oblivion → Aetheric billboards (2026-08-03)

## Oblivion layers
1. **AI packages + schedules** — Travel/Wander/Eat/Sleep/UseItem; one package active; designers set goals.
2. **Skeletal animation** — continuous idle loops, walk, activity clips (never a single frozen still).
3. **Look-at / attention** — head (and sometimes torso) tracks player/conversation partner.

## Our constraint
FIXED_Y full-body sprites (`fps_npc.gd`). No bones → no true head IK.

## Mapping
| Oblivion | Us |
|----------|-----|
| Idle loop | Idle frames + procedural breath/sway |
| Head look-at | Root/body yaw toward player; optional glance textures |
| Wander | Patrol + dwell jitter + micro-pause |
| Walk | Per-NPC walk_0..3 (Bell done; others pending) |
| Activity idle | Optional later (book, letter) |

## Phase order
1. Code life for all NPCs (breath, attend, fidget timer)
2. Idle art cycles
3. Walk for all patrol NPCs
4. Polish

Full plan: session plan.md / goal/plan.md — goal:aetheric_npc_life_motion
