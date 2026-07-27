// Simple pub-sub game state manager for React re-rendering
class GameState {
  constructor() {
    this.listeners = new Set();
    
    // Initial state
    this.state = {
      currentRoom: 'richmond_kitchen',
      inventory: ['modem', 'contact_mic'], // Pre-equipped for virtual link
      readFiles: [], 
      notesFound: [], 
      stance: {
        materialism: 0, 
        grace: 0,       
      },
      terminalActive: false, 
      machinePowered: true, // Start powered up for active dialogue
      frequencyHz: 1985, 
      dialogueLogs: [], 
      currentSpeaker: null, 
      beatStage: 3, 
    };
  }

  getState() {
    return this.state;
  }

  subscribe(listener) {
    this.listeners.add(listener);
    return () => this.listeners.delete(listener);
  }

  emit() {
    for (const listener of this.listeners) {
      listener({ ...this.state });
    }
  }

  updateState(updater) {
    if (typeof updater === 'function') {
      this.state = updater(this.state);
    } else {
      this.state = { ...this.state, ...updater };
    }
    this.emit();
  }

  // Helper Actions
  moveTo(room) {
    this.updateState({ currentRoom: room });
  }

  addToInventory(item) {
    this.updateState(state => {
      if (state.inventory.includes(item)) return state;
      return { ...state, inventory: [...state.inventory, item] };
    });
  }

  addDialogueLog(sender, message, isAI = false) {
    this.updateState(state => ({
      ...state,
      dialogueLogs: [...state.dialogueLogs, { sender, message, isAI, timestamp: Date.now() }]
    }));
  }

  adjustStance(axis, amount) {
    this.updateState(state => ({
      ...state,
      stance: {
        ...state.stance,
        [axis]: state.stance[axis] + amount
      }
    }));
  }
}

export const gameState = new GameState();

// React hook hook wrapper
import { useState, useEffect } from 'react';

export function useGameState() {
  const [state, setState] = useState(gameState.getState());

  useEffect(() => {
    return gameState.subscribe(setState);
  }, []);

  return state;
}
