# Bell 3D character

## Runtime (now)
| Asset | Role |
|-------|------|
| **`bell_character.tscn` + `.gd`** | Improved **procedural placeholder** — longer coat, hair mass, stern face, book, idle/walk/sit |
| `humanoid_stub.glb` | Legacy CesiumMan — **do not use** for Bell identity |

Drawing Room: `"model": "res://assets/characters/models/bell/bell_character.tscn"`

## Art direction & pipeline
| Doc | Purpose |
|-----|---------|
| `ART_DIRECTION.md` | Stylized-realist lock, orthos, materials |
| `GLB_CONTRACT.md` | Drop-in GLB requirements for Godot |
| `BLENDER_BRIEF.md` | Steps / commission brief for final mesh |
| `final/` | Put production `bell.glb` here |

## Highest-leverage next step
**Author or commission a skinned GLB** (see `BLENDER_BRIEF.md`) and drop into `final/bell.glb`. Controller already supports clip names + plant. Procedural mesh is only a silhouette scaffold.
