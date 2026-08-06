# User action required — Bell likeness hard blocker

Automated tools exhausted (Blender headless v2–v4, free humanoids, retexture).
**Stern desk-art face + tailored frock cannot be closed without artist input.**

## Option A (preferred): drop production GLB

Place artist-authored file:

```
assets/characters/models/bell/final/bell.glb
```

Requirements (`GLB_CONTRACT.md` / `BLENDER_BRIEF.md`):
- Skinned humanoid, stylized-realist (not MetaHuman)
- Wild greying hair, stern furrowed face (desk illustration)
- Long dark Victorian coat, book OK
- Named clips: `idle`, `walk`, `sit` (loop idle+walk)
- Feet at y≈0, height ~1.78 m, +Z forward
- Then tell agent to re-run verification

## Option B: sculpt in Blender GUI

1. Open workspace:
   ```
   open assets/characters/models/bell/final/bell_sculpt_workspace.blend
   ```
   (or open `Blender.app` from the session SCRATCH if needed)
2. References loaded as image empties: sprite, portrait, turnaround.
3. Sculpt face + coat + hair; export **File → Export → glTF 2.0** as `final/bell.glb`
4. Keep/export animations named `idle` / `walk` / `sit`
5. Tell agent to re-verify

## Already green (do not break)

- `bell_runtime.tscn` plant / height / clips
- Drawing Room model path
- `test_npc_skeletal.gd` ALL PASS on systems path
