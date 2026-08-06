# Bell reference → GLB pipeline

Turns painted/illustrated Bell references into a Godot-ready `final/bell.glb`.

## Flow

```
input/ refs (desk, sprite, portrait)
   │
   ├─ 01_prepare_sheet   → work/bell_fullbody_front.jpg (+ side/back)
   ├─ 02_image_to_mesh   → work/bell_i2_3d.glb  (backends below)
   ├─ 03_postprocess     → work/bell_rigged.glb (scale 1.78, plant, idle/walk/sit)
   └─ 04_install         → final/bell.glb + runtime path
```

## Image → mesh backends (`02_image_to_mesh.py`)

| Backend | How | Notes |
|---------|-----|--------|
| `hf_hunyuan` | HuggingFace Space `tencent/Hunyuan3D-2*` | Free GPU quota; often busy |
| `hf_sf3d` | `stabilityai/stable-fast-3d` | Free; flaky |
| `meshy` | `MESHY_API_KEY` env | Paid/free trial; best quality |
| `projection` | Local Blender + fullbody sheet | Always available; skinned walk |

Default: try cloud backends in order, fall back to **projection**.

## Run

```bash
# Full pipeline (from Godot project root or pipeline/)
./assets/characters/models/bell/pipeline/run_pipeline.sh

# Or step by step:
python3 01_prepare_sheet.py   # uses existing Imagine sheets if present
python3 02_image_to_mesh.py   # MESHY_API_KEY=... optional
python3 03_postprocess.py     # needs Blender
python3 04_install.py
```

## Env

| Variable | Purpose |
|----------|---------|
| `MESHY_API_KEY` | Meshy image-to-3D |
| `BELL_BLENDER` | Path to Blender binary |
| `BELL_I2_BACKEND` | Force: `meshy`, `hf_hunyuan`, `hf_sf3d`, `projection` |

## Acceptance (GLB_CONTRACT)

- Feet ≈ y=0, height ~1.78 m  
- Clips: `idle`, `walk`, `sit`  
- Skinned mesh preferred  
- Room already points at `final/bell_runtime.tscn`  
