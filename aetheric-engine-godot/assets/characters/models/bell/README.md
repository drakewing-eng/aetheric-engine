# Bell 3D model

## Phase 1 (current)
- `humanoid_stub.glb` — Khronos glTF-Sample **CesiumMan** (skeleton + walk animation).
- Used as a **scaffold** so patrol, facing, look-at, and talk states work in-engine.
- Victorian dark tint applied at runtime (`tint_victorian`).

## Phase 2+
Replace with a Bell-identity humanoid (coat, hair, book) that keeps:
- Skeleton3D
- AnimationPlayer clips ideally named `idle` / `walk` / `sit` (or first clip used as walk)

Path stays: `res://assets/characters/models/bell/`  
NPC data: `"model": "res://assets/characters/models/bell/<file>.glb"`

## License
CesiumMan is from Khronos glTF-Sample-Models (see upstream repo license).
