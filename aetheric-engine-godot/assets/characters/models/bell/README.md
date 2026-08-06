# Bell 3D character

## Reference → GLB pipeline

```bash
./assets/characters/models/bell/pipeline/run_pipeline.sh
# optional: MESHY_API_KEY=... BELL_I2_BACKEND=meshy ./pipeline/run_pipeline.sh
```

See `pipeline/README.md`. Stages: prepare sheet → image-to-mesh (Meshy / HF / projection) → Blender plant+clips → install `final/bell.glb`.

## Runtime (Drawing Room)
| Asset | Role |
|-------|------|
| **`final/bell_runtime.tscn` + `.gd`** | **Production loader** — skinned `final/bell.glb`, plant/scale, idle/walk/sit |
| **`final/bell.glb`** | Pipeline output (reference-driven mesh + idle/walk/sit) |
| `pipeline/` | Automated reference→GLB tooling |
| `bell_character.tscn` + `.gd` | Procedural **placeholder only** — not the intended final body |
| `humanoid_stub.glb` | Legacy CesiumMan — **do not use** for Bell identity |

Room data:
```gdscript
"model": "res://assets/characters/models/bell/final/bell_runtime.tscn",
"tint_victorian": false,
"height": 1.78,
```

## Art direction & pipeline
| Doc | Purpose |
|-----|---------|
| `ART_DIRECTION.md` | Stylized-realist lock (Oblivion-readable, **not** MetaHuman); desk illustration + sprite are likeness sources |
| `GLB_CONTRACT.md` | Drop-in GLB: `idle`/`walk`/`sit`, feet y=0, +Z forward, material slots |
| `BLENDER_BRIEF.md` | Blender / commission steps for true likeness mesh |
| `turnaround_board.png` | Front + silhouette study from `sprite_bell` |
| `final/` | Production GLB + runtime scene |

## Phase: skeleton-first (current)

`bell_runtime.gd` sets **`SKELETON_FIRST := true`**.

| Do | Don't |
|----|--------|
| Skinned humanoid body only | Projected face sheet / portrait albedo |
| Flat grey mannequin materials | Coat cylinder / hair sphere prop shells |
| Native idle / walk / sit on this armature | Raw foreign Mixamo FBX (explodes mesh) |
| Judge motion, plant, height | Claim likeness / Victorian costume |

You should **not** see Bell's painted face until we deliberately exit skeleton-first and drop a likeness GLB.

## Honest completion boundary
**Current production path does not claim painted-sprite / desk-illustration parity.**  
Skeleton-first mannequin ≠ finished character. Motion and plant are the gate.  
Likeness (stern desk-illustration face, frock coat) is a later `final/bell.glb` replace — see `BLENDER_BRIEF.md` + `ART_DIRECTION.md`.

## Highest-leverage next action
1. Confirm idle/walk/sit look correct on the grey mannequin in Drawing Room.  
2. Only then: author likeness `final/bell.glb` and set `SKELETON_FIRST := false` in `bell_runtime.gd`.
