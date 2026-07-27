/**
 * Unit tests for character lore bibles + prompt-injection structure.
 * Drives the real shipped character_bibles.js and greps the real index.js.
 * Also exercises the real buildSpeakerLoreBlock assembly path (local core).
 */
import { readFileSync } from 'fs';
import { LORE_ANCHORS, LORE_CONCEPT_KEYS } from './character_bibles.js';
import assert from 'assert';

const REQUIRED = ['selina', 'bell', 'amara', 'rooke', 'clara', 'elspeth'];
const SPEAKERS = Object.keys(LORE_ANCHORS);

assert.deepStrictEqual(SPEAKERS.sort(), REQUIRED.sort(), 'all six speakers present');

for (const id of REQUIRED) {
  const b = LORE_ANCHORS[id];
  assert.ok(b.concept.startsWith('core_bible_'), `${id} concept name`);
  assert.ok(b.header.includes('EMBODY'), `${id} header embody`);
  assert.ok(b.text.length > 200, `${id} text length`);
  assert.ok(b.fewshot && b.fewshot.length > 40, `${id} fewshot`);
  assert.ok(LORE_CONCEPT_KEYS[id]?.includes(b.concept), `${id} concept keys include bible`);
}

// Novel-critical facts that must not drift
assert.match(LORE_ANCHORS.selina.text, /patron|initiator|seed/i);
assert.match(LORE_ANCHORS.selina.text, /invited her|wrote Amara|invitation to Amara/i);
assert.match(LORE_ANCHORS.selina.text, /engaged.*Rooke|Rooke/i);
assert.match(LORE_ANCHORS.selina.text, /not the leader|not.*leader/i);
assert.match(LORE_ANCHORS.bell.text, /colleague|patronage|hospitality/i);
assert.match(LORE_ANCHORS.bell.text, /did not found|not found/i);
assert.match(LORE_ANCHORS.amara.text, /invited by Selina/i);
assert.match(LORE_ANCHORS.elspeth.text, /niece|child/i);
assert.doesNotMatch(LORE_ANCHORS.elspeth.text, /adult scholar/i);
assert.match(LORE_ANCHORS.selina.fewshot, /not speak of her as a ward|is my niece/i);
assert.match(LORE_ANCHORS.selina.fewshot, /Who invited Amara|I did, after Chiswick/i);

// Bridge source must wire injection for all speakers
const indexSrc = readFileSync(new URL('./index.js', import.meta.url), 'utf8');
assert.match(indexSrc, /buildSpeakerLoreBlock/);
assert.match(indexSrc, /character_bibles\.js/);
assert.match(indexSrc, /LORE_ANCHORS/);
assert.match(indexSrc, /StreamableHTTPClientTransport/);
assert.match(indexSrc, /CORE BIBLE/);
assert.match(indexSrc, /prefer the CORE BIBLE/);
assert.match(indexSrc, /buildSpeakerLoreBlock\(speaker\)/);
// Must not truncate CORE+fewshot with old MAX_MEMORY_CHARS+800 body cap
assert.doesNotMatch(
  indexSrc,
  /body\.substring\(0,\s*MAX_MEMORY_CHARS\s*\+\s*800\)/,
  'must not truncate full CORE+fewshot with MAX_MEMORY_CHARS+800'
);
assert.match(indexSrc, /Few-shots ALWAYS|fewBlock|NEVER truncated/i);

// Drive SHIPPED buildSpeakerLoreBlock (import without booting the HTTP server).
process.env.BRIDGE_NO_BOOT = '1';
const { buildSpeakerLoreBlock } = await import('./index.js');

for (const id of REQUIRED) {
  const block = await buildSpeakerLoreBlock(id);
  assert.ok(block.includes(LORE_ANCHORS[id].text), `${id} full CORE in block`);
  assert.ok(block.includes(LORE_ANCHORS[id].fewshot), `${id} full fewshot in block`);
  if (id === 'selina') {
    assert.match(block, /not speak of her as a ward/i);
    assert.match(block, /I did, after Chiswick/i);
    assert.ok(block.length >= 2500, `selina block must fit full CORE+fewshot (got ${block.length})`);
  }
}

// Godot rooms expanded
const roomsSrc = readFileSync(
  new URL('../aetheric-engine-godot/scripts/fps_rooms.gd', import.meta.url),
  'utf8'
);
for (const room of ['workshop', 'conservatory', 'kitchen', 'morning_room', 'gallery', 'drawing_room']) {
  assert.match(roomsSrc, new RegExp(`"${room}"`), `room ${room} defined`);
}
assert.match(roomsSrc, /"id": "rooke"/);
assert.match(roomsSrc, /"id": "clara"/);
assert.match(roomsSrc, /"id": "elspeth"/);
assert.match(roomsSrc, /RICHMOND_HOUSE_FLOOR_PLAN/);
assert.match(indexSrc, /elspeth:/);

console.log('PASS test_lore_injection.mjs');
console.log(JSON.stringify({
  speakers: SPEAKERS,
  concepts: SPEAKERS.map((s) => LORE_ANCHORS[s].concept),
  rooms: ['workshop', 'conservatory', 'kitchen', 'morning_room'],
  selinaBlockLen: (await buildSpeakerLoreBlock('selina')).length,
}, null, 2));
