# Ignatius Bell — Art Direction Lock (stylized realist)

**Fidelity bar:** Oblivion-class *game-distance* readability — not MetaHuman photoreal.  
**Likeness sources (priority):**
1. Desk illustration / study (stern intensity, wild greying hair, dark coat under lamp) — primary face & mood  
2. `assets/characters/sprites/sprite_bell.png` — full-body coat hem/tails, book, stance, palette  
3. `assets/portraits/portrait_bell.jpg` — face backup (same stern scholarly detective)  
4. `turnaround_board.png` — front + silhouette landmarks  

**Height:** 1.78 m · **Facing:** +Z forward · **Feet:** y = 0  

## Pillars (must read at ~3–6 m)

1. **Hair mass** — wild, high, greying volume; inverted-V crown wider than skull; not a helmet sphere  
2. **Stern face** — deep brow ridge, dark sockets, gaunt cheeks, furrowed intensity (desk art)  
3. **Coat weight** — long dark Victorian frock, heavy hem, rear tails  
4. **Scholar detective** — book at chest, watch chain, upright posture  
5. **Palette** — charcoal coat, charcoal/grey trousers, warm skin, steel hair  

## Ortho proportions (normalized height = 1.0)

| Landmark | Y (from feet) | Notes |
|----------|---------------|--------|
| Boot sole | 0.00 | Plant on floor |
| Knee | ~0.28 | Slim leg |
| Hip / coat hem | ~0.48–0.52 | Coat reaches mid-thigh to knee |
| Waist / vest bottom | ~0.58 | Slight taper under coat |
| Chest / book | ~0.72–0.78 | Book held left of center |
| Shoulder | ~0.82 | Broad, coat bulk |
| Chin | ~0.88 | Gaunt jaw |
| Brow / eyes | ~0.93 | Furrowed, deep-set |
| Hair crown | ~1.00–1.06 | Volume above skull |

### Front silhouette
- Inverted-V hair crown, wider than skull  
- Shoulders wider than hips  
- Coat opens slightly over vest + white shirt strip + dark cravat  
- Coat skirt flares past hips; tails hang rear  

### Side silhouette
- Coat hem and tails extend back  
- Book protrudes forward from torso  
- Hair mass over forehead and nape  
- Lean forward presence (subtle), not hunch  

### Back silhouette
- Coat filled; tails split  
- Hair mass still readable  

## Material slots (final GLB)

| Slot | Albedo intent | Roughness |
|------|----------------|-----------|
| `mat_coat` | #171618 charcoal wool | 0.85–0.92 |
| `mat_vest` | #4A4540 brown-grey | 0.80 |
| `mat_shirt` | #E6E2D8 off-white | 0.75 |
| `mat_trousers` | #332F32 dark pinstripe base | 0.88 |
| `mat_skin` | #BD997F warm gaunt | 0.65 |
| `mat_hair` | #6B686C steel grey | 0.70 |
| `mat_boot` | #0D0C0C black leather | 0.45 |
| `mat_book` | #734C29 brown leather | 0.75 |
| `mat_metal` | #C0A35C chain gold | 0.35 metallic |

## Non-goals
- Photoreal pores / eye shader / MetaHuman  
- Face-card billboard hacks  
- Changing NPC AI / rooms  

## Runtime status
- **Production path:** `final/bell.glb` + `final/bell_runtime.tscn` (skinned base + silhouette props)  
- **Still open for full likeness:** stern face sculpt/texture and tailored frock matching desk art — see README honest boundary  
