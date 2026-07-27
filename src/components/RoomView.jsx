import React, { useEffect, useRef, useState } from 'react';
import { gameState } from '../engine/gameState';
import { CHARACTERS } from '../engine/vows';
import { Eye, HelpCircle } from 'lucide-react';

// ─── Isometric Map Grid (derived from RICHMOND_HOUSE_FLOOR_PLAN.md) ─────────
// 0 = Void/Floor (Outside), 1 = Wood Floor (Room), 2 = Outer Stone Wall, 3 = Inner Wood Wall, 4 = Engine Column
const MAP_SIZE = 14;
const MAP_GRID = [
  [2,2,2,2,2,2,2,2,2,2,2,2,2,2], // Row 0: North Outer Wall
  [2,1,1,1,1,2,0,0,2,1,1,1,1,2], // Row 1: Workshop (left), Conservatory (right)
  [2,1,1,1,1,2,0,0,2,1,1,1,1,2], // Row 2:
  [2,1,1,1,1,2,0,0,2,1,1,1,1,2], // Row 3:
  [2,1,1,0,1,2,2,2,2,1,1,0,1,2], // Row 4: Workshop exit (Col 3), Conservatory exit (Col 11)
  [2,1,1,1,1,1,1,1,1,1,1,1,1,2], // Row 5: Gallery North
  [2,1,1,1,1,1,1,1,1,1,1,4,1,2], // Row 6: Gallery (Engine column at Col 11, Row 6)
  [2,1,1,1,1,1,1,1,1,1,1,4,1,2], // Row 7: Gallery (Engine column at Col 11, Row 7)
  [2,1,1,0,1,2,2,2,0,2,2,0,1,2], // Row 8: Gallery exits: Kitchen (Col 3), Hall (Col 8), Drawing (Col 11)
  [2,1,1,1,1,2,1,1,1,2,1,1,1,2], // Row 9: Kitchen (left), Hall (center), Drawing Room (right)
  [2,1,1,1,1,0,1,1,1,0,1,1,1,2], // Row 10: Kitchen/Hall doorway (Row 10, Col 5), Drawing/Hall doorway (Row 10, Col 9)
  [2,1,1,1,1,2,1,1,1,2,1,1,1,2], // Row 11:
  [2,1,1,1,1,2,1,1,1,2,1,1,1,2], // Row 12:
  [2,2,2,2,2,2,2,2,2,2,2,2,2,2]  // Row 13: South Outer Wall
];

// Map coordinates to Room Name Labels
function getRoomLabel(x, y) {
  const gx = Math.floor(x);
  const gy = Math.floor(y);
  if (gy < 5 && gx < 5) return "Workshop";
  if (gy < 5 && gx >= 8) return "Conservatory";
  if (gy >= 5 && gy <= 8) return "The Gallery";
  if (gy > 8 && gx < 5) return "Kitchen";
  if (gy > 8 && gx >= 5 && gx <= 8) return "Entrance Hall";
  if (gy > 8 && gx >= 9) return "Drawing Room";
  return "Richmond House";
}

// ─── Playable Entities (NPCs, Furniture & Items) ───────────────────────────
const ENTITIES = [
  // Characters
  {
    id: 'bell',
    type: 'npc',
    x: 10.5,
    y: 6.5,
    label: 'Dr. Ignatius Bell',
    color: '#d4af37',
    portrait: '/portrait_bell.jpg',
    description: 'Pacing erratically. Ink stains on fingers.',
    paceMinX: 9.5,
    paceMaxX: 12.5,
    paceMinY: 5.5,
    paceMaxY: 7.5,
    vx: 0.02,
    vy: 0,
    bob: 0
  },
  {
    id: 'amara',
    type: 'npc',
    x: 12.2,
    y: 7.5,
    label: 'Amara Finch',
    color: '#a020f0',
    portrait: '/portrait_amara.jpg',
    description: 'Listening closely near the Gallery wall.',
    paceMinX: 12.0,
    paceMaxX: 12.5,
    paceMinY: 7.0,
    paceMaxY: 8.0,
    vx: 0,
    vy: 0.005,
    bob: 0
  },
  {
    id: 'rooke',
    type: 'npc',
    x: 2.5,
    y: 2.5,
    label: 'Thomas Rooke',
    color: '#e2725b',
    portrait: '/portrait_rooke.jpg',
    description: 'Adjusting structural fittings.',
    paceMinX: 1.5,
    paceMaxX: 3.5,
    paceMinY: 1.5,
    paceMaxY: 3.5,
    vx: 0.015,
    vy: 0.01,
    bob: 0
  },
  {
    id: 'clara',
    type: 'npc',
    x: 7.5,
    y: 11.5,
    label: 'Clara Keene',
    color: '#3fc1c9',
    portrait: '/portrait_clara.jpg',
    description: 'Observing details and cleaning.',
    paceMinX: 6.5,
    paceMaxX: 8.5,
    paceMinY: 9.5,
    paceMaxY: 12.5,
    vx: 0.01,
    vy: 0.015,
    bob: 0
  },
  {
    id: 'selina',
    type: 'npc',
    x: 11.5,
    y: 11.5,
    label: 'Selina Deveraux',
    color: '#ff4d4d',
    portrait: '/portrait_selina.jpg',
    description: 'Reading letter correspondence.',
    paceMinX: 10.5,
    paceMaxX: 12.5,
    paceMinY: 9.5,
    paceMaxY: 12.5,
    vx: 0.005,
    vy: 0.005,
    bob: 0
  },

  // Interactive Furniture & Items
  {
    id: 'engine',
    type: 'engine',
    x: 11.5,
    y: 6.5,
    label: 'Aetheric Engine',
    color: '#3fc1c9',
    description: 'The 7-foot brass armature humming at 1985 Hz. Press [E] for terminal.',
    action: () => {
      gameState.updateState({ terminalActive: true });
      gameState.addDialogueLog("System", "Engine coupled. Terminals operational.");
    }
  },
  {
    id: 'hall_table',
    type: 'item',
    x: 7.5,
    y: 9.5,
    label: 'Hall Table & Cranford Book',
    color: '#8b5a2b',
    description: 'Mahogany table holding correspondence and a worn copy of Mrs. Gaskell\'s Cranford.',
    action: () => {
      gameState.addDialogueLog("System", "You inspect the book. Inside: 'To Clara, with respect, N.R. August 1856'. A letter next to it mentions Edward Pember's estate.");
    }
  },
  {
    id: 'workshop_bench',
    type: 'item',
    x: 3.5,
    y: 1.5,
    label: 'Workshop Workbench',
    color: '#8b5a2b',
    description: 'Tools, copper wiring, and structural warning notes.',
    action: () => {
      gameState.addDialogueLog("System", "Rooke's notes: 'Coils are overstressed. The primary armature shows warning cracks at 1985 Hz.'");
    }
  }
];

export default function RoomView({ gameState: state }) {
  const containerRef = useRef(null);
  const canvasRef = useRef(null);

  // Player position (Starting in the Kitchen, Y=10.5, X=2.5)
  const playerPos = useRef({ x: 2.5, y: 10.5 });
  const playerDir = useRef({ x: 0, y: 1 });
  const playerBob = useRef(0);

  // Active key state
  const keys = useRef({});
  const [activeInteractive, setActiveInteractive] = useState(null);
  const [currentRoomLabel, setCurrentRoomLabel] = useState('Kitchen');

  // SVG-based reference art panel (toggled by player)
  const [activeRefArt, setActiveRefArt] = useState(null);

  // Ref to hold the current active interactive entity so the listener doesn't need to rebuild
  const activeInteractiveRef = useRef(null);
  useEffect(() => {
    activeInteractiveRef.current = activeInteractive;
  }, [activeInteractive]);

  useEffect(() => {
    const handleKeyDown = (e) => {
      if (document.activeElement?.tagName === 'INPUT' || document.activeElement?.tagName === 'TEXTAREA') {
        return;
      }
      keys.current[e.key.toLowerCase()] = true;

      // Proximity interaction [E]
      if (e.key.toLowerCase() === 'e' && activeInteractiveRef.current) {
        triggerInteraction(activeInteractiveRef.current);
      }
    };

    const handleKeyUp = (e) => {
      keys.current[e.key.toLowerCase()] = false;
    };

    window.addEventListener('keydown', handleKeyDown);
    window.addEventListener('keyup', handleKeyUp);
    return () => {
      window.removeEventListener('keydown', handleKeyDown);
      window.removeEventListener('keyup', handleKeyUp);
    };
  }, []); // Only register once

  const triggerInteraction = (entity) => {
    if (entity.type === 'npc') {
      const charConfig = CHARACTERS[entity.id];
      if (charConfig) {
        gameState.updateState({ currentSpeaker: entity.id });
        gameState.addDialogueLog("System", `Speaking to ${charConfig.name}.`);
        // Show reference art of the character as visual guide
        setActiveRefArt(`/portrait_${entity.id}.jpg`);
      }
    } else if (entity.action) {
      entity.action();
    }
  };

  useEffect(() => {
    const canvas = canvasRef.current;
    if (!canvas) return;
    const ctx = canvas.getContext('2d');
    let animFrameId;

    // Isometric math constants
    const tileWidth = 64;
    const tileHeight = 32;
    const moveSpeedBase = 0.06;

    const updatePhysics = () => {
      const isShift = keys.current['shift'];
      const speedMultiplier = isShift ? 1.6 : 1.0;
      const speed = moveSpeedBase * speedMultiplier;

      let dx = 0;
      let dy = 0;

      // Handle standard WASD key vectors
      if (keys.current['w'] || keys.current['arrowup']) {
        dx -= speed;
        dy -= speed;
      }
      if (keys.current['s'] || keys.current['arrowdown']) {
        dx += speed;
        dy += speed;
      }
      if (keys.current['a'] || keys.current['arrowleft']) {
        dx -= speed;
        dy += speed;
      }
      if (keys.current['d'] || keys.current['arrowright']) {
        dx += speed;
        dy -= speed;
      }

      if (dx !== 0 || dy !== 0) {
        // Update player direction facing
        playerDir.current = { x: Math.sign(dx), y: Math.sign(dy) };
        
        // Bob character
        playerBob.current += 0.15;

        // Collision detection: Check walls in grid
        const buffer = 0.25;
        const newX = playerPos.current.x + dx;
        const newY = playerPos.current.y + dy;

        const checkCellX = Math.floor(newX + (dx > 0 ? buffer : -buffer));
        const checkCellY = Math.floor(newY + (dy > 0 ? buffer : -buffer));

        // Slide check along X
        if (checkCellX >= 0 && checkCellX < MAP_SIZE) {
          const val = MAP_GRID[Math.floor(playerPos.current.y)][checkCellX];
          if (val === 1 || val === 0) { // Walkable rooms or void crossings
            playerPos.current.x = newX;
          }
        }
        // Slide check along Y
        if (checkCellY >= 0 && checkCellY < MAP_SIZE) {
          const val = MAP_GRID[checkCellY][Math.floor(playerPos.current.x)];
          if (val === 1 || val === 0) {
            playerPos.current.y = newY;
          }
        }
      } else {
        playerBob.current = 0; // stop bobbing
      }

      // ─── NPC Pacing AI ───
      ENTITIES.forEach(entity => {
        if (entity.type !== 'npc') return;

        // Bob NPC walking
        entity.bob += 0.08;

        // Move NPC within their boundaries
        let nx = entity.x + entity.vx;
        let ny = entity.y + entity.vy;

        // Boundary collision check
        if (nx < entity.paceMinX || nx > entity.paceMaxX || MAP_GRID[Math.floor(entity.y)][Math.floor(nx)] > 1) {
          entity.vx = -entity.vx;
          nx = entity.x + entity.vx;
        }
        if (ny < entity.paceMinY || ny > entity.paceMaxY || MAP_GRID[Math.floor(ny)][Math.floor(entity.x)] > 1) {
          entity.vy = -entity.vy;
          ny = entity.y + entity.vy;
        }

        entity.x = nx;
        entity.y = ny;
      });

      // Update room label label
      const currentRoom = getRoomLabel(playerPos.current.x, playerPos.current.y);
      if (currentRoom !== currentRoomLabel) {
        setCurrentRoomLabel(currentRoom);
      }
    };

    const drawFrame = () => {
      const w = canvas.width;
      const h = canvas.height;

      // Draw background
      ctx.fillStyle = '#050706';
      ctx.fillRect(0, 0, w, h);

      // Camera Offset so player is centered on screen
      const playerScreen = isoToScreen(playerPos.current.x, playerPos.current.y, tileWidth, tileHeight);
      const cameraX = w / 2 - playerScreen.x;
      const cameraY = h / 2 - playerScreen.y;

      // 1. Draw floor tiles & walls
      // Render back-to-front to respect depth sorting
      for (let r = 0; r < MAP_SIZE; r++) {
        for (let c = 0; c < MAP_SIZE; c++) {
          const tileVal = MAP_GRID[r][c];
          const screen = isoToScreen(c, r, tileWidth, tileHeight);
          const drawX = screen.x + cameraX;
          const drawY = screen.y + cameraY;

          // Draw Floor
          if (tileVal === 1 || tileVal === 0) {
            drawFloorTile(ctx, drawX, drawY, tileWidth, tileHeight, getTileColor(c, r));
          }

          // Draw Wall/Column block
          if (tileVal === 2 || tileVal === 3 || tileVal === 4) {
            drawWallBlock(ctx, drawX, drawY, tileWidth, tileHeight, tileVal);
          }
        }
      }

      // 2. Sort and Draw Billboard Entities (NPCs, Player, Items)
      // Sorting key is based on isometric depth: c + r
      const drawEntities = [
        ...ENTITIES,
        {
          id: 'player',
          type: 'player',
          x: playerPos.current.x,
          y: playerPos.current.y,
          label: 'You (Operator)',
          color: '#e6e8eb',
          bob: playerBob.current
        }
      ].map(ent => {
        const screen = isoToScreen(ent.x, ent.y, tileWidth, tileHeight);
        return {
          ...ent,
          screenX: screen.x + cameraX,
          screenY: screen.y + cameraY,
          depth: ent.x + ent.y
        };
      }).sort((a, b) => a.depth - b.depth);

      let closestInteractive = null;
      let minDistance = 1.25;

      drawEntities.forEach(ent => {
        const bobOffset = Math.sin(ent.bob || 0) * 4;

        if (ent.type === 'player') {
          // Draw Player Sprite token
          drawPlayerSprite(ctx, ent.screenX, ent.screenY + bobOffset, ent.color);
        } else if (ent.type === 'npc') {
          // Draw NPC Sprite token
          drawNPCSprite(ctx, ent.screenX, ent.screenY + bobOffset, ent);
          
          // Proximity check
          const dist = Math.sqrt((ent.x - playerPos.current.x)**2 + (ent.y - playerPos.current.y)**2);
          if (dist < minDistance) {
            closestInteractive = ent;
            minDistance = dist;
          }
        } else {
          // Draw Item/Engine Column
          drawItemSprite(ctx, ent.screenX, ent.screenY, ent);
          
          const dist = Math.sqrt((ent.x - playerPos.current.x)**2 + (ent.y - playerPos.current.y)**2);
          if (dist < minDistance) {
            closestInteractive = ent;
            minDistance = dist;
          }
        }
      });

      if (closestInteractive !== activeInteractiveRef.current) {
        setActiveInteractive(closestInteractive);
      }

      const currentRoom = getRoomLabel(playerPos.current.x, playerPos.current.y);
      drawHUDPanel(ctx, w, h, currentRoom);
    };

    const loop = () => {
      updatePhysics();
      drawFrame();
      animFrameId = requestAnimationFrame(loop);
    };

    loop();
    return () => cancelAnimationFrame(animFrameId);
  }, []);

  // Handle resizing of canvas
  useEffect(() => {
    const handleResize = () => {
      const canvas = canvasRef.current;
      const container = containerRef.current;
      if (canvas && container) {
        canvas.width = container.clientWidth;
        canvas.height = container.clientHeight;
      }
    };
    window.addEventListener('resize', handleResize);
    handleResize();
    return () => window.removeEventListener('resize', handleResize);
  }, []);

  return (
    <div ref={containerRef} className="w-full h-full relative bg-[#040605] select-none overflow-hidden">
      <canvas ref={canvasRef} className="w-full h-full block" />

      {/* Proximity Interaction Prompt */}
      {activeInteractive && (
        <div className="absolute left-1/2 bottom-20 -translate-x-1/2 bg-[#15181f]/95 border border-[#c8a96e]/30 px-5 py-3 rounded shadow-2xl glass-panel text-center flex flex-col items-center">
          <span className="text-[#c8a96e] text-[9px] uppercase font-bold tracking-widest">PROXIMITY DETECTED</span>
          <span className="text-white text-xs font-serif font-bold mt-0.5">{activeInteractive.label}</span>
          <span className="text-[#959ea6] text-[10px] italic mt-0.5">{activeInteractive.description}</span>
          <span className="text-[#3fc1c9] text-[10px] font-mono font-bold mt-1.5 animate-pulse">Press [E] to interact</span>
        </div>
      )}

      {/* Floating Room HUD Tag */}
      <div className="absolute top-6 left-6 bg-black/60 border border-[#c8a96e]/20 rounded py-2 px-3 text-xs glass-panel flex flex-col">
        <span className="text-[8px] uppercase tracking-widest text-[#c8a96e] font-bold">Zone Sensor</span>
        <span className="text-white font-serif font-bold mt-0.5 uppercase tracking-wide">{currentRoomLabel}</span>
      </div>

      {/* Floating Reference Art Panel (Opens on NPC talk) */}
      {activeRefArt && (
        <div className="absolute right-6 top-6 w-36 h-48 border border-[#c8a96e]/30 bg-[#0b0c10]/95 rounded p-2 shadow-2xl glass-panel flex flex-col items-center justify-between">
          <div className="flex justify-between items-center w-full px-1 border-b border-[#c8a96e]/10 pb-1 mb-1">
            <span className="text-[8px] uppercase tracking-widest text-[#c8a96e] font-mono">Reference Art</span>
            <button 
              onClick={() => setActiveRefArt(null)}
              className="text-[8px] text-[#959ea6] hover:text-white uppercase font-bold"
            >
              Close
            </button>
          </div>
          <div className="flex-1 w-full overflow-hidden rounded border border-white/5 bg-black flex items-center justify-center">
            <img src={activeRefArt} alt="Reference Guide" className="w-full h-full object-cover" />
          </div>
        </div>
      )}

      {/* CRT Overlay scanlines */}
      <div className="absolute inset-0 pointer-events-none scanlines opacity-10"></div>
    </div>
  );
}

// ─── Isometric Translation Helpers ──────────────────────────────────────────
function isoToScreen(x, y, tileWidth, tileHeight) {
  return {
    x: (x - y) * (tileWidth / 2),
    y: (x + y) * (tileHeight / 2)
  };
}

// Map room grid cells to thematic colors
function getTileColor(x, y) {
  if (y < 5 && x < 5) return '#2e261f'; // Workshop (Mahogany wood)
  if (y < 5 && x >= 8) return '#1b261a'; // Conservatory (Moss Green)
  if (y >= 5 && y <= 8) return '#29352e'; // Gallery (Teal floor)
  if (y > 8 && x < 5) return '#22252a'; // Kitchen (Grey stone tile)
  if (y > 8 && x >= 5 && x <= 8) return '#2c221a'; // Entrance Hall (Rug runner red-brown)
  if (y > 8 && x >= 9) return '#331d23'; // Drawing Room (Velvet crimson floor)
  return '#15181f';
}

// ─── Drawing Helper: Floor Rhombus ──────────────────────────────────────────
function drawFloorTile(ctx, x, y, w, h, fillStyle) {
  ctx.save();
  ctx.fillStyle = fillStyle;
  ctx.strokeStyle = 'rgba(200, 169, 110, 0.08)';
  ctx.lineWidth = 1;

  ctx.beginPath();
  ctx.moveTo(x, y - h / 2);
  ctx.lineTo(x + w / 2, y);
  ctx.lineTo(x, y + h / 2);
  ctx.lineTo(x - w / 2, y);
  ctx.closePath();
  ctx.fill();
  ctx.stroke();
  ctx.restore();
}

// ─── Drawing Helper: Wall/Column Blocks ─────────────────────────────────────
function drawWallBlock(ctx, x, y, w, h, type) {
  const wallHeight = 44;
  
  ctx.save();
  
  // Set Colors based on Wall type
  let topColor = '#242926';
  let leftColor = '#151816';
  let rightColor = '#1e2220';
  let edgeColor = '#c8a96e1a';

  if (type === 3) { // Inner wood wall
    topColor = '#3b2f23';
    leftColor = '#221b14';
    rightColor = '#2d241b';
    edgeColor = '#cd7f3222';
  } else if (type === 4) { // Engine glowing column
    topColor = '#0b201a';
    leftColor = '#05120f';
    rightColor = '#081713';
    edgeColor = '#3fc1c944';
  }

  // Draw Left Face
  ctx.fillStyle = leftColor;
  ctx.beginPath();
  ctx.moveTo(x - w / 2, y);
  ctx.lineTo(x, y + h / 2);
  ctx.lineTo(x, y + h / 2 - wallHeight);
  ctx.lineTo(x - w / 2, y - wallHeight);
  ctx.closePath();
  ctx.fill();

  // Draw Right Face
  ctx.fillStyle = rightColor;
  ctx.beginPath();
  ctx.moveTo(x, y + h / 2);
  ctx.lineTo(x + w / 2, y);
  ctx.lineTo(x + w / 2, y - wallHeight);
  ctx.lineTo(x, y + h / 2 - wallHeight);
  ctx.closePath();
  ctx.fill();

  // Draw Top Face
  ctx.fillStyle = topColor;
  ctx.beginPath();
  ctx.moveTo(x, y - wallHeight - h / 2);
  ctx.lineTo(x + w / 2, y - wallHeight);
  ctx.lineTo(x, y - wallHeight + h / 2);
  ctx.lineTo(x - w / 2, y - wallHeight);
  ctx.closePath();
  ctx.fill();

  // Draw glowing wireframe edge outline
  ctx.strokeStyle = edgeColor;
  ctx.lineWidth = 1;
  ctx.beginPath();
  ctx.moveTo(x - w / 2, y - wallHeight);
  ctx.lineTo(x, y + h / 2 - wallHeight);
  ctx.lineTo(x + w / 2, y - wallHeight);
  ctx.lineTo(x, y - wallHeight - h / 2);
  ctx.closePath();
  ctx.moveTo(x, y + h / 2 - wallHeight);
  ctx.lineTo(x, y + h / 2);
  ctx.stroke();

  ctx.restore();
}

// ─── Drawing Helper: Player Avatar Token ────────────────────────────────────
function drawPlayerSprite(ctx, x, y, color) {
  ctx.save();

  // Glow ring
  ctx.shadowColor = '#3fc1c9';
  ctx.shadowBlur = 10;
  
  // Outer circle ring
  ctx.strokeStyle = '#3fc1c9';
  ctx.lineWidth = 2.5;
  ctx.beginPath();
  ctx.arc(x, y - 24, 11, 0, Math.PI * 2);
  ctx.stroke();
  
  ctx.shadowBlur = 0;

  // Outer Token fill
  ctx.fillStyle = '#0b0c10';
  ctx.beginPath();
  ctx.arc(x, y - 24, 10, 0, Math.PI * 2);
  ctx.fill();

  // Silhouette avatar outline (Rowan)
  ctx.fillStyle = '#e6e8eb';
  ctx.beginPath();
  ctx.arc(x, y - 26, 4.5, 0, Math.PI * 2); // Head
  ctx.fill();
  ctx.beginPath();
  ctx.arc(x, y - 18, 7, Math.PI, 0); // Shoulders
  ctx.fill();

  // Tag floating above
  ctx.fillStyle = '#3fc1c9';
  ctx.font = 'bold 8px monospace';
  ctx.textAlign = 'center';
  ctx.fillText("YOU", x, y - 42);

  ctx.restore();
}

// ─── Drawing Helper: NPC Sprite Tokens ──────────────────────────────────────
function drawNPCSprite(ctx, x, y, ent) {
  ctx.save();

  // Glow base ring
  ctx.shadowColor = ent.color || '#fff';
  ctx.shadowBlur = 8;
  ctx.strokeStyle = ent.color || '#fff';
  ctx.lineWidth = 2;
  
  ctx.beginPath();
  ctx.arc(x, y - 24, 12, 0, Math.PI * 2);
  ctx.stroke();

  ctx.shadowBlur = 0;

  // Token clipping path for portrait thumbnails
  ctx.save();
  ctx.beginPath();
  ctx.arc(x, y - 24, 11, 0, Math.PI * 2);
  ctx.clip();
  
  // Draw base background in case image is missing
  ctx.fillStyle = '#0b0c10';
  ctx.fillRect(x - 15, y - 39, 30, 30);

  // Load portrait thumbnail
  const img = new Image();
  img.src = ent.portrait;
  ctx.drawImage(img, x - 13, y - 37, 26, 26);
  ctx.restore();

  // Draw name tag
  ctx.fillStyle = ent.color || '#fff';
  ctx.font = 'bold 8px font-serif';
  ctx.textAlign = 'center';
  ctx.fillText(ent.label.split(' ').pop(), x, y - 42); // Last name only for tag

  ctx.restore();
}

// ─── Drawing Helper: Interactive Items ──────────────────────────────────────
function drawItemSprite(ctx, x, y, ent) {
  ctx.save();
  
  // Draw glowing beacon/spark ring
  ctx.strokeStyle = ent.color || '#3fc1c9';
  ctx.lineWidth = 1.5;
  ctx.beginPath();
  ctx.arc(x, y - 10, 8, 0, Math.PI * 2);
  ctx.stroke();

  ctx.fillStyle = (ent.color || '#3fc1c9') + '33'; // transparent fill
  ctx.beginPath();
  ctx.arc(x, y - 10, 7, 0, Math.PI * 2);
  ctx.fill();

  // Draw item floating tag
  ctx.fillStyle = '#e6e8eb';
  ctx.font = 'bold 7px monospace';
  ctx.textAlign = 'center';
  ctx.fillText(ent.label, x, y - 24);

  ctx.restore();
}

// ─── Drawing Helper: HUD Overlay text ───────────────────────────────────────
function drawHUDPanel(ctx, w, h, roomLabel) {
  ctx.save();

  // Draw bottom status strip
  ctx.fillStyle = 'rgba(11, 12, 16, 0.9)';
  ctx.strokeStyle = 'rgba(200, 169, 110, 0.15)';
  ctx.lineWidth = 1;
  ctx.fillRect(16, h - 48, w - 32, 32);
  ctx.strokeRect(16, h - 48, w - 32, 32);

  // Navigation help text
  ctx.fillStyle = '#959ea6';
  ctx.font = '9px monospace';
  ctx.textAlign = 'left';
  ctx.fillText("KEYS: WASD/Arrows to Move | SHIFT to Run", 32, h - 28);

  ctx.fillStyle = '#c8a96e';
  ctx.font = 'bold 9px monospace';
  ctx.textAlign = 'right';
  ctx.fillText("STATUS: VIRTUAL RECON ONLINE (1985 Hz)", w - 32, h - 28);

  ctx.restore();
}
