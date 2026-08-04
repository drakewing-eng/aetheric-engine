# Bell 3D character

## Runtime (now)
| Asset | Role |
|-------|------|
| **`bell_character.tscn` + `.gd`** | **Procedural placeholder only** — stylized silhouette (long coat, hair mass, stern face, book, idle/walk/sit) |
| `humanoid_stub.glb` | Legacy CesiumMan — **do not use** for Bell identity |

Drawing Room: `"model": "res://assets/characters/models/bell/bell_character.tscn"`

## Art direction & pipeline
| Doc | Purpose |
|-----|---------|
| `ART_DIRECTION.md` | Stylized-realist lock (Oblivion-readable at game distance, **not** MetaHuman), landmarks, materials |
| `GLB_CONTRACT.md` | Drop-in GLB: `idle`/`walk`/`sit`, feet y=0, +Z forward, material slots |
| `BLENDER_BRIEF.md` | Concrete Blender / commission steps for final mesh |
| `turnaround_board.png` | Front + silhouette study from `sprite_bell` |
| `final/` | Production `bell.glb` goes here |

## Honest completion boundary
**This placeholder does not claim painted-sprite parity or Oblivion-quality likeness.**  
Reference-matching “complete” requires a **skinned GLB** under `final/` per `GLB_CONTRACT.md`.  
Infinite procedural box polish is out of scope.

## Highest-leverage next action
**Produce `final/bell.glb`** (author or commission — see `BLENDER_BRIEF.md`), then set room data:

```gdscript
"model": "res://assets/characters/models/bell/final/bell.glb",
"tint_victorian": false,
"height": 1.78,
```

Controller already plays `idle`/`walk`/`sit` and plants feet. No architecture change required.
