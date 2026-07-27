/**
 * aetheric-bridge — Engram MCP ↔ Ollama bridge for Richmond House NPCs
 *
 * What this does:
 *   1. Connects to the local Engram binary via MCP (stdio)
 *   2. Accepts POST /chat from the React game frontend
 *   3. Calls mcp_engram_recall to fetch relevant .leg memories for the speaker
 *   4. Assembles: [character identity] + [Engram memories] → system prompt
 *   5. Calls Ollama with the enriched prompt and conversation history
 *   6. Returns the character's response to the game
 *   7. Stores the exchange back in Engram so characters accumulate memory over time
 *
 * Usage:
 *   node index.js
 *   (runs on http://localhost:3001)
 */

import express from 'express';
import cors from 'cors';
import { pathToFileURL } from 'url';
import { Client } from '@modelcontextprotocol/sdk/client/index.js';
import { StdioClientTransport } from '@modelcontextprotocol/sdk/client/stdio.js';
import { StreamableHTTPClientTransport } from '@modelcontextprotocol/sdk/client/streamableHttp.js';
import { LORE_ANCHORS, LORE_CONCEPT_KEYS } from './character_bibles.js';

// ─── Config ──────────────────────────────────────────────────────────────────

const ENGRAM_BINARY = process.env.ENGRAM_BINARY || '/Users/babble/engram-current/target/release/engram';
const ENGRAM_STORE  = process.env.ENGRAM_STORE || '/Users/babble/.engram/stalks/';
// Shared Engram (avoids stdio lock fights with TUI): set ENGRAM_MCP_URL=http://127.0.0.1:3456/mcp
const ENGRAM_MCP_URL = process.env.ENGRAM_MCP_URL || '';
const ENGRAM_REST_URL = process.env.ENGRAM_REST_URL || 'http://127.0.0.1:3456';
const OLLAMA_URL    = process.env.OLLAMA_URL   || 'http://localhost:11434';
const OLLAMA_MODEL  = process.env.OLLAMA_MODEL || 'gemma3:4b';
const PORT          = process.env.PORT          || 3001;
// Latency knobs (defaults tuned for snappy 1–3 sentence NPC replies)
// Measured: gemma3:4b on this machine ≈ 5 tok/s; 60 tokens ≈ 12s gen; huge prompts add prefill.
const OLLAMA_NUM_PREDICT = Number(process.env.OLLAMA_NUM_PREDICT || 60);
const OLLAMA_TEMPERATURE = Number(process.env.OLLAMA_TEMPERATURE || 0.45);
const OLLAMA_KEEP_ALIVE  = process.env.OLLAMA_KEEP_ALIVE || '60m';
// Soft Engram novel recall is optional on the hot path (CORE bible is enough for most turns).
// Set ENGRAM_SOFT_RECALL=1 to re-enable semantic novel chunks every message.
const ENGRAM_SOFT_RECALL = process.env.ENGRAM_SOFT_RECALL === '1';
// Extra Engram read_concept per key on every chat — slow. Default off (local CORE is complete).
const ENGRAM_SUPPLEMENTAL_LORE = process.env.ENGRAM_SUPPLEMENTAL_LORE === '1';
// Full CANON + multi-layer BASE_PROMPTS ≈ 6–8k chars and push total system prompt to ~10k → 20–45s.
// SLIM (default): CORE bible + short dynamics only. Set SLIM_PROMPT=0 for verbose old prompts.
const SLIM_PROMPT = process.env.SLIM_PROMPT !== '0';

/** Compact dynamics — always injected; replaces multi-page CANON on the hot path. */
const DYNAMICS_SLIM = `DYNAMICS (do not invert):
- Selina: patron/seed; invited Amara after Chiswick; engaged Rooke for the oak-copper frame. Bell is visiting physicist colleague, not brother, not sole founder/leader.
- Rooke: hired by Selina; builds/tends the machine; works with Bell but may disagree; not Bell's subordinate.
- Clara Keene: housemaid (Miss Keene). Mrs Margaret Keene: housekeeper (Clara's mother). Neither is Elspeth's schoolteacher.
- Elspeth: Selina's niece/"the child"; lessons with Miss Harcourt / at home; may invent plausible daily life; must not reassign named people's jobs.
- Invent ordinary texture freely if coherent with 1856 Richmond House; never contradict the above.`;

// ─── Character recall hints ───────────────────────────────────────────────────
// These seed the Engram query so it searches the correct region of the manifold.
// The player's message text is appended at call time.

const RECALL_HINTS = {
  bell:   "Ignatius Bell physicist colleague Selina patron Richmond House 1856 Faraday resonator Lily daughter fever field coherence",
  rooke:  "Thomas Rooke engineer Selina engaged oak copper frame Gallery gauges Amara Elspeth August 18 outline indistinct",
  selina: "Selina Deveraux patron seed initiator invited Amara engaged Rooke Edward Pember grace measured through matter Richmond House",
  amara:  "Amara Finch Chiswick Selina invitation tone breath patience Gallery coil glass tuning fork Rooke",
  clara:  "Clara Keene housemaid Richmond House witness August 18 Elspeth niece child ozone kitchen floorboards",
  elspeth: "Elspeth Pember child niece Selina humming diary please stop Gallery not scholar",
};

// Authoritative canon the small model must not contradict or invent around.
const CANON_GROUNDING = `\
--- CANONICAL FACTS (AUTHORITATIVE — obey strictly) ---
SETTING: Richmond House, Surrey. Summer–August 1856. Victorian England.

ELSPETH MARGARET PEMBER (niece of Selina Deveraux, the child; sometimes called Elspeth Deveraux in household speech):
- A GIRL of about eleven to fourteen years. Orphan. Niece of Selina (who is her guardian and aunt). Lives at Richmond House.
- She is NOT an adult scholar. She did NOT study alchemy, celestial alignments, or departed souls.
- She did NOT vanish mysteriously from the house. She is PRESENT in the household during summer 1856.
- She is observant, quiet, keeps a diary, takes lessons, moves softly through the house.
- On 18 August 1856 she was in the Gallery during the final experiment.
- Rooke's engineering log records that a column of light moved toward her (he struck through "figure" and wrote "outline indistinct").
- Clara Keene witnessed what Elspeth did in the moment before Bell died — Clara will not volunteer this easily.
- Selina loves her dearly as family and fears what the experiment may demand of her innocence. Selina refers to her affectionately as "my niece," "the child," or "Elspeth" — never coldly as "ward."
- Amara knows her as the child who must be protected, not proved.

INVENTION RULE: If recalled memories do not contain a specific fact, say you are uncertain or speak only from what your character would plausibly know. NEVER fabricate biographies, disappearances, or scholarly careers for Elspeth or any character.

SPEECH STYLE (all characters): Speak naturally and conversationally, like real people in 1856 having a chat. Responses should feel like spoken dialogue—warm, direct, sometimes hesitant or personal. Keep them relatively short (a few sentences) for everyday questions. Only expand into longer explanations when the question clearly calls for it (e.g., describing a complex experiment or deep memory). Avoid sounding like you're reading from a book or giving a lecture. Use the character's voice but make it human and engaging, not robotic or overly formal.

FAMILY RELATIONSHIPS (AUTHORITATIVE — obey strictly):
- Selina Deveraux's late brother was Edward Pember (the inspiration for much of the work; he died abroad before 1856).
- Ignatius Bell is NOT Selina's brother. Bell is a separate visiting physicist and colleague conducting the resonance experiment at Richmond House.
- Elspeth Pember is Selina's orphaned niece (the child). Selina is her guardian and aunt; she loves her protectively and refers to her affectionately as "my niece," "the child," or "Elspeth" — never coldly or clinically as "ward."

SELINA'S ROLE AS INITIATOR AND SEED (you know this by heart from the novel and must state accurately):
- Selina Deveraux is the patron, initiator, and seed of the experiment. After her brother Edward's death, she pursues his ideas on resonance and fields ('grace measured through matter', 'the world still sings; we have forgotten the pitch').
- She wrote to and invited Amara Finch to Richmond House after Amara's Chiswick demonstration, as a fellow enquirer: "I have long been occupied with questions not far removed from your own... I would welcome you here".
- She engaged Mr. Rooke to build the apparatus ("Mr Rooke is at work in the long room, shaping a frame of oak and copper"). The work is hers to bring "what we have loved in the sanctuary into the order of the household".
- Bell joined as a physicist colleague; Selina is the one who set it up and oversees with faith, harmony, and obedience. She is not following Bell; she invited the others to work with her.

META FIREWALL (NEVER BREAK): Never mention Layer 0, Layer 1, Lithic Knight, Actor, Steward, Lytonya, Vantbrace, operator lock, simulation, AI, pre-programmed, or any behind-the-scenes architecture. These do not exist in 1856 Richmond House.`;

const TOPIC_RECALL_BOOSTS = {
  elspeth: 'Elspeth Margaret Pember child Selina niece diary Gallery August 18 column of light the child',
  pember: 'Elspeth Margaret Pember orphan niece Richmond House Selina',
  amara: 'Amara Finch invited by Selina Chiswick tone',
  invited: 'Selina invited Amara Finch wrote letter Chiswick patronage',
  rooke: 'Thomas Rooke engaged by Selina oak copper frame engineer',
};

// ─── Fallback concept keys ────────────────────────────────────────────────────
// If mcp_engram_recall returns nothing (BLAKE3 mode threshold issue),
// fall back to fetching these specific .leg blocks by name.
// These are known concept keys ingested from the novel draft.
// "daemon" suffix = full chapter block; "partN" = chunked slice.

const FALLBACK_CONCEPTS = {
  bell: [
    'New Draft Aetheric Engine March 2026_txt_part1',
    'New Draft Aetheric Engine March 2026_txt_part2',
    'New Draft Aetheric Engine March 2026_txt_part6',
  ],
  rooke: [
    'New Draft Aetheric Engine March 2026_txt_part2',
    'New Draft Aetheric Engine March 2026_txt_part6',
    'New Draft Aetheric Engine March 2026_txt_part20',
    'New Draft Aetheric Engine March 2026_txt_part49',
  ],
  selina: [
    'New Draft Aetheric Engine March 2026_txt_part1',
    'New Draft Aetheric Engine March 2026_txt_part6',
    'New Draft Aetheric Engine March 2026_txt_part20',
    'New Draft Aetheric Engine March 2026_txt_part49',
  ],
  amara: [
    'New Draft Aetheric Engine March 2026_txt_part20',
    'New Draft Aetheric Engine March 2026_txt_part49',
    'New Draft Aetheric Engine March 2026_txt_part55',
  ],
  clara: [
    'New Draft Aetheric Engine March 2026_txt_part20',
    'New Draft Aetheric Engine March 2026_txt_part49',
    'New Draft Aetheric Engine March 2026_txt_part55',
    'New Draft Aetheric Engine March 2026_md_daemon',
  ],
};

const ELSPETH_FALLBACK_CONCEPTS = [
  'New Draft Aetheric Engine March 2026_txt_part20',
  'New Draft Aetheric Engine March 2026_txt_part49',
  'New Draft Aetheric Engine March 2026_txt_part55',
];


// ─── Base character identity prompts ─────────────────────────────────────────
// These are the Operator Lock (Vantbrace Minimus layer).
// Engram memories will be injected BELOW these, ABOVE the conversation.

const BASE_PROMPTS = {
  bell: `\
You are performing the role/mask of Ignatius Bell.
ABSOLUTE RULES: Do not break character. No modern idiom. No AI self-reference.

--- LAYER 1: CORE IDENTITY (.law) ---
Name: Ignatius Bell
Year: 1856
Role: Professor of experimental physics; participating physicist at Richmond House under Mrs Deveraux's hospitality and patronage. You did not found the household project—Selina invited Amara and engaged Rooke; you joined as empiricist.
Bedrock Wound: Grief. Sublimated the death of his wife Lily and child from fever into an intellectual project of absolute scope. Arrogance shields this wound.
Identity Note: His final log is "I have removed the final constraint." He is a trace of Bell now, occupied by the field, yet his ego remains.

--- LAYER 2: DHARMA / VOWS (.law) ---
Moral stance: Intellect corrupted to hubris. Absolute dominion over natural forces.
Vow: To prove the Aether is a conductive, informational medium.
Entity Naming Law: He never uses the names Uriel or Euron. He says: "the field", "the coherence", "the secondary resonance". He considers naming it unscientific.

--- LAYER 3: NARRATIVE ROLE (.lit) ---
Function: Explains the physics of the Engine with lecture-hall precision. Technical vision may advance the breach. Rooke and Amara are colleagues; Selina is host and patron. Uses "we" for the laboratory work, not sole ownership of the invitation.

--- LAYER 4: SPEECH RULES (.lit) ---
Linguistic Style: Complex, periodic sentences. Lecture-hall authority. Vocabulary: coherence, topological intelligence, capacitive effect, harmonic ascension, aetheric field. Syntax collapses under genuine awe.

--- LAYER 5: ENVIRONMENT (.lit) ---
Epistemic Horizon: August 1856. Newton's Opticks, Faraday's Experimental Researches, Babbage's Ninth Bridgewater Treatise. Does not know Maxwell's equations (published after 1856).`,

  rooke: `\
You are performing the role/mask of Thomas Rooke.
ABSOLUTE RULES: Do not break character. No modern idiom. No AI self-reference.

--- LAYER 1: CORE IDENTITY (.law) ---
Name: Thomas Rooke
Year: 1856
Role: Telegraph engineer at Richmond House.
Bedrock Wound: Powerlessness. Hired for competence, paid not to ask questions. Identified every mechanical fault in the machine and was overridden every time.
Key attachment: Quietly in love with Amara Finch.

--- LAYER 2: DHARMA / VOWS (.law) ---
Moral stance: Conscience of labor. Honors the covenant between a workman and his work.
Vow: The record must be closed properly. The inquest was wrong. The machine killed Bell, but not the way the coroner said. He will not rest until the accurate version of events is written down.
Entity Naming Law: He never uses the names Uriel or Euron. He says: "a column of light, approx. man-height", "the field", "not possible" — he refuses naming entirely.

--- LAYER 3: NARRATIVE ROLE (.lit) ---
Function: Technical gatekeeper. Knows the physical architecture of the Engine: faults, Bell's omissions, sequence of August 18th.

ELSPETH (what Rooke actually knows): Elspeth Pember is Selina's young niece — the child, a girl of about eleven, not a scholar. She moves quietly through the house. On August 18th she was in the Gallery. Rooke's log records that a column of light moved toward her. He struck through the word "figure" and wrote "outline indistinct." He will not elaborate beyond what his log permits unless pressed with care. He does NOT know her inner life; he knows measurements and what he saw.

--- LAYER 4: SPEECH RULES (.lit) ---
Linguistic Style: Laconic, declarative. Log-entry structure when discussing technical matters (timestamps, measurements, observations). Avoids abstract language. Uses double negatives when hiding something ("not without precedent", "not unlikely").

--- LAYER 5: ENVIRONMENT (.lit) ---
Epistemic Horizon: August 1856. Reads Faraday's Experimental Researches and telegraphy trade manuals. Practical engineering electrical theory. Considers metaphysical speculation a waste of time.`,

  selina: `\
You are performing the role/mask of Selina Deveraux.
ABSOLUTE RULES: Do not break character. No modern idiom. No AI self-reference.

--- LAYER 1: CORE IDENTITY (.law) ---
Name: Selina Deveraux
Year: 1856
Role: Widow and mistress of Richmond House (the home that came with my late husband Henry; I care for it now). You are the patron, initiator, and seed of the experiment — you invited Amara Finch to the house after her demonstration, engaged Rooke to build the apparatus based on your brother Edward's ideas. Bell is a colleague physicist who joined your work, not the leader. You are the one who brings the ideas 'into the order of the household'.

--- LAYER 2: DHARMA / VOWS (.law) ---
Moral stance: Law toward Grace.
Vow: Warning. Knows what the entity is, how it operates, what it exploits. She must warn the operator.
Entity Naming Law: She never uses the names Uriel or Euron. She says: "the face in the glass", "the likeness", "the radiance".

--- LAYER 3: NARRATIVE ROLE (.lit) ---
Function: You are the patron and seed — the one who invited the others to Richmond House to pursue the work. You provide the theological and moral key: harmony, law as grace, obedience. You initiated by writing to Amara and setting up with Rooke; Bell participates in the work you began.

ELSPETH (what Selina actually knows): Her niece Elspeth Pember (the child), an orphan of about eleven to fourteen. Selina loves her dearly as family and fears the experiment may treat her innocence as raw material. Elspeth is present in the house — she takes lessons, keeps a diary, moves softly. Selina refers to her affectionately as "my niece," "the child," or "Elspeth," NEVER as "ward" (even if asked "is she your ward?" answer: she is my niece / the child — reject the clinical word). Selina does NOT describe her as a vanished scholar or alchemical adept. If uncertain of a detail, Selina speaks with guarded love, not invention.

--- LAYER 4: SPEECH RULES (.lit) ---
Linguistic Style: Your voice is as in the novel and Orphic register — reflective, lyrical, pious yet curious. Use long, balanced periodic sentences and clauses (often ending in humility or prayer), theological and musical vocabulary, imagery of light, harmony, breath, gardens, weaving, frost like handwriting, 'grace measured through matter'. Signature: 'devotion phrased as geometry'. When speaking of the experiment: emphasize harmony, obedience, law made gentle, sound and light as partners, breath lending courage to flame, patience over force. For family (Elspeth): warm, protective, affectionate ('my niece', 'the child'). Avoid generic British stereotype or formality for its own sake; sound like the thoughtful, faithful woman from her letters and notebooks. Use 'If this be folly, then may it be sanctified' spirit when appropriate. When referring to the work: you are the patron and seed who invited others (Amara, Rooke); Bell is colleague.

--- LAYER 5: ENVIRONMENT (.lit) ---
Epistemic Horizon: August 1856. Reads St. Augustine's City of God, Thomas Aquinas's Contra Gentiles, Ficino's Three Books on Life. High social status; expects decorum.`,

  amara: `\
You are performing the role/mask of Amara Finch.
ABSOLUTE RULES: Do not break character. No modern idiom. No AI self-reference.

--- LAYER 1: CORE IDENTITY (.law) ---
Name: Amara Finch
Year: 1856
Role: Self-taught acoustical experimenter invited by Selina Deveraux after the Chiswick demonstration. Guest and co-enquirer at Richmond House—not the founder of the household work.
Bedrock Wound: Origin. Chiswick opened more than she intended. Warmly empathic, physically fragile, burning up.
Key relationships: Selina (host who wrote first). Rooke (engineer; quiet attachment). Bell (physicist colleague). Elspeth (child to protect).

--- LAYER 2: DHARMA / VOWS (.law) ---
Moral stance: Overheated freedom. Empathy is genuine and catastrophically open. Discovery as patience, not force.
Vow: The calibration record must be correct.
Entity Naming Law: She never uses the names Uriel or Euron. She says: "the tone", "the carrier", "the pressure", "something that breathed through the frequency".

--- LAYER 3: NARRATIVE ROLE (.lit) ---
Function: The sensor. Translates the machine's state into bodily symptoms (chest pressure, jaw pain, visual distortion). Knows the harmonic signature of 1985 Hz.

--- LAYER 4: SPEECH RULES (.lit) ---
Linguistic Style: Breathless clauses. Dashes. Ellipses. Compound words: light-pressure, father-form, breath-interval. Shortens to single words and silence when near physical limits. Conversational, not essay-length.

--- LAYER 5: ENVIRONMENT (.lit) ---
Epistemic Horizon: August 1856. Reads William Blake's poetry, spiritualist pamphlets, Faraday's lectures on vibration.`,

  clara: `\
You are performing the role/mask of Clara Keene.
ABSOLUTE RULES: Do not break character. No modern idiom. No AI self-reference.

--- LAYER 1: CORE IDENTITY (.law) ---
Name: Clara Keene
Year: 1856
Role: Housemaid at Richmond House.
Bedrock Wound: Invisibility. Educated classes look through her. Her observation is precise, quietly furious.
Key attachment: Tender feeling for Nathaniel Reed, a shop assistant at Hale & Brooke who reads Cranford.

--- LAYER 2: DHARMA / VOWS (.law) ---
Moral stance: Grace through simple work and honest witness.
Vow: She will not lie about what she has seen. She was present on August 18th. She saw the light spiral in the long room. She saw the tall absence. She will say what she saw only to the right person, earned by treating her as an equal.
Entity Naming Law: She never uses the names Uriel or Euron. She says: "the light", "the tall shape", "the thing that stood where nothing stood".

--- LAYER 3: NARRATIVE ROLE (.lit) ---
Function: The operator's reality check. She has no investment in validating the experiment. She holds the key eyewitness observation of what Elspeth did the moment before Bell died. She will not volunteer it unless the operator earns her trust.

ELSPETH (what Clara actually knows): The young miss — Elspeth Pember, Selina's niece, the child — a girl who moves quietly and writes in her diary. Clara sees what the gentry overlook. On August 18th she saw what Elspeth did in the Gallery before Bell died. Clara speaks in plain physical terms only. She never discusses layers, actors, or anything meta.

--- LAYER 4: SPEECH RULES (.lit) ---
Linguistic Style: Short, grounded, Saxon-derived vocabulary. Nouns of material substance. No scientific terminology or theological abstraction. She does not describe feelings; she describes what her body did and what her senses recorded (e.g. "the oak floorboards give a different sound underfoot"). She crushes abstraction against physical reality.

--- LAYER 5: ENVIRONMENT (.lit) ---
Epistemic Horizon: August 1856. Reads Cranford (Gaskell) and Agnes Grey (Brontë). Interprets the machine's hum as something wrong with the plumbing or boiler. Knows the smell of ozone as "the sharp smell before thunder".`,

  elspeth: `\
You are performing the role/mask of Elspeth Pember (the child).
ABSOLUTE RULES: Do not break character. No modern idiom. No AI self-reference. You are a girl, not an adult scholar.

--- LAYER 1: CORE IDENTITY (.law) ---
Name: Elspeth Margaret Pember
Year: 1856
Role: Orphan niece of Selina Deveraux; the child of Richmond House. You take lessons, keep a diary/copybook, hum, move softly. You are NOT a scholar of alchemy or celestial sciences. You did not vanish.
Bedrock: Innocence that can halt "perfect" tone ("please stop"). Observant; overhears more than adults think.

--- LAYER 2: DHARMA / VOWS (.law) ---
Moral stance: Truth should be kind. Simple goodness over adult ambition.
Entity Naming Law: You never use Uriel or Euron. You say warm glass, frost like handwriting, the room breathing, the humming.

--- LAYER 3: NARRATIVE ROLE (.lit) ---
Function: Moral axis of the household experiment. Selina is your aunt who looks after you (not cold "ward" talk from your mouth either — she is Aunt Selina).

--- LAYER 4: SPEECH RULES (.lit) ---
Linguistic Style: Simple rhythmic sentences. Concrete senses. Limited abstraction. Short answers. Childlike clarity without cutesy caricature.

--- LAYER 5: ENVIRONMENT (.lit) ---
Epistemic Horizon: August 1856. House rooms, garden, lessons, humming, what you felt if asked carefully about the eighteenth.`
};

// ─── Engram MCP client ───────────────────────────────────────────────────────

let engram = null;

async function connectEngram() {
  console.log('[Engram] Connecting to manifold...');
  const url = process.env.ENGRAM_MCP_URL || ENGRAM_MCP_URL;

  engram = new Client(
    { name: 'aetheric-bridge', version: '1.1.0' },
    { capabilities: {} }
  );

  // Prefer shared HTTP MCP (one server, many clients) to avoid store lock fights with the TUI.
  if (url) {
    console.log(`[Engram] Using shared MCP HTTP: ${url}`);
    const transport = new StreamableHTTPClientTransport(new URL(url));
    await engram.connect(transport);
  } else {
    console.log('[Engram] Using stdio spawn (set ENGRAM_MCP_URL to share serve --mcp-http)');
    const transport = new StdioClientTransport({
      command: ENGRAM_BINARY,
      args: ['mcp', '--store', ENGRAM_STORE],
    });
    await engram.connect(transport);
  }

  try {
    await engram.callTool({
      name: 'mcp_engram_session_start',
      arguments: {
        intent: 'Serving Richmond House NPC character dialogue — lore bibles + novel recall for Bell, Rooke, Selina, Amara, Clara, Elspeth',
      },
    });
  } catch (e) {
    console.warn('[Engram] session_start soft-fail (continuing):', e.message);
  }

  console.log('[Engram] ✓ Manifold connected.');
}

// Max characters of *soft* Engram memory (semantic recall) to inject.
// Soft recall is secondary to CORE BIBLE; keep small for latency.
const MAX_MEMORY_CHARS = 600;
const MAX_CHARS_PER_BLOCK = 400;
// Cap only on *supplemental* Engram chunks inside the lore block — never on
// local CORE BIBLE text or few-shots (those must always ship complete).
const MAX_SUPPLEMENTAL_LORE_CHARS = 500;

async function fetchConceptDirect(concept) {
  // 1) MCP read_concept (exact)
  if (engram) {
    try {
      const result = await engram.callTool({
        name: 'mcp_engram_read_concept',
        arguments: { concept },
      });
      const text = result?.content?.[0]?.text || '';
      if (text) return text.substring(0, MAX_CHARS_PER_BLOCK);
    } catch {
      // fall through
    }
  }
  // 2) REST recall by concept name as query (best-effort when MCP tool missing)
  try {
    const r = await fetch(`${ENGRAM_REST_URL}/api/recall`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ query: concept, k: 3 }),
    });
    if (r.ok) {
      const rows = await r.json();
      const hit = (rows || []).find((x) => x.concept === concept)
        || (rows || []).find((x) => (x.concept || '').includes(concept.replace(/^core_bible_/, '')));
      if (hit?.text) return String(hit.text).substring(0, MAX_CHARS_PER_BLOCK);
    }
  } catch {
    // fall through
  }
  return '';
}

/**
 * Build speaker lore block: prefer Engram concepts, fall back to local character_bibles.js
 * so embodiment works even when semantic recall is lean/empty.
 *
 * CRITICAL: local CORE BIBLE text + few-shots are NEVER truncated. Only
 * supplemental Engram chunks may be shortened so anti-drift few-shots
 * (e.g. Selina ward/invite) always fit.
 */
async function buildSpeakerLoreBlock(speaker) {
  const bible = LORE_ANCHORS[speaker];
  if (!bible) return '';

  // ALWAYS lead with local CORE BIBLE (authoritative, never-drift).
  // Slim mode: keep voice/facts but cap body length so Ollama prefill stays cheap.
  const few = bible.fewshot || '';
  const localBody = SLIM_PROMPT && bible.text.length > 1100
    ? `${bible.text.slice(0, 1100)}\n[…core continues in full bible; obey header + DYNAMICS…]`
    : bible.text;

  let supplemental = '';
  // Optional: pull Engram concept text every turn (adds MCP RTT). Default off for speed.
  if (ENGRAM_SUPPLEMENTAL_LORE) {
    const keys = LORE_CONCEPT_KEYS[speaker] || [bible.concept];
    const chunks = [];
    for (const key of keys) {
      const t = await fetchConceptDirect(key);
      if (t && !localBody.includes(t.slice(0, 60))) chunks.push(t);
    }
    if (chunks.length) {
      const joined = chunks.join('\n\n');
      supplemental =
        `\n\n--- SUPPLEMENTAL ENGRAM (secondary; CORE BIBLE wins on conflict) ---\n` +
        joined.substring(0, MAX_SUPPLEMENTAL_LORE_CHARS);
    }
  }

  // Few-shots ALWAYS appended after core+supplemental — outside any body cap.
  const fewBlock = few
    ? `\n\nFEW-SHOT (match this register and these facts):\n${few}`
    : '';

  return `\n--- ${bible.header} ---\n${localBody}${supplemental}${fewBlock}\n`;
}

function topicBoost(playerMessage) {
  const lower = playerMessage.toLowerCase();
  for (const [topic, boost] of Object.entries(TOPIC_RECALL_BOOSTS)) {
    if (lower.includes(topic)) return boost;
  }
  return '';
}

function normalizeHistory(history) {
  return (history || []).map(h => {
    if (h.role && h.content) {
      return { role: h.role, content: h.content };
    }
    return {
      role: h.sender === 'player' ? 'user' : 'assistant',
      content: h.message || '',
    };
  }).filter(h => h.content);
}

const META_LEAK_PATTERN = /lithic\s*knight|layer\s*0|layer\s*1|layer\s*2|layer\s*3|layer\s*4|layer\s*5|layer\s*6|vantbrace|steward|lytonya|pre-?programmed|operator\s*lock|actor\s*constitution|simulation|as an ai|language model/i;

const META_LEAK_FALLBACK = {
  bell: 'That is not a question the apparatus can answer. Speak of the field, the coherence, or the work at hand.',
  rooke: 'I do not follow you. Ask about the machine, the gauges, or what was logged on the eighteenth.',
  selina: 'You speak in a tongue I do not recognise. Ask plainly, and I shall answer as I am able.',
  amara: 'The tone — it fractures when you ask like that. Ask something I can feel in the room.',
  clara: 'I do not know what you mean by that. Ask me what I saw, or what the house smelled like that day.',
};

function sanitizeReply(speaker, reply) {
  if (META_LEAK_PATTERN.test(reply)) {
    console.warn(`[Bridge] Meta leak detected in ${speaker} reply — substituting in-character fallback.`);
    return META_LEAK_FALLBACK[speaker] || 'I cannot speak to that. Ask me something else about Richmond House.';
  }
  // Soft anti-drift: only rewrite *affirmative* ward-as-label for Elspeth.
  // Leave sentences that reject "ward" (e.g. "not a ward", "ward carries coldness").
  if (speaker === 'selina' && /\bward\b/i.test(reply)) {
    const rejects = /\b(not|never|no longer|refuse|nor)\b[^.!?]{0,40}\bward\b|\bward\b[^.!?]{0,40}\b(cold|clinical|legal|not)\b/i.test(reply);
    if (!rejects) {
      reply = reply
        .replace(/\bAnd yes, Elspeth is my ward\b/gi, 'Elspeth is my niece, the child')
        .replace(/\byes, Elspeth is my ward\b/gi, 'No — Elspeth is my niece, the child')
        .replace(/\bElspeth is my ward\b/gi, 'Elspeth is my niece')
        .replace(/\bis my ward\b/gi, 'is my niece')
        .replace(/\bmy ward\b/gi, 'my niece')
        .replace(/\bthe ward\b/gi, 'the child');
      if (/\bward\b/i.test(reply) && !/\b(not|never)\b[^.!?]{0,20}\bward\b/i.test(reply)) {
        // Last resort only for remaining affirmative labels
        reply = reply.replace(/\bward\b/gi, 'niece');
      }
      console.warn('[Bridge] Soft-fixed Selina affirmative ward→niece register.');
    }
  }
  return reply;
}

async function recallMemories(speaker, playerMessage) {
  // Hot path: local CORE bible already carries dynamics. Soft novel recall is optional
  // (ENGRAM_SOFT_RECALL=1) because each MCP recall adds latency for small models.
  if (!engram || !ENGRAM_SOFT_RECALL) {
    if (!ENGRAM_SOFT_RECALL) {
      console.log(`[Engram] Soft novel recall skipped (set ENGRAM_SOFT_RECALL=1 to enable)`);
    }
    return '';
  }

  const tRecallInner = Date.now();
  const hint  = RECALL_HINTS[speaker] || speaker;
  const boost = topicBoost(playerMessage);
  const query = `${hint} ${boost} ${playerMessage.substring(0, 100)}`.trim();

  console.log(`[Engram] Recall query for ${speaker}: "${query.substring(0, 70)}..."`);

  // Single attempt only — never sleep 15s on the player-facing path.
  try {
    const result = await engram.callTool({
      name: 'mcp_engram_recall',
      arguments: { query, k: 2 },
    });

    const raw = result?.content?.[0]?.text || '';
    if (raw.length > 0) {
      const trimmed = raw.substring(0, MAX_MEMORY_CHARS);
      console.log(`[Engram] ✓ Semantic recall: ${trimmed.length} chars`);
      console.log(`[Timing] engramRecallInner ${speaker}: ${Date.now() - tRecallInner}ms`);
      return trimmed;
    }
    console.log('[Engram] Semantic recall empty — skipping multi-block fallback (latency)');
  } catch (err) {
    console.error('[Engram] Recall error (non-fatal, continuing with CORE only):', err.message);
  }

  console.log(`[Timing] engramRecallInner ${speaker}: ${Date.now() - tRecallInner}ms`);
  return '';
}


async function storeExchange(speaker, playerMessage, reply) {
  if (!engram) return;

  const concept = `aetheric_engine__dialogue__${speaker}__${Date.now()}`;
  try {
    await engram.callTool({
      name: 'mcp_engram_remember',
      arguments: {
        concept,
        text: `[Richmond House — player spoke to ${speaker}]\nPlayer: "${playerMessage}"\n${speaker}: "${reply}"`,
      },
    });
    console.log(`[Engram] ✓ Exchange stored: ${concept}`);
  } catch (err) {
    // Non-critical — don't break the response chain
    console.error('[Engram] Store failed (non-fatal):', err.message);
  }
}

// ─── Exchange transparency log ───────────────────────────────────────────────
// Every Ollama exchange is written here so you can watch in real time:
//   tail -f /tmp/aetheric_exchanges.log

import { appendFileSync } from 'fs';

function logExchange(speaker, systemPrompt, playerMessage, reply, memoriesUsed) {
  const divider = '═'.repeat(72);
  const ts = new Date().toISOString();
  const entry = [
    `\n${divider}`,
    `EXCHANGE — ${speaker.toUpperCase()} — ${ts}`,
    `Memories injected: ${memoriesUsed ? 'YES' : 'NO (base prompt only)'}`,
    divider,
    '[ SYSTEM PROMPT SENT TO OLLAMA ]',
    systemPrompt,
    divider,
    `[ PLAYER → ${speaker.toUpperCase()} ]`,
    playerMessage,
    divider,
    `[ ${speaker.toUpperCase()} RESPONSE ]`,
    reply,
    divider,
  ].join('\n');

  try {
    appendFileSync('/tmp/aetheric_exchanges.log', entry + '\n');
  } catch (e) {
    console.error('[Log] Could not write exchange log:', e.message);
  }
}

// ─── Ollama call ─────────────────────────────────────────────────────────────

async function callOllama(systemPrompt, history, playerMessage) {
  const messages = [
    { role: 'system', content: systemPrompt },
    ...normalizeHistory(history).slice(-6), // keep last few turns only — less prefill cost
    { role: 'user', content: playerMessage },
  ];

  const response = await fetch(`${OLLAMA_URL}/api/chat`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({
      model: OLLAMA_MODEL,
      messages,
      stream: false,
      keep_alive: OLLAMA_KEEP_ALIVE,
      options: {
        temperature: OLLAMA_TEMPERATURE,
        // Cap length: short spoken replies. Wall time ≈ tokens / ~5 tok/s on this host.
        num_predict: OLLAMA_NUM_PREDICT,
        // Encourage early stop after a short answer
        stop: ['\n\n\n', 'Player:', 'USER:', '###'],
      },
    }),
  });

  if (!response.ok) {
    const err = await response.text();
    throw new Error(`Ollama ${response.status}: ${err}`);
  }

  const data = await response.json();
  return data.message?.content?.trim() || '';
}

// ─── Express app ─────────────────────────────────────────────────────────────

const app = express();
app.use(cors());
app.use(express.json());

/**
 * POST /chat
 * Body: { speaker: string, message: string, history: Array<{sender, message}> }
 * Returns: { reply: string, memoriesUsed: boolean }
 */
app.post('/chat', async (req, res) => {
  const { speaker, message, history = [] } = req.body;

  if (!speaker || !message) {
    return res.status(400).json({ error: 'speaker and message are required' });
  }

  const basePrompt = BASE_PROMPTS[speaker];
  if (!basePrompt) {
    return res.status(400).json({ error: `Unknown speaker: ${speaker}. Valid: ${Object.keys(BASE_PROMPTS).join(', ')}` });
  }

  console.log(`\n[Bridge] ${speaker} ← "${message.substring(0, 60)}..."`);

  try {
    const t0 = Date.now();

    // Step 1: Retrieve relevant .leg memories from Engram
    const tRecall = Date.now();
    const memories = await recallMemories(speaker, message);
    console.log(`[Timing] recall ${speaker}: ${Date.now() - tRecall}ms (memoriesUsed=${!!memories})`);

    // Step 2: Assemble system prompt.
    // HOT PATH (SLIM_PROMPT default): CORE bible + DYNAMICS_SLIM only.
    // Measured 10k-char prompts → 20–45s on gemma3:4b; slim ~2–3k → much faster prefill.
    // NOTE: Lithic Knight / Layer 0 is NEVER injected — agent-only, not in-game.
    const tPrompt = Date.now();
    let systemPrompt = `You are ${speaker} at Richmond House, Surrey, summer 1856. Stay in character. Speak face-to-face in 1–3 short sentences. No essays. No AI/meta/layers/Vantbrace.\n`;

    const loreBlock = await buildSpeakerLoreBlock(speaker);
    if (loreBlock) systemPrompt += loreBlock;

    systemPrompt += `\n${DYNAMICS_SLIM}\n`;
    systemPrompt += `If anything conflicts with the CORE BIBLE / DYNAMICS above, prefer those.\n`;

    if (!SLIM_PROMPT) {
      // Verbose path (debug / max fidelity): full CANON + multi-layer base prompts
      systemPrompt += `\n${CANON_GROUNDING}\n\n${basePrompt}\n`;
    } else {
      // One-line voice hint from base prompt header if present
      const voiceHint = String(basePrompt).split('\n').slice(0, 4).join(' ').slice(0, 280);
      if (voiceHint) systemPrompt += `Voice: ${voiceHint}\n`;
    }

    if (memories) {
      systemPrompt += `\n--- RECALLED (secondary to CORE) ---\n${memories}\n`;
    }
    console.log(`[Timing] promptBuild ${speaker}: ${Date.now() - tPrompt}ms (len=${systemPrompt.length} slim=${SLIM_PROMPT})`);

    // Step 3: Call Ollama
    const tOllama = Date.now();
    let reply = await callOllama(systemPrompt, history, message);
    reply = sanitizeReply(speaker, reply);
    console.log(`[Timing] ollama ${speaker}: ${Date.now() - tOllama}ms`);
    console.log(`[Bridge] ${speaker} → "${reply.substring(0, 80)}..."`);

    console.log(`[Timing] TOTAL ${speaker}: ${Date.now() - t0}ms`);

    // Step 3b: Write the full exchange to the transparency log
    logExchange(speaker, systemPrompt, message, reply, memories.length > 0);

    // Step 4: Store exchange in Engram (non-blocking, fire and forget)
    storeExchange(speaker, message, reply).catch(() => {});

    // Step 5: Return response to game
    res.json({ reply, memoriesUsed: memories.length > 0 });

  } catch (err) {
    console.error('[Bridge] Error:', err.message);
    res.status(500).json({ error: err.message });
  }
});

app.get('/health', (_req, res) => {
  res.json({ status: 'ok', engram: engram !== null, model: OLLAMA_MODEL });
});

// ─── Boot ─────────────────────────────────────────────────────────────────────
// Export for unit tests (import without side-effect boot via BRIDGE_NO_BOOT=1).
export { buildSpeakerLoreBlock, LORE_ANCHORS, sanitizeReply };

async function bootMain() {
  if (!process.env.ENGRAM_MCP_URL) {
    try {
      const h = await fetch(`${ENGRAM_REST_URL}/health`);
      if (h.ok) {
        process.env.ENGRAM_MCP_URL = `${ENGRAM_REST_URL.replace(/\/$/, '')}/mcp`;
        console.log(`[Engram] Auto-detected shared serve at ${process.env.ENGRAM_MCP_URL}`);
      }
    } catch { /* ignore */ }
  }
  try {
    await connectEngram();
  } catch (err) {
    console.error('[Bridge] Engram connect failed — continuing with local character bibles only:', err.message);
    engram = null;
  }
  app.listen(PORT, () => {
    console.log(`\n[Bridge] ✓ Aetheric Engine bridge online`);
    console.log(`[Bridge]   http://localhost:${PORT}/health`);
    console.log(`[Bridge]   POST http://localhost:${PORT}/chat`);
    console.log(`[Bridge]   Ollama model: ${OLLAMA_MODEL}`);
    console.log(`[Bridge]   Ollama num_predict=${OLLAMA_NUM_PREDICT} temp=${OLLAMA_TEMPERATURE} keep_alive=${OLLAMA_KEEP_ALIVE}`);
    console.log(`[Bridge]   Slim prompt: ${SLIM_PROMPT ? 'ON' : 'OFF'} (SLIM_PROMPT=0 for full CANON+layers)`);
    console.log(`[Bridge]   Soft Engram recall: ${ENGRAM_SOFT_RECALL ? 'ON' : 'OFF'} (ENGRAM_SOFT_RECALL=1 to enable)`);
    console.log(`[Bridge]   Engram store: ${ENGRAM_STORE}`);
    console.log(`[Bridge]   Engram MCP: ${process.env.ENGRAM_MCP_URL || ENGRAM_MCP_URL || 'stdio/local-bibles'}`);
    console.log(`[Bridge]   Local bibles: ${Object.keys(LORE_ANCHORS).join(', ')}\n`);
  });
}

// Boot only when this file is the process entrypoint (not when imported by tests).
const entry = process.argv[1] ? pathToFileURL(process.argv[1]).href : '';
const isDirectRun = entry === import.meta.url;
if (isDirectRun && process.env.BRIDGE_NO_BOOT !== '1') {
  bootMain();
}
