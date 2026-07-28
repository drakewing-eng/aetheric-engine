# Visual Deveraux House Plan — Interior Design

**Status:** Research + plan only (no game implementation yet)  
**Created:** 2026-07-27  
**Primary goal:** `goal:aetheric_deveraux_interior_plan`  
**Novel source:** `LORE/novel/New_Draft_Aetheric_Engine_March_2026.txt`  
**Floor plan companion:** `Previous Aetheric Engine Project/RICHMOND_HOUSE_FLOOR_PLAN.md`  
**Simulation scope:** the seven rooms in `fps_rooms.gd` only  

| Sim room ID | Novel / house name |
|-------------|-------------------|
| `drawing_room` | Drawing room / parlour (formal reception) |
| `entrance_hall` | Entrance hall |
| `gallery` | Long room / Gallery (experimental chamber) |
| `morning_room` | Morning room (east light; lightly specified in novel) |
| `workshop` | Workshop / coach-house work domain (Rooke) |
| `conservatory` | Conservatory (glass, plants, Rooke–gallery route) |
| `kitchen` | Kitchen + pantry/scullery adjacency (Keene/Clara) |

**Out of scope for this plan:** upper bedrooms, cellar, dining room, butler’s pantry as separate scenes (novel/floor-plan real; not in current FPS sim).

---

## 0. Method: how this research was done (and how to go deeper later)

### Best way to deep-dive (what we used)

| Layer | Source | Role |
|-------|--------|------|
| **A. Novel-first** | Full draft (~7.4k lines): room phrases, objects, tone quotes | Canon — if novel and period clash, **novel wins** |
| **B. House topology** | Floor plan derived from draft | Who walks where; workshop–conservatory–gallery adjacency |
| **C. Period England ~1856** | Mid-Victorian domestic planning (e.g. Kerr *The Gentleman’s House*, 1864, describes the same generation of houses); drawing-room inventories of the 1840–70 band; service-wing practice | Plausibility for furniture types and materials |
| **D. Scientific workspaces** | Mid-century instrument culture: copper coils, brass fittings, glass, ledgers, oil lamps | Gallery + workshop authenticity without steampunk excess |
| **E. Sim reality check** | Current `fps_rooms` room list | Only plan what can be built |

### Should this be a **goal** or a **loop**?

**Goal, not visual loops.**

| Approach | Use when |
|----------|----------|
| **Engram goal** (this work) | Research, bible, approval, handoff — multi-session continuity |
| **Visual loops** | Only **after** you approve this plan and issue an implement prompt |

Recommended goal tree:

```
goal:aetheric_deveraux_interior_plan          ← this document
  ├─ novel_on_private_github                  (done with LORE/novel)
  ├─ room_inventories_novel_true              (this doc)
  ├─ user_approval                            (waiting)
  └─ implement_visual_pass_N                  (your future prompt → loops)
```

**Do not** open-ended density loops without this bible; that is what produced identical shelves and room-photo “paintings.”

---

## 1. Novel-true tone (north star)

### House character (direct from draft)

- **“Nothing ornamental about her attentions; everything seems arranged for use rather than display.”** (Amara on Selina / the house)
- **Precise, tidy order — not severe** (Rooke: boots reluctant to make noise on the stairs)
- **Quiet that listens** — rooms hold sound rather than echo (long room / gallery)
- **Working household of inquiry** — not a museum, not a country palace, not a poverty cottage
- **Summer–autumn 1856 reconstruction** for play: living experiment period; degradation (ozone in hall runner, sulfur in curtains, tarnish) is texture, not full collapse (except coach-house aftermath lore)

### Visual implications (rules)

1. **Use over display** — every prop earns a story or period-function reason.  
2. **Restraint in public rooms** — drawing room is formal but not stuffed with Victoriana kitsch.  
3. **Instruments are the decoration** in gallery/workshop — not salon clutter.  
4. **Service spaces are warm and wet/work-scented** — kitchen real, not “period kitchen as shop set.”  
5. **Materials hierarchy** — oak + copper + brass dominate work; mahogany/velvet only where reception requires; pine for packing; scrubbed wood for prep.  
6. **Avoid late-Victorian excess** — Morris wallpapers, Aesthetic Movement clutter are **post-1856 peak**; keep mid-century: gilt oils, damask/floral papers, oil lamps, heavy chairs.

### Material frequencies (novel signals)

| Material / object | Approx. novel presence | Visual weight |
|-------------------|------------------------|---------------|
| Lamps | very high | Primary light story |
| Ink / notebooks / ledgers | very high | Desks, paper, Bell’s fingers |
| Brass / copper / coils | high | Gallery + workshop heroes |
| Glass (tubes, chimneys, panes) | high | Lamps, instruments, conservatory |
| Oak (frame, base, benches) | key but sparse | Machine + work surfaces |
| Hall runner + ozone | late-story key | Hall atmosphere |
| Mahogany / velvet / carpet | rare or absent as words | Use period norms lightly; don’t invent luxury the novel never claims |

---

## 2. Period research brief (~1856 England, Surrey working manor)

### Social placement

Richmond House is a **mid-Victorian country residence of the “better sort” but not a palace**: principal rooms + service wing + coach-house workshop (aligns with floor plan and Kerr-era planning: clear separation of public, private, service, and working spaces).

### Drawing room / parlour (1840–70 band)

Typical contents: sofa / lounge, lady’s and gentleman’s easy chairs, upright chairs, **ottoman**, occasional tables, **ladies’ writing desk**, centre table sometimes, **chimney glass** (overmantel mirror), carpet, fireplace tools, oil lamps, **gilt-framed oils** (landscapes, portraits, still life), drapery, cushions, writing/sewing workboxes.  

**Novel-true filter:** keep the reception suite; cut wax fruit, stuffed animals, fern cases, stereopticons unless a character beat needs them. Selina’s house is not a collector’s cabinet.

### Entrance hall

Hall stand or hooks, **hall table** (polished — Clara’s mother polishes it), hall chairs, card tray, runner, subdued wall colour so it does not compete with rooms, lamps.  

**Novel-true:** ozone later trapped in the **hall runner**; heat and low-trimmed lamps in crisis beats.

### Kitchen / service

Range, prep table (scrubbed wood), dresser/plate rack, copper, crocks, sink, scullery wet work, pantry for stores, lamp chimneys to clean, cold apples on the table, flour, dish towels. **No library bookshelves.**

### Scientific / instrument room (gallery)

Not a modern lab. Mid-century experimental culture: **wood base, copper coils, brass fittings, glass, tuning forks, ledgers, diagrams, oil lamps**, high windows, dust from fittings. Acoustics matter: high ceiling, soft rebound.

### Workshop / coach-house

Heavy bench, tools (wrench as character prop for Rooke), copper stock, smoke from the roof in winter, path from back door, adjacency to conservatory; late lore: vaporized copper, ozone, scorched varnish (use sparingly in “live 1856” rebuild — more after-collapse than summer working season).

---

## 3. Room-by-room visual inventory (simulation)

Legend:  
- **MUST** — novel-named or strongly implied  
- **SHOULD** — period-correct and supports novel tone  
- **MAY** — optional if density needed  
- **NEVER** — fights novel or confuses reads (e.g. room-photo paintings)

### 3.1 Drawing room (`drawing_room`)

**Novel role:** Formal reception; Selina holds letters/packets; visitors shown in; Elspeth wanders; tea-tray at four; parlour cloth crumbs; not the work room.

| Category | MUST | SHOULD | NEVER |
|----------|------|--------|-------|
| Furniture | Sofa / lounge; at least one writing surface for letters; chairs | Ottoman, side tables, modest bookcase (few volumes), fireplace | Dense clutter stacks; identical “hero” still-lifes cloned |
| Walls | Fireplace; windows | Gilt landscape oil(s); overmantel **mirror** (silvered); soft curtains | Room photographs as art; workshop copper as décor |
| Soft | Carpet / rug | Damask or floral paper + wainscot (mid-century) | Pure white modern walls |
| Props | Letter / vellum packet as hero prop | Tea tray, pen tray, sealed letters, small lamp | Scientific coils (those belong in gallery) |
| Wood | Mahogany or polished dark wood for reception furniture | — | Scrubbed kitchen pine for sofa frames |

**Character occupancy:** Selina (letters), Elspeth, visitors; Bell sometimes shown into the room.

---

### 3.2 Entrance hall (`entrance_hall`)

**Novel role:** Threshold; hall table polished; Bell speaks with Mrs Deveraux; runner later holds **ozone**; lamps; front door.

| Category | MUST | SHOULD | NEVER |
|----------|------|--------|-------|
| Furniture | Hall table | Coat stand / hooks, 1–2 hall chairs, umbrella stand | Drawing-room sofa suite |
| Floor | Runner | Stone/wood threshold | Kitchen tiles as hall floor |
| Walls | Subdued | 0–2 sober prints or one landscape; sconces | Picture gallery density |
| Props | — | Calling-card tray, gloves, lamp | Machine parts, coils |
| Atmosphere | Quiet, precise | Slight late-story ozone/tarnish option | Festival clutter |

---

### 3.3 Gallery / long room (`gallery`)

**Novel role:** Heart of the experiment. Quiet, well lit, high ceilings, sound does not rebound too quickly. Machine where the great table once stood. Oak + copper frame ~7–8′; three concentric coils; south bracket; brass fittings; lamps; ledgers; desk for notes; dust from fittings; sulfur smell settles into curtains (crates/unpacking). Bell, Amara, Rooke work here; Elspeth sometimes listens.

| Category | MUST | SHOULD | NEVER |
|----------|------|--------|-------|
| Hero | **Aetheric Engine**: square **oak** base, **copper** bands/coils (counter-wound spirals), brass fittings, height ~7′+ | South bracket as interactable visual; warm copper | Steampunk random pipes without coil logic |
| Furniture | Work desk / ledger desk; seating for observation | Stools/benches; remnant of “great table” scale as clear floor for machine | Drawing-room chesterfield as main furniture |
| Instruments | Copper coils, prism, harmonic frame language | Tuning forks, glass tubes/cylinders, diaphragm plates, turn-keys, diagrams | Kitchen crockery as “lab props” |
| Paper | Ledger, notebooks, ink | Rolled diagrams (Bell carries these) | Wallpaper “art” of other rooms |
| Light | Oil lamps (trim/warmth beats) | Cool south window light | Nightclub neon |
| Walls | High windows; curtains (absorb sound + hold odor lore) | Minimal or no salon oils | Dense gilt painting hang |
| Atmosphere | Listening quiet; dust; heat from brass | Subtle sulfur/ozone after hard runs | Coach-house collapse as default look |

**Acoustics (visual proxy):** soft materials + height; avoid hard empty box with loud reverb feel.

---

### 3.4 Morning room (`morning_room`)

**Novel role:** Floor plan: east-facing, breakfast light, less formal than drawing room; Elspeth sometimes. Draft text barely names “morning room” — treat as **inferred novel-true** from floor plan + “use not display.”

| Category | MUST | SHOULD | NEVER |
|----------|------|--------|-------|
| Furniture | Small table or light desk; 2 chairs | One modest bookcase or work table; window seat if space | Full drawing-room suite |
| Light | Strong east window / garden or orchard suggestion | Simple curtains | Dark gallery mood |
| Art | 0–1 quiet landscape or botanical | — | Portrait gallery |
| Props | Copy-book / sewing / simple breakfast cues | Lamp | Coils and machine parts |

---

### 3.5 Workshop (`workshop`)

**Novel role:** Rooke’s domain. Path from back door; smoke from roof in winter; **particular bench**; chipped cup; wrench carried between conservatory and workshop; copper work; coach-house adjacency (sulfur/copper vapor in late lore).

| Category | MUST | SHOULD | NEVER |
|----------|------|--------|-------|
| Furniture | Heavy **oak** workbench(es) | Tool rack, stool, open shelving for parts | Mahogany salon chairs as main seating |
| Tools | Wrench (Rooke character prop) | Files, hammers, clamps, turn-keys, measuring tools | Fantasy plasma tools |
| Materials | Copper stock, brass fittings, scrap timber | Pine crates, oil can, lamp | Full Aetheric Engine (lives in gallery; coach-house collapse is lore) |
| Atmosphere | Craft, smoke suggestion, practical mess **in order** | Chalk notes / scale drawings | Drawing-room carpet |
| Art | None or technical drawings only | — | Gilt landscape oils |

**Note:** Engine “in the coach-house” appears in late/collapse framing; summer rebuild keeps **primary engine in gallery** per floor plan + most working letters. Workshop = fabrication support, not second machine showpiece.

---

### 3.6 Conservatory (`conservatory`)

**Novel role:** Warm and still; Rooke paces workshop↔conservatory; Bell crosses long room→conservatory with rolled diagram; brightness can hurt Amara’s eyes; glass.

| Category | MUST | SHOULD | NEVER |
|----------|------|--------|-------|
| Structure | Glass + iron/wood framing; outdoor greenery visible | Stone path / threshold to garden | Solid wallpaper box without glass read |
| Plants | Living greenery (warmth/stillness) | Palms/ferns moderate — not jungle | Fake plastic look |
| Furniture | Minimal — staging bench or iron chair | Rooke’s pacing clear path | Dense furniture blocking light |
| Props | — | Watering can, diagram-resting table | Full kitchen range |

---

### 3.7 Kitchen (`kitchen`)

**Novel role:** Clara/Keene domain. Warm; apples; pantry tiles wet; flour; lamp chimneys cleaned; kitchen window light through glass; dish towel; table elbows; scullery wet work nearby; service route toward long room.

| Category | MUST | SHOULD | NEVER |
|----------|------|--------|-------|
| Furniture | Range; prep table (**scrubbed** wood); dresser / plate rack; sink | Stools, side prep surface | Tall library bookshelves with novels |
| Props | Copper pans; crocks; lamp chimneys; cold apple; flour cues | Baskets, dish cloths, simple crockery | Scientific coils, ledgers as main décor |
| Walls | Service finish (paint/plaster, tall dado OK) | 0–1 cheap print | Salon gilt landscape hang |
| Light | Warm kitchen light + window | — | Gallery cool experimental light |

---

## 4. Cross-cutting systems

### 4.1 Wall hangings (global rules)

| Type | Must read as | Content |
|------|----------------|---------|
| **Painting** | Framed oil | Landscape (public rooms), still life (kitchen/service), rare portrait |
| **Mirror** | Silvered glass | Reflective material — **not** a photo of a room |
| **Window** | Outside | Garden, yard, orchard, soft street — **not** interior photo |
| **Diagram** | Working paper | Gallery/workshop only |

### 4.2 Wood hierarchy (global rules)

| Wood | Where |
|------|--------|
| Mahogany / polished dark | Drawing-room furniture, doors, hall table |
| Oak | Machine base, workbenches, substantial shelves in work contexts |
| Scrubbed pale | Kitchen prep tops, boards |
| Pine | Crates, rough packing |
| Brass / copper / iron | Instruments, fittings — never “wood-textured metal” |

### 4.3 Lighting story

- **Lamps** are the primary period light (novel frequency high).  
- Gallery: lamps + south window.  
- Hall: can be low-trimmed / hot in crisis beats.  
- Conservatory: daylight-dominant.  
- Avoid modern LED white as default.

### 4.4 Character → default room (for prop/NPC density)

| Character | Primary spaces |
|-----------|----------------|
| Selina | Drawing room, study (off-sim), hall |
| Bell | Gallery / long room, hall |
| Rooke | Gallery, workshop, conservatory path |
| Amara | Gallery desk, small room near back stair (off-sim) |
| Clara / Mrs Keene | Kitchen, pantry/scullery, hall service |
| Elspeth | Drawing/parlour, morning room, long room (listening), garden |

---

## 5. Gap analysis vs current simulation (planning only)

| Issue | Novel-true fix (when implementing) |
|-------|-------------------------------------|
| Room photos used as paintings | Landscape / still life / portrait only |
| Identical bookshelves in kitchen | Crockery / dresser language only |
| Same wood on all props | Species matrix above |
| Deep portal closets | Closed doors + E transition (already improved) |
| Gallery as generic dense room | Clear floor for engine; instrument density not furniture density |
| Workshop as second gallery | Tools + benches; no salon suite |
| Morning room under-specified | East light + lighter furniture set |

---

## 6. Implementation readiness (for your future prompt)

When you ask to implement, preferred order:

1. **Gallery** — machine accuracy (oak base, three counter-wound coils, south bracket) + desk/ledger/lamps  
2. **Workshop** — oak benches, copper, wrench, crates, drawings  
3. **Drawing room** — reception suite + letter props + correct wall hangings  
4. **Kitchen** — service-only identity  
5. **Entrance hall** — table, runner, restraint  
6. **Conservatory** — glass, plants, clear path  
7. **Morning room** — east light, light formality  

**Acceptance (per room):** screenshot pass + checklist against MUST table above; art pass remains green.

**Not in first implement unless you ask:** upper floor, dining room, cellar, coach-house collapse state as default.

---

## 7. Deliverables completed this research pass

| Deliverable | Location |
|-------------|----------|
| Novel in repo tree | `LORE/novel/New_Draft_Aetheric_Engine_March_2026.txt` |
| LORE index | `LORE/README.md` |
| This plan (new doc) | `SCRATCH/memory/visual-deveraux-house-plan-interior-design.md` |
| Engram goal | `goal:aetheric_deveraux_interior_plan` |

**Explicitly not done:** Godot code edits, visual loops, prop mesh changes.

---

## 8. Open questions for you (before implement)

1. **Timeline skin:** always “live experiment summer 1856,” or optional late “ozone/sulfur” overlay?  
2. **Machine location lock:** gallery-primary confirmed for play (recommended)?  
3. **Art quality:** keep procedural landscapes or commission/photo-real period-looking plates later?  
4. **Approve this bible** → then issue implement prompt (goal-driven loops).

---

*Tone summary in one line:*  
**A precise, useful, listening house of mid-Victorian work and faith-in-inquiry — oak, copper, lamps, and paper — not a museum of decoration.**
