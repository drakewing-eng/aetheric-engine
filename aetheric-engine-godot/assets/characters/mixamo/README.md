# Mixamo activity clips

Drop zone for realistic **idle / walk / sit** clips used by Bell’s skeletal runtime
(and any future Mixamo-rigged NPC).

## Sources (your downloads)

Copy from the playground folder:

```
playground/Mixamo downloads/
  Start Walking.fbx
  Idle.fbx
  Standing Idle.fbx
  Sitting Idle.fbx
```

into:

```
assets/characters/mixamo/source/
  start_walking.fbx
  idle.fbx
  standing_idle.fbx
  sitting_idle.fbx
```

Or run:

```bash
./assets/characters/models/bell/pipeline/sync_mixamo.sh
```

## Bake

After Godot has imported the FBX files once:

```bash
Godot --headless --path . --script res://scripts/bake_mixamo_clips.gd
```

Produces:

```
assets/characters/mixamo/mixamo_activity_clips.res
```

with exact clip names: **`idle`**, **`walk`**, **`sit`**.

## Runtime

`bell_runtime.gd` loads that library first, remaps bone tracks onto the production
skeleton, and falls back to `final/bell.glb` native clips, then procedural keys.

Root **position** tracks on Hips are stripped so NavigationAgent owns movement.

## Clip map

| Activity | Mixamo source (preferred) |
|----------|---------------------------|
| Idle / Talk / Read / WorkMachine (standing) | Standing Idle → Idle |
| Walk | Start Walking |
| Sit | Sitting Idle |

## License note

Mixamo animations are free for use with Adobe’s terms; keep originals under
`source/` for re-bake only — do not re-sell the raw FBX as standalone assets.
