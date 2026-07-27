import React, { useState, useEffect } from 'react';
import { useGameState, gameState } from './engine/gameState';
import RoomView from './components/RoomView';
import DialoguePanel from './components/DialoguePanel';
import TerminalView from './components/TerminalView';
import { motion, AnimatePresence } from 'framer-motion';
import { Sparkles, Terminal as TermIcon, Briefcase, Eye, HelpCircle, X, ShieldAlert } from 'lucide-react';

export default function App() {
  const state = useGameState();
  const [showIntro, setShowIntro] = useState(false);
  const [settingsOpen, setSettingsOpen] = useState(false);
  
  // Load AI configuration from localStorage
  const [settings, setSettings] = useState(() => {
    const saved = localStorage.getItem('aetheric_settings');
    return saved ? JSON.parse(saved) : {
      apiMode: 'cloud', // 'cloud' | 'local'
      geminiApiKey: '',
      ollamaUrl: 'http://localhost:11434',
      ollamaModel: 'gemma3:4b'
    };
  });

  // Save settings on changes
  useEffect(() => {
    localStorage.setItem('aetheric_settings', JSON.stringify(settings));
  }, [settings]);

  // Initial welcome message
  useEffect(() => {
    if (!showIntro) {
      gameState.addDialogueLog("System", "Recon link established. You are standing in the Richmond House kitchen. Moving shadows and a faint electrical hum echo from the hallways.");
    }
  }, [showIntro]);

  const handleSaveSettings = (updates) => {
    setSettings(prev => ({ ...prev, ...updates }));
  };

  return (
    <div className="relative w-screen h-screen bg-[#0b0c10] text-[#e6e8eb] flex overflow-hidden font-sans select-none">
      
      {/* Intro Screen */}
      <AnimatePresence>
        {showIntro && (
          <motion.div 
            initial={{ opacity: 1 }}
            exit={{ opacity: 0 }}
            transition={{ duration: 1 }}
            className="absolute inset-0 bg-[#060c08] z-50 flex flex-col justify-center items-center p-6 text-center select-none scanlines"
          >
            <motion.div
              initial={{ scale: 0.95, opacity: 0 }}
              animate={{ scale: 1, opacity: 1 }}
              transition={{ delay: 0.3, duration: 1 }}
              className="max-w-2xl space-y-6"
            >
              <h1 className="text-4xl md:text-5xl font-serif text-[#c8a96e] tracking-wider uppercase">
                The Aetheric Engine
              </h1>
              <p className="text-xs tracking-widest text-[#959ea6] uppercase font-mono">
                Deveraux Archive Virtual Interface
              </p>
              
              <div className="w-16 h-0.5 bg-[#c8a96e]/30 mx-auto my-4"></div>
              
              <p className="text-sm md:text-base text-[#e6e8eb] leading-relaxed font-victorian italic">
                "Initiating virtual recon of Richmond House (Surrey, September 1856). 
                The local field is active at 1985 Hz. You are navigating the ground floor. 
                Move through the rooms and communicate with the reconstructed entities to gather evidence."
              </p>

              <div className="pt-8">
                <button
                  onClick={() => setShowIntro(false)}
                  className="bg-[#c8a96e] text-black font-bold tracking-widest text-xs px-8 py-3.5 rounded hover:bg-[#b09259] transition-all duration-300 shadow-[0_0_15px_var(--accent-gold-glow)]"
                >
                  LAUNCH VIRTUAL SIMULATION
                </button>
              </div>
            </motion.div>
          </motion.div>
        )}
      </AnimatePresence>

      {/* Main Layout Split */}
      <div className="flex-1 grid grid-cols-12 h-full w-full">
        {/* Left Side: Game Screen (Room viewport / Terminal) */}
        <div className="col-span-8 relative h-full border-r border-[#c8a96e]/10">
          <RoomView gameState={state} />

          {/* Terminal Screen Overlay */}
          <AnimatePresence>
            {state.terminalActive && (
              <motion.div
                initial={{ opacity: 0, y: 15 }}
                animate={{ opacity: 1, y: 0 }}
                exit={{ opacity: 0, y: 15 }}
                transition={{ duration: 0.4 }}
                className="absolute inset-0 z-40"
              >
                <TerminalView gameState={state} />
              </motion.div>
            )}
          </AnimatePresence>

          {/* Quick HUD Bar */}
          <div className="absolute bottom-4 left-4 right-4 flex justify-between items-center z-30 pointer-events-none">
            {/* Inventory HUD */}
            <div className="flex items-center space-x-3 pointer-events-auto bg-[#15181f]/90 border border-[#c8a96e]/20 rounded py-2 px-3 text-xs shadow-lg glass-panel">
              <Briefcase className="w-4 h-4 text-[#c8a96e]" />
              <span className="font-bold text-[#c8a96e]/80 uppercase tracking-widest text-[10px]">Inventory:</span>
              <div className="flex space-x-2">
                {state.inventory.length === 0 ? (
                  <span className="text-[#959ea6] italic">Empty</span>
                ) : (
                  state.inventory.map(item => (
                    <span 
                      key={item} 
                      className="bg-[#c8a96e]/10 border border-[#c8a96e]/30 px-2 py-0.5 rounded text-[10px] text-[#e6e8eb]"
                    >
                      {item === 'modem' ? 'Telephone Modem' : item === 'contact_mic' ? 'Contact Mic' : item}
                    </span>
                  ))
                )}
              </div>
            </div>
          </div>
        </div>

        {/* Right Side: Dialogue Panel */}
        <div className="col-span-4 h-full relative">
          <DialoguePanel 
            gameState={state} 
            settings={settings}
            openSettings={() => setSettingsOpen(true)}
          />
        </div>
      </div>

      {/* Settings Modal */}
      <AnimatePresence>
        {settingsOpen && (
          <motion.div 
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            exit={{ opacity: 0 }}
            className="absolute inset-0 bg-black/85 z-50 flex items-center justify-center p-4"
          >
            <motion.div 
              initial={{ scale: 0.95 }}
              animate={{ scale: 1 }}
              exit={{ scale: 0.95 }}
              className="w-full max-w-md glass-panel p-6 border border-[#c8a96e]/30 relative"
            >
              <button 
                onClick={() => setSettingsOpen(false)}
                className="absolute top-4 right-4 text-[#959ea6] hover:text-[#e6e8eb] transition-colors"
              >
                <X className="w-5 h-5" />
              </button>

              <h2 className="text-lg font-bold text-[#c8a96e] mb-4 flex items-center space-x-2">
                <Sparkles className="w-5 h-5" />
                <span>AI Connection Configuration</span>
              </h2>

              <div className="space-y-4 text-sm">
                {/* API Mode */}
                <div>
                  <label className="block text-xs font-bold text-[#959ea6] mb-1.5 uppercase tracking-wider">Connection Mode</label>
                  <div className="grid grid-cols-2 gap-2">
                    <button
                      onClick={() => handleSaveSettings({ apiMode: 'cloud' })}
                      className={`py-2 px-3 rounded border text-xs font-bold transition-all ${
                        settings.apiMode === 'cloud'
                          ? 'bg-[#c8a96e]/10 border-[#c8a96e] text-[#e6e8eb]'
                          : 'border-[#c8a96e]/15 hover:border-[#c8a96e]/40 text-[#959ea6]'
                      }`}
                    >
                      Google Gemini (Cloud)
                    </button>
                    <button
                      onClick={() => handleSaveSettings({ apiMode: 'local' })}
                      className={`py-2 px-3 rounded border text-xs font-bold transition-all ${
                        settings.apiMode === 'local'
                          ? 'bg-[#c8a96e]/10 border-[#c8a96e] text-[#e6e8eb]'
                          : 'border-[#c8a96e]/15 hover:border-[#c8a96e]/40 text-[#959ea6]'
                      }`}
                    >
                      Ollama (Local)
                    </button>
                  </div>
                </div>

                {settings.apiMode === 'cloud' ? (
                  /* Gemini Settings */
                  <div>
                    <label className="block text-xs font-bold text-[#959ea6] mb-1.5 uppercase tracking-wider">Gemini API Key</label>
                    <input
                      type="password"
                      value={settings.geminiApiKey}
                      onChange={(e) => handleSaveSettings({ geminiApiKey: e.target.value })}
                      placeholder="Paste Gemini API Key (from Google AI Studio)"
                      className="w-full bg-[#0b0c10] border border-[#c8a96e]/20 rounded py-2 px-3 text-xs text-[#e6e8eb] focus:outline-none focus:border-[#c8a96e]"
                    />
                    <span className="text-[10px] text-[#959ea6] mt-1.5 block leading-relaxed">
                      API keys are saved locally in your browser. Cloud connection is free via Google AI Studio keys.
                    </span>
                  </div>
                ) : (
                  /* Ollama Settings */
                  <div className="space-y-3">
                    <div>
                      <label className="block text-xs font-bold text-[#959ea6] mb-1 uppercase tracking-wider">Ollama Endpoint URL</label>
                      <input
                        type="text"
                        value={settings.ollamaUrl}
                        onChange={(e) => handleSaveSettings({ ollamaUrl: e.target.value })}
                        className="w-full bg-[#0b0c10] border border-[#c8a96e]/20 rounded py-2 px-3 text-xs text-[#e6e8eb] focus:outline-none focus:border-[#c8a96e]"
                      />
                    </div>
                    <div>
                      <label className="block text-xs font-bold text-[#959ea6] mb-1 uppercase tracking-wider">Model Name</label>
                      <input
                        type="text"
                        value={settings.ollamaModel}
                        onChange={(e) => handleSaveSettings({ ollamaModel: e.target.value })}
                        className="w-full bg-[#0b0c10] border border-[#c8a96e]/20 rounded py-2 px-3 text-xs text-[#e6e8eb] focus:outline-none focus:border-[#c8a96e]"
                      />
                    </div>
                  </div>
                )}
                
                {/* Warning note */}
                <div className="flex space-x-2 border border-[#c8a96e]/10 bg-[#15181f]/40 p-3 rounded text-[11px] text-[#959ea6] leading-relaxed">
                  <ShieldAlert className="w-5 h-5 text-[#c8a96e] flex-shrink-0" />
                  <span>
                    To run locally with Ollama, make sure Ollama is open and configured to allow CORS requests by running: 
                    <code className="bg-black/60 px-1 py-0.5 rounded text-[#e6e8eb] ml-1">OLLAMA_ORIGINS="*" ollama serve</code>.
                  </span>
                </div>
              </div>

              <div className="mt-6 flex justify-end">
                <button
                  onClick={() => setSettingsOpen(false)}
                  className="bg-[#c8a96e] hover:bg-[#b09259] text-black font-bold text-xs px-6 py-2 rounded transition-colors"
                >
                  SAVE CONFIG
                </button>
              </div>
            </motion.div>
          </motion.div>
        )}
      </AnimatePresence>

    </div>
  );
}
