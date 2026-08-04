# Commission / Blender brief — Final Ignatius Bell

**Role:** Replace procedural placeholder with skinned GLB matching painted reference.  
**Engine:** Godot 4.5 · drop-in per `GLB_CONTRACT.md`  
**Fidelity:** Stylized realist (Oblivion game-distance), **not** MetaHuman.  

## Reference package (give to artist)

1. `assets/characters/sprites/sprite_bell.png` — full body hero  
2. `assets/portraits/portrait_bell.jpg` — face close  
3. `ART_DIRECTION.md` — proportions + material slots  
4. Optional in-game screenshots of current placeholder for scale in rooms  

## Deliverables

| File | Notes |
|------|--------|
| `final/bell.glb` | Single export: mesh + skeleton + animations |
| Textures | 2K preferred: coat, skin, hair, trousers, book (PNG) |
| Turnaround PNG | Front / side / back orthos for review |

## Blender steps (concrete)

1. **Blockout** — Man ~1.78 m; match ART_DIRECTION landmarks (coat hem ~0.5 height, hair crown ~1.02).  
2. **Sculpt / model**  
   - Long frock coat with rear tails and hem thickness  
   - Vest, shirt, cravat, pinstripe trousers, boots  
   - Head: gaunt, deep brows, intense eyes  
   - Hair: high volume, greying strands (particle or mesh cards OK at distance)  
   - Book prop in left hand (or weighted to hand bone)  
3. **Retopo / UVs** — Game topology ~15–40k tris; clean UVs per material slot.  
4. **Texture** — Wool charcoal coat, warm skin, steel hair; slight wear on coat hem.  
5. **Rig** — Humanoid (Rigify or Mixamo-compatible). Bones: hips, spine, neck, head, arms, legs.  
6. **Weight paint** — Coat should deform; avoid candy-wrapper shoulders.  
7. **Animate** (or retarget then polish)  
   - `idle` loop — weight shift, subtle breath, no float  
   - `walk` loop — clear foot contacts, ~0.8–1.0 s cycle  
   - `sit` — sit-down or seated pose usable as hold  
8. **Export GLB** — +Y up, +Z forward, apply scale, animations included, feet on origin.  
9. **Godot** — Place at `final/bell.glb`; set room `"model"` path; playtest Drawing Room.  

## Acceptance (artist + engineer)

- [ ] Reads as same man as sprite at 3–6 m (hair + coat + stern face)  
- [ ] Feet on floor; height ~1.78 m  
- [ ] Clips named `idle` / `walk` / `sit`  
- [ ] No floating billboard face  
- [ ] `test_npc_skeletal.gd` still green after path swap  

## Out of scope for this asset

Player mesh, other NPCs, full cloth sim, facial blendshapes (unless cheap).  
