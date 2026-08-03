# Bell 3D model

## Current (custom)
- **`bell_character.tscn` + `bell_character.gd`** — stylized Victorian gentleman built to match
  `sprite_bell` palette (charcoal coat, grey hair, vest, book, stern face).
- AnimationPlayer clips: **`idle`**, **`walk`**, **`sit`** (articulated limbs, not CesiumMan).
- Wired in Drawing Room via `"model": "res://assets/characters/models/bell/bell_character.tscn"`.

## Legacy
- `humanoid_stub.glb` — CesiumMan scaffold (kept only as fallback). Do not use for Bell identity.

## Later upgrades
- Higher-detail sculpted mesh / textured GLB can replace the scene; keep clip names `idle`/`walk`/`sit`.
