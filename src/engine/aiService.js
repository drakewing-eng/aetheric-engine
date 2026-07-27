/**
 * aiService.js — Routes character dialogue through the Engram bridge.
 *
 * The bridge (server/index.js) handles:
 *   - Engram .leg memory retrieval per character
 *   - Vantbrace system prompt assembly
 *   - Ollama call
 *   - Storing the exchange back in Engram
 *
 * This file simply sends the request and returns the reply.
 * Start the bridge first: cd server && npm install && node index.js
 */

import { CHARACTERS } from './vows';

const BRIDGE_URL = 'http://localhost:3001';

export async function generateDialogue({ speaker, messageHistory, userMessage, settings }) {
  const character = CHARACTERS[speaker];
  if (!character) throw new Error(`Unknown speaker: ${speaker}`);

  // Format history for the bridge
  const history = messageHistory.map(log => ({
    sender: log.sender === character.name ? 'character' : 'player',
    message: log.message,
  }));

  const response = await fetch(`${BRIDGE_URL}/chat`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({
      speaker,        // 'bell', 'rooke', 'selina', 'amara', 'clara'
      message: userMessage,
      history,
    }),
  });

  if (!response.ok) {
    const err = await response.json().catch(() => ({ error: response.statusText }));
    throw new Error(err.error || `Bridge returned ${response.status}`);
  }

  const data = await response.json();

  if (!data.reply) throw new Error('Bridge returned empty reply');

  // Log whether Engram memories were used (visible in browser console)
  if (data.memoriesUsed) {
    console.log(`[aiService] ${character.name} spoke from Engram .leg memory.`);
  } else {
    console.log(`[aiService] ${character.name} spoke from base identity only (no memories retrieved).`);
  }

  return data.reply;
}
