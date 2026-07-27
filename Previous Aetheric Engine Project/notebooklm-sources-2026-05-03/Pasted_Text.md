# Pasted Text

# The Aetheric Engine — Visual Novel Implementation Plan

Last updated: 19 April 2026


--------------------------------------------------------------------------------


## What This Is

A visual novel game that is a sequel to the novel The Aetheric Engine (March 2026 draft). The player is **Rowan Ellis**, a materialist atheist academic editor, in 2023 London. The novel she edited — the Deveraux Archive — documented a catastrophic resonance experiment in 1856. Now the editor who assembled that archive, **Dr. Charles Harrow**, has vanished. Rowan goes to his apartment to find a missing document. She finds the machine he secretly rebuilt. And Harrow is gone — pulled inside by the entity who has been trying to materialize into the physical world since 1856.

Rowan must investigate, understand the machine, and save Harrow before the entity succeeds.

**Core innovation:** Instead of scripted NPCs, the game uses **Character Agents** — LLM-powered entities whose dialogue is generated live in response to the player. Each agent is bound to a story **Vow** that constrains what they can say and when — but within that constraint, every conversation is unique to this player. No two playthroughs are identical. All paths lead to the same story structure.


--------------------------------------------------------------------------------


## The World

### The Novel (source material)

The Aetheric Engine is a Victorian epistolary horror novel structured as the Deveraux Archive — a collection of letters, diary entries, lab notes, newspaper clippings, and legal documents assembled by Dr. Charles Harrow between 2010–2011, then published posthumously (after his disappearance) by Rowan Ellis.

The archive documents a group of 1856 investigators in Surrey who built a harmonic resonance apparatus and triggered something they could not control. The field did not die. It withdrew.

### The 1856 Cast (accessible as traces through the machine)

|  |  |

| --- | --- |

|  |  |

|  |  |

|  |  |

|  |  |

|  |  |

|  |  |

|  |  |

### The Modern Cast

|  |  |

| --- | --- |

|  |  |

|  |  |


--------------------------------------------------------------------------------


## The Entities

### Uriel (primary antagonist)

**True identity:** Ningal — Mesopotamian moon goddess, wife of Nanna/Sin, mother of Inanna and Utu. Goddess of the city of Ur.

**History:** Ningal stood before the divine assembly and pleaded for the city of Ur to be spared. The decree was fixed. The city fell. She has been separated from the physical world since and has been attempting re-entry ever since. She was present but unidentified at the 1856 Aetheric Engine experiment — her first near-success. Harrow's modern reconstruction gave her a second opportunity.

**Her name:** She renamed herself **Uriel** — taking the name of her lost city (Ur) and the divine suffix (El). It is a name constructed from grief. The name also coincides with the Christian archangel Uriel (flame of God), which is how she has been interpreted in Western theology: alternately angelic and demonic, never understood correctly.

**Her method:** She benefits from a materialist operator. A scientist who takes the machine seriously as physics — with no ritual framework, no Invocation of Order, no moral hesitation — is a more effective instrument than a believer. Rowan's atheism, without the player realizing it, may serve Uriel early in the game.

### Euron (Rowan's guardian)

**Nature:** A spirit of air, and an angel in Christian ontology. Named for **Eurus**, the Greek god of the east wind.

**Origin:** Caught up in Amara Finch's 1854 Chiswick experiment. Sound travels through air; the sustained tone of the glass cylinder experiment moved through him. He chose to remain engaged afterward. He was also present but unidentified at the 1856 catastrophe.

**His role in the sequel:** Euron operates as Uriel's rival in the aetherial plane and Rowan's guardian. He participates voluntarily — he chooses to help Rowan. He speaks first in impressionistic fragments (through drafts, flickers, peripheral sounds) and only fully opens when Rowan acknowledges something non-physical is communicating.

**Theological position:** Servant of Christ. Opposed to Uriel/Ningal's materialization. His instructions, properly followed, provide the equivalent of the 1856 Invocation of Order.


--------------------------------------------------------------------------------


## Endings

Many paths lead to **Uriel's successful incarnation** — her entry into the physical world. This likely includes Harrow's death or permanent entrapment in the spiritual/digital realm. These are the bad endings. A purely materialist Rowan who never performs the Invocation of Order, never acknowledges Euron, and follows the machine's technical logic without moral framework may be unable to reach a good ending at all — she has inadvertently served Uriel throughout.

Players who engage with the theological or panpsychist frameworks unlock paths Uriel cannot anticipate or counter.


--------------------------------------------------------------------------------


## Core Mechanics

### The Machine as Portal

Harrow's reconstructed Aetheric Engine is the primary game interface. It is not just a prop — it is a portal into the aetherial plane. The machine's computer interface (which Harrow built seemingly expecting Rowan) is the document browser, the communication terminal, and the resonance control panel. Everything happens through or around the machine.

### The Epistemic Stance System

Player choices accrue to a hidden four-axis score. Choices are never labeled — the player picks what sounds right, not what's tagged as a philosophical category. The accumulated stance determines what agents reveal, which traces are accessible, and what endings are reachable.

|  |  |

| --- | --- |

|  |  |

|  |  |

|  |  |

|  |  |

**Key design principle:** Early materialist choices look like the rational option and feel like good decisions. They also, without the player realizing it, remove the moral brakes that the 1856 investigators had — and serve Uriel. This is the game's central horror: Rowan's intelligence makes her dangerous to herself.

### The Hybrid Dialogue System

**Free text:** Player types anything; agents respond in character, honoring their Vow

**Choice menus:** Appear at key philosophical junctions; drive Epistemic Stance

**Gates:** Agent goes quiet (fragments, silences) until player takes a required action. The resonance field withdraws until attended to.

### The `.leg` File Mechanic

Harrow's machine stores "resonance records" as `.leg` files — the same format as the Engram memory system. The file browser IS the document viewer. Some files are corrupted. Some are locked by Epistemic Stance threshold. Reading a `.leg` file is both a game mechanic and a lore mechanic: the characters' presence in the machine IS their memory.


--------------------------------------------------------------------------------


## The Three-Layer Architecture

### Layer 1 — The Vow (Story State Machine)

Each agent lives in a finite set of dramatic phases. They improvise freely within the current phase but cannot skip forward, reveal locked information, or contradict past statements. Beat conditions trigger phase transitions.

### Layer 2 — Engram Memory (The Character's Soul)

Each agent has their own Engram namespace. Before every response, the agent recalls their Vow, relevant facts, and this player's history. The prompt is dynamically constructed from recall — not a static system prompt.

|  |  |

| --- | --- |

|  |  |

|  |  |

|  |  |

|  |  |

### Layer 3 — LLM Inference (The Voice)

**Development:** Ollama + Gemma 4 small, running locally **Distribution (Steam):** `llama-cpp-python` with bundled GGUF model (~800MB for 1B, ~2.5GB for 4B). No internet required. Players download the game — it works offline.


--------------------------------------------------------------------------------


## Agent Tiers (Build Order)

|  |  |  |

| --- | --- | --- |

|  |  |  |

|  |  |  |

|  |  |  |

|  |  |  |

|  |  |  |


--------------------------------------------------------------------------------


## Engine & Platform

**Engine:** Ren'Py 8.5.2 (located at `~/renpy-sdk/`) **Why Ren'Py:** Industry standard for visual novel Steam releases. Native Mac/Windows/Linux export. Built-in Steamworks plugin. Save/load/rollback included. .rpy scripting language is readable without coding background. Python underneath handles all AI integration.

**Target platforms:** Steam (primary), other storefront platforms (secondary) **Target download size:** ~3-7GB (Ren'Py + assets + bundled LLM + bundled image model if dynamic art is added in later phase)

**Current build:** Trial v0.1 at `/Users/babble/.gemini/antigravity/playground/aetheric-engine/`

Opening scene functional (exterior → apartment → terminal)

Three background images generated and integrated

First philosophical choice point implemented

Epistemic Stance variable initialized


--------------------------------------------------------------------------------


## Art & Visual Style

**Palette:** Near-black backgrounds, aged gold (#c8a96e) accents, cold blue-green for the machine's glow **Style:** Painterly cinematic — not photorealistic, not cartoonish **Rowan:** Never shown face-on. Back view, silhouette, or partial only. Player IS Rowan. **All prompts logged in:** `/Users/babble/.gemini/antigravity/playground/aetheric-engine/ART_ASSETS.md` **Visual profiles in Engram:** `char_rowan_visual`, `char_harrow_visual`, `char_euron_visual` (TBD), `char_uriel_visual` (TBD), `art_style_guide`

Note: Dynamic in-game image generation (Stable Diffusion, player-unique art) is a future phase — shelved until story and plot outline are finalized.


--------------------------------------------------------------------------------


## Current Status & Next Steps

**PAUSED for story development.** The game cannot be built properly without:

A finalized novel draft (The Aetheric Engine)

A full game plot outline — all scenes, beats, agent vow structures, Epistemic Stance branch points, and ending conditions

**The novel draft (March 2026, 7,462 lines) is fully ingested into the Engram manifold** and available for reference at any time.

### When story development is complete, build resumes at:

**Phase 1 — Foundation**

[ ] Install Ollama + pull Gemma 4 model

[ ] Configure Engram sheaf mode (separate namespaces per character agent)

[ ] Build Archive terminal interface in Ren'Py (Engram recall, no LLM yet)

[ ] Implement Epistemic Stance tracking (four-axis hidden score)

[ ] Write and store Euron's full Vow in his Engram namespace

**Phase 2 — First Contact (Euron)**

[ ] Implement Euron as first live LLM agent

[ ] Build free-text input system

[ ] Implement Gate mechanic (agent silence until beat condition met)

[ ] Euron Phase 1 → Phase 2 beat transition

[ ] First major document: Chiswick newspaper clipping (Amara Finch, 1854)

**Phase 3 — The Antagonist (Uriel)**

[ ] Implement Uriel/Ningal as second LLM agent

[ ] Epistemic Stance influence on which agent is "louder" to the player

[ ] The Invocation of Order mechanic

[ ] Uriel's attempted materialization scene

**Phase 4 — The 1856 Traces**

[ ] Selina Deveraux (most coherent, most information)

[ ] Ignatius Bell (skeptic trace — materialist path unlock)

[ ] Additional traces per plot outline

**Phase 5 — Harrow and the Endings**

[ ] Harrow as partial presence, recoverable

[ ] Multiple ending paths per Epistemic Stance

[ ] Steam packaging and distribution testing


--------------------------------------------------------------------------------


## Open Questions (for story development phase)

[!IMPORTANT] **The document Rowan is searching for** — what specific item brings her to Harrow's apartment? It should be narratively meaningful, possibly the thing that inadvertently activates the machine. TBD.

[!IMPORTANT] **How does Rowan first learn the name "Euron"?** — In Harrow's notes? Through direct contact? Both? TBD.

[!IMPORTANT] **Euron's and Uriel's visual design** — not yet determined. Do not generate character art until confirmed with the user.

[!NOTE] **Chiswick confirmed** (user typo was "Chadwick" in an earlier message — the novel and game both use Chiswick).

[!NOTE] **Euron's name** is derived from Eurus (Greek east wind). He is both an elemental air spirit and an angel in Christian ontology — both framings are valid within the game's world.