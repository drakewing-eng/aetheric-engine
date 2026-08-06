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

## Honest completion boundary
**Current production mesh does not claim full painted-sprite / desk-illustration parity.**  
It is a skinned humanoid with Victorian silhouette props (coat/hair/book), correct height/plant/clips — **not** the stern Bell face of the portrait, and **not** a box puppet.  
Full likeness still needs artist face sculpt + tailored frock/textures (see `BLENDER_BRIEF.md`).

## Highest-leverage next action
Author or commission a likeness-matching `final/bell.glb` (face + coat textures per `ART_DIRECTION.md`), replace the Xbot-based export, keep `bell_runtime` plant/clip path.
