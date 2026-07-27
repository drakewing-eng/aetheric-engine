import React, { useState, useRef, useEffect } from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import { gameState } from '../engine/gameState';
import { generateDialogue } from '../engine/aiService';
import { CHARACTERS } from '../engine/vows';
import { Send, Settings, Sparkles } from 'lucide-react';

export default function DialoguePanel({ gameState: state, settings, openSettings }) {
  const { dialogueLogs, currentSpeaker } = state;
  const [inputValue, setInputValue] = useState('');
  const [isGenerating, setIsGenerating] = useState(false);
  const [errorMsg, setErrorMsg] = useState('');
  const chatEndRef = useRef(null);

  // Auto-scroll to bottom
  useEffect(() => {
    chatEndRef.current?.scrollIntoView({ behavior: 'smooth' });
  }, [dialogueLogs, isGenerating]);

  const activeChar = currentSpeaker ? CHARACTERS[currentSpeaker] : null;

  const handleSend = async (e) => {
    e.preventDefault();
    if (!inputValue.trim() || isGenerating) return;

    const message = inputValue.trim();
    setInputValue('');
    setErrorMsg('');

    // Append Operator's message to log
    gameState.addDialogueLog("Operator", message);

    if (!currentSpeaker) {
      gameState.addDialogueLog("System", "There is no active speaker. Inspect the computer or open the window to seek resonance.");
      return;
    }

    setIsGenerating(true);

    try {
      // Generate response from the LLM
      const reply = await generateDialogue({
        speaker: currentSpeaker,
        messageHistory: dialogueLogs.slice(-10), // Send last 10 logs for context
        userMessage: message,
        settings
      });

      // Append character's response
      gameState.addDialogueLog(activeChar.name, reply, true);

      // Evaluate stance adjustments based on player's message keywords
      evaluateStanceImpact(message);

    } catch (e) {
      console.error(e);
      setErrorMsg(e.message || "Failed to generate dialogue.");
    } finally {
      setIsGenerating(false);
    }
  };

  const evaluateStanceImpact = (msg) => {
    const text = msg.toLowerCase();
    
    // Quick heuristic adjustments
    // Materialism keywords
    if (text.match(/physics|wire|current|coil|measurement|ampere|volts|inductor|frequency|data|logic/)) {
      gameState.adjustStance('materialism', 1);
    }
    // Grace keywords
    if (text.match(/soul|prayer|angel|presence|love|grace|spirit|divine|god|covenant|sin/)) {
      gameState.adjustStance('grace', 1);
    }
  };

  return (
    <div className="w-full h-full flex flex-col glass-panel p-4 overflow-hidden border-l border-[#c8a96e]/15">
      {/* Speaker Header */}
      <div className="flex items-center justify-between pb-3 border-b border-[#c8a96e]/15 mb-3">
        <div>
          {activeChar ? (
            <>
              <h2 className="text-md font-bold" style={{ color: activeChar.color }}>
                {activeChar.name}
              </h2>
              <p className="text-xs text-[#959ea6] font-serif italic">{activeChar.title}</p>
            </>
          ) : (
            <>
              <h2 className="text-md font-bold text-[#e6e8eb]">Observations</h2>
              <p className="text-xs text-[#959ea6]">Approach a character and press [E] to speak</p>
            </>
          )}
        </div>
        
        {/* Settings button */}
        <button 
          onClick={openSettings}
          className="p-1.5 rounded-full border border-rgba(200, 169, 110, 0.2) hover:bg-[#c8a96e]/10 transition-colors"
          title="AI Settings"
        >
          <Settings className="w-4 h-4 text-[#c8a96e]" />
        </button>
      </div>

      {/* Message List */}
      <div className="flex-1 overflow-y-auto pr-1 space-y-4 mb-4 font-sans text-sm leading-relaxed">
        <AnimatePresence initial={false}>
          {dialogueLogs.map((log, idx) => {
            const isRowan = log.sender === 'Operator';
            const isSystem = log.sender === 'System';
            const charConfig = !isRowan && !isSystem ? Object.values(CHARACTERS).find(c => c.name === log.sender) : null;
            
            let nameColor = '#e6e8eb';
            if (isRowan) nameColor = '#c8a96e';
            else if (charConfig) nameColor = charConfig.color;
            else if (isSystem) nameColor = '#959ea6';

            return (
              <motion.div 
                key={idx}
                initial={{ opacity: 0, y: 10 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ duration: 0.3 }}
                className={`flex flex-col ${isRowan ? 'items-end' : 'items-start'}`}
              >
                <span className="text-xs font-bold mb-1" style={{ color: nameColor }}>
                  {log.sender}
                </span>
                <div 
                  className={`max-w-[85%] rounded-lg p-3 ${
                    isRowan 
                      ? 'bg-[#c8a96e]/10 border border-[#c8a96e]/20 text-[#e6e8eb]' 
                      : isSystem
                        ? 'bg-transparent text-[#959ea6] border-l-2 border-[#959ea6]/30 pl-3 italic'
                        : 'bg-[#15181f]/80 border border-[#c8a96e]/10 text-[#e6e8eb]'
                  }`}
                  style={charConfig ? { borderLeft: `3px solid ${charConfig.color}` } : {}}
                >
                  <p className={charConfig?.name === 'Euron' || charConfig?.name === 'Uriel (Ningal)' ? 'font-serif italic' : ''}>
                    {log.message}
                  </p>
                </div>
              </motion.div>
            );
          })}
        </AnimatePresence>

        {/* Loading indicator */}
        {isGenerating && (
          <motion.div 
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            className="flex items-center space-x-2 text-xs text-[#959ea6] italic"
          >
            <Sparkles className="w-3.5 h-3.5 text-[#3fc1c9] animate-spin" />
            <span>The air quivers as the resonance gathers...</span>
          </motion.div>
        )}

        {/* Error message */}
        {errorMsg && (
          <div className="bg-red-950/30 border border-red-500/30 rounded p-3 text-xs text-red-400">
            {errorMsg}
          </div>
        )}

        <div ref={chatEndRef} />
      </div>

      {/* Input Form */}
      <form onSubmit={handleSend} className="flex items-center space-x-2 pt-3 border-t border-[#c8a96e]/15">
        <input 
          type="text" 
          value={inputValue}
          onChange={(e) => setInputValue(e.target.value)}
          disabled={isGenerating || !currentSpeaker}
          placeholder={currentSpeaker ? `Address ${activeChar?.name || 'speaker'}...` : 'Walk near a character and press [E] to talk...'}
          className="flex-1 bg-[#0b0c10] border border-[#c8a96e]/15 rounded py-2 px-3 text-sm text-[#e6e8eb] focus:outline-none focus:border-[#c8a96e] transition-colors disabled:opacity-50"
        />
        <button 
          type="submit"
          disabled={isGenerating || !inputValue.trim() || !currentSpeaker}
          className="bg-[#c8a96e] hover:bg-[#b09259] text-black font-bold p-2.5 rounded transition-colors disabled:opacity-40 disabled:cursor-not-allowed"
        >
          <Send className="w-4 h-4" />
        </button>
      </form>
    </div>
  );
}
