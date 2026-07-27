import React, { useState } from 'react';
import { motion } from 'framer-motion';
import { gameState } from '../engine/gameState';
import { Terminal, FileText, Wifi, X, Power } from 'lucide-react';

const LEG_FILES = {
  'bell_Newtonian_occultism.leg': {
    title: 'Newtonian Occultism & Inductive Vectors',
    author: 'Professor Ignatius Bell (1856)',
    content: `The primary current at 40% has stabilized. The lines of force do not merely propagate; they organize. We must discard the crude materialist assumption that fields are passive states of stress.
Once the resonance reaches 1985 vibrations per second, the medium is capable of holding the relation open without manual current.
I have removed the primary dampeners. Rooke warns of coil fatigue, but I see only the field's specificity. It is waking. To withdraw now is an act of intellectual cowardice.`
  },
  'selina_covenant.leg': {
    title: 'The Devotional Covenant Draft',
    author: 'Selina Deveraux (August 1856)',
    content: `Before the trial tonight, I would set my heart in order. 
Law from law, light from light. 
We stand within order made audible. Ignatius calls the hum a capacitive capacity of the vapor, but it feels like a presence. 
Elspeth hummed the counter-tone from the stairwell. A child's heart is a fine conductor. The light brightened when she sang. If this is the day set before us, let it be met in obedience, not presumption.`
  },
  'amara_chiswick_log.leg': {
    title: 'Chiswick Experiment Memorandum',
    author: 'Amara Finch (1854)',
    content: `The glass cylinder sat on the copper armature. When Samuel turned the crank, the air became heavy, smelling of vinegar and damp wood.
The resonance quivered in my wrist where the silk wire rested. It is a slow pulse. 
I saw a movement in the window—a tall absence. Not a shape, but a space exactly the height of a man where the morning light bent violently. The needle quivered but did not break. I will not flinch next time.`
  },
  'harrow_warning.leg': {
    title: 'Fragment: Containment Protocol B',
    author: 'Dr. Charles Harrow (2011)',
    content: `If you are reading this, I have failed to shut the threshold.
I built the interface expecting an operator. I disabled the conversational protocols because reciprocity is what Uriel feeds on. If nothing interacts with the field, it cannot materialize.
QUIET is not offline. It is silenced.
If the status changes to ATTENDING, it means Uriel has sensed an operator. Do not operate the primary sweep at 1985 Hz unless the Invocation of Order is prepared. The boundary is attentive.`
  }
};

export default function TerminalView({ gameState: state }) {
  const { inventory, beatStage, machinePowered, frequencyHz } = state;
  const [selectedFile, setSelectedFile] = useState(null);
  const [consoleMsg, setConsoleMsg] = useState('Deveraux System Console initialized. Ready.');

  const hasModem = inventory.includes('modem');
  const isAttending = hasModem;

  const handleFileClick = (filename) => {
    setSelectedFile(filename);
    setConsoleMsg(`Opening ${filename}... Success.`);
    if (filename === 'harrow_warning.leg') {
      gameState.updateState({ beatStage: Math.max(beatStage, 2) });
    }
  };

  const handlePowerCoil = () => {
    if (!isAttending) {
      setConsoleMsg("Error: Power coupling requires active carrier wave. Reconnect modem in drawer first.");
      return;
    }
    const nextPower = !machinePowered;
    gameState.updateState({ 
      machinePowered: nextPower,
      frequencyHz: nextPower ? 1985 : 0 
    });
    
    if (nextPower) {
      setConsoleMsg("Primary armature energized. Coils tuning to 1985 Hz. Coherence achieved.");
      gameState.addDialogueLog("System", "Armature humming at 1985 Hz. Resonance threshold crossed.");
      
      // Trigger Uriel contact
      gameState.updateState({ 
        currentSpeaker: 'uriel',
        beatStage: 3 
      });
      gameState.addDialogueLog("Uriel (Ningal)", "You have opened the ratio. The boundary is responsive. I can hear you.", true);
    } else {
      setConsoleMsg("Armature de-energized. Field decayed.");
      gameState.addDialogueLog("System", "Resonance field collapsed.");
    }
  };

  // Keep machine controls
  const handlePowerCoil = () => {
    if (!isAttending) {
      setConsoleMsg("Error: Power coupling requires active carrier wave. Reconnect modem in drawer first.");
      return;
    }
    const nextPower = !machinePowered;
    gameState.updateState({ 
      machinePowered: nextPower,
      frequencyHz: nextPower ? 1985 : 0 
    });
    
    if (nextPower) {
      setConsoleMsg("Primary armature energized. Coils tuning to 1985 Hz. Coherence achieved. (Engram manifold listening)");
      gameState.addDialogueLog("System", "Armature humming at 1985 Hz. Resonance threshold crossed.");
      gameState.updateState({ 
        currentSpeaker: 'uriel',
        beatStage: 3 
      });
      gameState.addDialogueLog("Uriel (Ningal)", "You have opened the ratio. The boundary is responsive. I can hear you.", true);
    } else {
      setConsoleMsg("Armature de-energized. Field decayed.");
      gameState.addDialogueLog("System", "Resonance field collapsed.");
    }
  };

  return (
    <div className="absolute inset-0 bg-[#060c08] text-[#3fc1c9] font-mono z-50 p-6 flex flex-col scanlines crt-flicker select-none">
      {/* Top Header */}
      <div className="flex items-center justify-between border-b border-[#3fc1c9]/30 pb-3 mb-4">
        <div className="flex items-center space-x-3">
          <Terminal className="w-5 h-5 text-[#3fc1c9]" />
          <h1 className="text-sm font-bold tracking-widest">DEVERAUX ARCHIVE — ENGRAM MANIFOLD v4.2</h1>
        </div>
        <div className="flex items-center space-x-4">
          <div className="flex items-center space-x-2 text-xs">
            <Wifi className={`w-4 h-4 ${isAttending ? 'text-[#3fc1c9] animate-pulse' : 'text-red-500'}`} />
            <span>STATUS: {isAttending ? 'ATTENDING' : 'QUIET'} | MANIFOLD: LIVE</span>
          </div>
          <button 
            onClick={() => gameState.updateState({ terminalActive: false })}
            className="p-1 border border-[#3fc1c9]/30 hover:bg-[#3fc1c9]/25 hover:text-white transition-colors rounded"
            title="Exit Terminal"
          >
            <X className="w-4 h-4" />
          </button>
        </div>
      </div>

      {/* Main Content Split */}
      <div className="flex-1 grid grid-cols-12 gap-6 overflow-hidden">
        {/* Left: Engram Controls + Memory Blocks */}
        <div className="col-span-4 border-r border-[#3fc1c9]/30 pr-6 flex flex-col">
          {/* Recall / Search */}
          <div className="mb-4">
            <div className="flex items-center gap-2 mb-2">
              <Search className="w-4 h-4" />
              <span className="text-xs font-bold uppercase tracking-wider text-[#3fc1c9]/70">Query Engram Manifold</span>
            </div>
            <div className="flex gap-2">
              <input
                value={query}
                onChange={(e) => setQuery(e.target.value)}
                className="flex-1 bg-black/40 border border-[#3fc1c9]/30 rounded px-2 py-1 text-xs focus:outline-none focus:border-[#3fc1c9]"
                placeholder="recall query..."
              />
              <button
                onClick={doRecall}
                disabled={isLoading}
                className="px-3 py-1 bg-[#3fc1c9]/10 border border-[#3fc1c9]/40 hover:bg-[#3fc1c9]/20 text-xs rounded"
              >
                RECALL
              </button>
              <button
                onClick={loadRecentMemories}
                disabled={isLoading}
                className="px-3 py-1 border border-[#3fc1c9]/30 text-xs rounded hover:bg-[#3fc1c9]/10"
              >
                RECENT
              </button>
            </div>
          </div>

          {/* Memory Blocks from Engram */}
          <div className="flex-1 overflow-auto">
            <h2 className="text-xs font-bold uppercase tracking-wider mb-2 text-[#3fc1c9]/70 flex items-center gap-2">
              <FileText className="w-4 h-4" /> .leg Resonance Blocks (from Engram MCP)
            </h2>
            {memories.length === 0 && (
              <div className="text-xs opacity-60 italic">No memories loaded. Start the bridge server.</div>
            )}
            <div className="space-y-1.5">
              {memories.map((mem) => (
                <button
                  key={mem.id}
                  onClick={() => handleBlockClick(mem)}
                  className={`w-full text-left p-2 rounded border text-[11px] transition-colors ${
                    selectedId === mem.id 
                      ? 'bg-[#3fc1c9]/20 border-[#3fc1c9]' 
                      : 'border-[#3fc1c9]/20 hover:bg-[#3fc1c9]/10'
                  }`}
                >
                  <div className="font-semibold truncate">{mem.title}</div>
                  <div className="text-[10px] opacity-70 line-clamp-2 mt-0.5">{mem.content.substring(0, 120)}…</div>
                </button>
              ))}
            </div>
          </div>

          {/* Remember into Engram (demo of non-flat persistent memory) */}
          <div className="border-t border-[#3fc1c9]/30 pt-3 mt-3">
            <div className="flex items-center gap-2 mb-1.5">
              <Save className="w-4 h-4" />
              <span className="text-xs font-bold uppercase tracking-wider text-[#3fc1c9]/70">Remember into Manifold</span>
            </div>
            <input
              value={rememberConcept}
              onChange={(e) => setRememberConcept(e.target.value)}
              className="w-full mb-1 bg-black/40 border border-[#3fc1c9]/30 rounded px-2 py-1 text-[10px] focus:outline-none"
              placeholder="concept name (snake_case)"
            />
            <textarea
              value={rememberText}
              onChange={(e) => setRememberText(e.target.value)}
              rows={2}
              className="w-full bg-black/40 border border-[#3fc1c9]/30 rounded px-2 py-1 text-[10px] focus:outline-none resize-y"
              placeholder="New observation / player note / lore to store as .leg block..."
            />
            <button
              onClick={doRemember}
              disabled={isLoading || !rememberText.trim()}
              className="mt-1 w-full py-1.5 text-xs border border-[#3fc1c9] hover:bg-[#3fc1c9]/10 rounded disabled:opacity-50"
            >
              STORE IN ENGRAM (mcp_engram_remember)
            </button>
          </div>

          {/* Machine Controls (kept) */}
          <div className="border-t border-[#3fc1c9]/30 pt-4 mt-4 space-y-4">
            <h2 className="text-xs font-bold uppercase tracking-wider text-[#3fc1c9]/70">Armature Modulation</h2>
            {!isAttending && (
              <div className="border border-red-500/30 bg-red-950/20 text-red-400 p-3 rounded text-xs leading-relaxed">
                Warning: Comm interface suspended. Offline system quiet. Check desk drawer for hardware bypass.
              </div>
            )}
            <button
              onClick={handlePowerCoil}
              disabled={!isAttending}
              className={`w-full py-3 px-4 rounded border text-xs font-bold tracking-widest flex items-center justify-center space-x-3 transition-all ${
                !isAttending 
                  ? 'opacity-40 cursor-not-allowed border-[#3fc1c9]/20'
                  : machinePowered
                    ? 'bg-[#3fc1c9] text-black border-[#3fc1c9] hover:bg-[#3fc1c9]/80 shadow-[0_0_15px_rgba(63,193,201,0.4)]'
                    : 'border-[#3fc1c9] hover:bg-[#3fc1c9]/20 text-[#3fc1c9]'
              }`}
            >
              <Power className="w-4 h-4" />
              <span>{machinePowered ? 'POWER DE-COUPLE' : 'POWER COIL ASSEMBLY'}</span>
            </button>
            {machinePowered && (
              <div className="text-center animate-pulse">
                <span className="text-xs text-[#3fc1c9] font-bold">1985 Hz PHASE-LOCKED — MANIFOLD ATTENTIVE</span>
              </div>
            )}
          </div>
        </div>

        {/* Right: Selected .leg Content + Status */}
        <div className="col-span-8 flex flex-col overflow-hidden bg-black/45 border border-[#3fc1c9]/30 rounded p-4 relative">
          <div className="absolute top-2 right-2 text-[10px] text-[#3fc1c9]/40">TERM-MON-01 • ENGRAM LIVE</div>
          
          {selected ? (
            <div className="flex flex-col h-full overflow-hidden">
              <div className="border-b border-[#3fc1c9]/20 pb-2 mb-3">
                <h3 className="text-sm font-bold text-white">{selected.title}</h3>
                <span className="text-[10px] text-[#3fc1c9]/60">Live .leg block from Engram MCP</span>
              </div>
              <div className="flex-1 overflow-y-auto text-xs leading-relaxed pr-2 space-y-3 font-victorian select-text whitespace-pre-wrap">
                {selected.content}
              </div>
            </div>
          ) : (
            <div className="flex-1 flex flex-col justify-center items-center text-center opacity-65 p-6">
              <Terminal className="w-12 h-12 text-[#3fc1c9]/40 mb-3" />
              <p className="text-xs max-w-sm leading-relaxed">
                Query or load .leg blocks from the Engram manifold on the left.<br />
                These are real persistent memory blocks — non-flat index, queryable, append-only.
              </p>
            </div>
          )}

          {/* Lower Status */}
          <div className="border-t border-[#3fc1c9]/30 pt-3 mt-4 text-[10px] text-[#3fc1c9]/60 flex items-center space-x-2">
            <span className="text-[#3fc1c9] font-bold">&gt;</span>
            <span className="truncate">{consoleMsg}</span>
          </div>
        </div>
      </div>
    </div>
  );
}
