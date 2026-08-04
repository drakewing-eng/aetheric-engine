# Bell GLB drop-in contract

When a real character is ready, place it here and point room data at it.

## Paths

```
assets/characters/models/bell/
  ART_DIRECTION.md          # fidelity bar + proportions
  GLB_CONTRACT.md           # this file
  bell_character.tscn       # procedural placeholder (current runtime)
  bell_character.gd
  humanoid_stub.glb         # legacy scaffold only — do not use for Bell identity
  final/                    # production asset lives here
    bell.glb                # preferred production mesh
    bell.glb.import         # Godot import (see settings below)
    textures/               # optional external maps
      coat_albedo.png
      skin_albedo.png
      hair_albedo.png
      ...
```

## Room data

```gdscript
"model": "res://assets/characters/models/bell/final/bell.glb",
"tint_victorian": false,
"height": 1.78,
```

Or keep `bell_character.tscn` until GLB is validated.

## Scene requirements

| Requirement | Spec |
|-------------|------|
| Root | Single root `Node3D`; feet at **y = 0** |
| Height | ~1.78 m before NPC scale (or set meta `native_height`) |
| Forward | Character faces **+Z** (matches `fps_npc` yaw) |
| Skeleton | `Skeleton3D` humanoid; head/neck bone containing `"head"` or `"neck"` for look-at |
| Animations | `AnimationPlayer` with clips named exactly: **`idle`**, **`walk`**, **`sit`** (loop idle+walk) |
| Materials | Named slots matching ART_DIRECTION (coat, vest, shirt, trousers, skin, hair, boot, book) |
| Scale | 1 unit = 1 meter |

## Godot import (`.glb.import` guidance)

After first import, ensure:

- **Meshes → Ensure Tangents:** On (if normal maps)  
- **Animation → Import:** On; FPS 30  
- **Skeleton → Rest pose:** Use rest from file  
- **Materials → Storage:** Files if external textures  

Controller (`fps_npc.gd`) will:

1. Instance the scene  
2. Scale by `height / native_height` if meta present  
3. Plant feet via AABB  
4. Play `idle` / `walk` / `sit` by name  

## Validation checklist

- [ ] Headless: loads as PackedScene  
- [ ] Clips: idle, walk, sit  
- [ ] After setup, mesh bottom y ≈ 0  
- [ ] Height span ~1.5–2.1 m at height 1.78  
- [ ] No FaceCard / cutout body for Bell  
- [ ] Drawing Room play: silhouette reads as Victorian gentleman  

## Naming

Prefer exact clip names. Aliases the controller already accepts as fallbacks: names containing `walk`/`run`, `idle`/`stand`.  
